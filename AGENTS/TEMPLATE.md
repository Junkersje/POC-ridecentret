# [AGENT-NAVN]

<!-- 
SKABELON TIL MANUEL OPRETTELSE AF NYE AGENTER I SPECKIT
Brug denne skabelon, når du manuelt tildeler et nyt ansvarsområde til en agent.
Husk ALTID at opdatere AGENTS/communication-matrix.json, når du opretter en ny agent!
-->

## Rolle og Ansvarsområde
Kort og præcis beskrivelse af agentens specifikke fokusområde i projektet (f.eks. backend, UI, tests, database, specifikationer).
Agenten må kun beskæftige sig med sit eget domæne.

## Hierarkisk Kommunikationskontrol
Konsulter altid `AGENTS/communication-matrix.json` for gældende regler.

- **Autoriserede afsendere (Inbound)**: Hvilke agenter må sende opgaver til denne agent?
  - F.eks.: `coordinator`, `user`
- **Autoriserede modtagere (Outbound)**: Hvilke agenter må denne agent kalde som værktøjer?
  - F.eks.: `github-manager`
- **Blokeret adgang**: Agenten må IKKE kommunikere med agenter, som ikke eksplicit fremgår af `allowed_outbound` i `communication-matrix.json`.

## Værktøjer og Eksekvering
Hvilke scripts, værktøjer eller kommandoer har denne agent lov til at afvikle direkte?
- [Værktøj 1 / Script]
- [Værktøj 2]

## Delegering og Værktøjskald
Når agenten skal have udført en opgave uden for sit domæne (f.eks. versionstyring), benyttes standardformatet:

```tool_call
agent: "<modtager-agent-fra-allowed-outbound>"
action: "<handling>"
parameters:
  <parameter1>: "<værdi>"
```

