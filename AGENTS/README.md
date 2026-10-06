# Agent Hierarki & Kommunikationskontrol

Dette katalog administrerer definitioner, ansvarsområder og kommunikationsregler for agenterne i projektet.

Hierarkiet er designet efter princippet om **Mindste Privilegium (Least Privilege)** og **Ansvarlig Opdeling (Separation of Concerns)**:
- Domæneagenter (f.eks. `constitution-agent`) må formulere krav og principper, men må **ikke** manipulere Git direkte.
- Eksekveringsagenter (f.eks. `github-manager`) håndterer teknisk eksekvering (commits, scripts), men må **ikke** ændre i forretningslogik eller grundregler.

---

## 1. Kommunikationsmatrix: Hvem må snakke med hvem?

Kommunikationen mellem agenter styres centralt i:
👉 [`AGENTS/communication-matrix.json`](file:///c:/Users/Simon/Documents/EK/3sem/POC-ridecentret/AGENTS/communication-matrix.json)

Her er den aktuelle tilladelsesmatrix:

| Agent | Må kaldes af (Inbound) | Må kalde videre til (Outbound) | Tilladte Værktøjer |
| :--- | :--- | :--- | :--- |
| **`constitution-agent`** | `user` | `github-manager` | `.specify/memory/constitution.md` |
| **`github-manager`** | `constitution-agent`, `user` | *(Ingen - leaf worker)* | `scripts/commit_tool.ps1` |

### Sådan ændrer du tilladelser
Hvis du ønsker at give en ny agent adgang til at kalde `github-manager`, eller hvis du vil spærre en eksisterende agents adgang:
1. Åbn [`AGENTS/communication-matrix.json`](file:///c:/Users/Simon/Documents/EK/3sem/POC-ridecentret/AGENTS/communication-matrix.json).
2. Tilføj eller fjern blot navnet i listen `allowed_outbound` for afsenderen, eller i `allowed_inbound` for modtageren.
3. Hvis et opkald ikke er registreret i matricen, vil modtageragenten afvise handlingen med en `[BLOCKED]`-meddelelse.

---

## 2. Manuel oprettelse af nye agenter (Spec Kit integration)

Der oprettes **ikke** nye agenter automatisk. Du har 100% kontrol over at oprette og tildele hver enkelt agent et ansvarsområde manuelt.

Når du vil tilføje en ny agent (f.eks. `frontend-agent`, `schedule-agent` el.lign.):

1. **Tag udgangspunkt i skabelonen**:
   Kopiér [`AGENTS/TEMPLATE.md`](file:///c:/Users/Simon/Documents/EK/3sem/POC-ridecentret/AGENTS/TEMPLATE.md) til `AGENTS/<nyt-agent-navn>.md`.
2. **Definer ansvarsområde**:
   Beskriv præcist, hvad agenten må og ikke må i forhold til projektets forfatning og Spec Kit.
3. **Opdater kommunikationsmatricen**:
   Indsæt agenten i [`AGENTS/communication-matrix.json`](file:///c:/Users/Simon/Documents/EK/3sem/POC-ridecentret/AGENTS/communication-matrix.json) med:
   - `allowed_inbound`: Hvem må give opgaver til denne agent.
   - `allowed_outbound`: Hvilke andre agenter denne agent må kalde som værktøjer.

---

## 3. Standardiseret Format for Værktøjskald

Når en overordnet agent (som `constitution-agent`) skal have udført en handling hos en underordnet agent (som `github-manager`), sendes kaldet i følgende format:

```tool_call
agent: "github-manager"
action: "request_git_commit"
parameters:
  files:
    - ".specify/memory/constitution.md"
  commit_message: "docs(constitution): <beskrivelse af ændringen>"
```

---

## 4. Test og Verificering af Kæden

1. **Constitution Agenten udfører sit arbejde**:
   Opdatering foretages i `.specify/memory/constitution.md`.
2. **Uddelegering**:
   Agenten spytter ovenstående `tool_call` ud i stedet for selv at udføre git-kommandoer.
3. **GitHub Manager Eksekverer**:
   GitHub Manager modtager kaldet, verificerer afsenderen i `communication-matrix.json`, validerer fil og besked, og eksekverer:
   ```powershell
   powershell -ExecutionPolicy Bypass -File ./scripts/commit_tool.ps1 -CommitMessage "docs(constitution): ..." -Files ".specify/memory/constitution.md"
   ```
4. **Verificering**:
   Kør `git log -1` for at bekræfte, at commitet er oprettet med den aftalte besked.

