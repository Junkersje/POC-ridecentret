<!--
SYNC IMPACT REPORT
==================
- Version change: 1.0.0 → 1.1.0 (MINOR: materially expanded guidance and domain rules derived from case files)
- Modified principles:
  - II. Domæne- og Dataadskillelse → II. Domæneadskillelse & Fuld Holdkategorisering (udvidet med alle 6 holdtyper, elevprofiler og matchparametre)
  - III. Rent API-Design & Abstraktion → V. Rent API-Design for Fremtidig Flerparts-Arkitektur (skærpet fokus på pilotprojekt for Dansk Rideforbund og udvidelsesparathed)
  - Tidligere I, IV og V omformeret og samlet i princip VI (Klikbar In-Memory POC uden Databasedrift)
- Added principles:
  - I. Dyrevelfærd som Ufravigelig Førsteprioritet (Animal Welfare First - 3-holds loft, fridag, springloft, sygelog, vægtmatch)
  - III. Assisteret Planlægning & Ridelærerens Kontrol (Human-in-the-Loop Scheduling - assistent til 'puslespillet' uden black-box)
  - IV. Én Fælles Sandhedskilde mod Informationskløfter (Single Source of Truth - afskaffelse af uoverensstemmelser mellem stald, kontor og whiteboard)
- Added sections:
  - Tekniske Rammer & Forretningsregler opdateret med de 6 konkrete holdkategorier, velfærdsgrænser og tavs viden-håndtering
- Removed sections:
  - Ingen
- Follow-up TODOs:
  - Ingen
-->

# Bøgegårdens Ridecenter POC Constitution

## Core Principles

### I. Dyrevelfærd som Ufravigelig Førsteprioritet (Animal Welfare First)
Hestens fysiske og mentale trivsel er den højeste prioritet og må aldrig tilsidesættes for administrative bekvemmeligheder.
- Hver hest må højst deltage på 3 lektioner/hold pr. dag. For ældre, unge eller skånede heste skal der kunne fastsættes en lavere individuel grænse (f.eks. maks 2 hold).
- Hver hest MUST have mindst én fast ugentlig fridag uden lektioner.
- Hver hest må højst springes 1 gang om ugen.
- Syge, skadede eller aflastede heste (f.eks. ved halthed eller tabt sko) MUST øjeblikkeligt spærres for tildeling til undervisning.
- Rytterens vægt og højde MUST overholde hestens maksimale bærekapacitet (størrelsesmatch fra lille pony til stor hest).
- Rationale: Hestevelfærd er kernen i Bøgegårdens drift og et ufravigeligt krav fra Dansk Rideforbund og offentligheden; systemet skal aktivt forhindre overbelastning og fejlmatch.

### II. Domæneadskillelse & Fuld Holdkategorisering (Clear Domain Boundaries)
Data og forretningslogik MUST opdeles i velafgrænsede, indbyrdes uafhængige domæner uden cirkulære bindinger:
- **Heste**: Stamdata, bærekapacitet/størrelse, temperament (responsivitet, rolig, frisk/doven), skånehensyn, dagsform og tilgængelighedsstatus.
- **Elever & Ryttere**: Stamdata (alder, højde, vægt), erfaringsniveau, særlige hensyn/rideangst, deltagelseshistorik og hesteønsker (op til 3 heste pr. periode).
- **Elevhold**: De 6 eksplicitte niveauer: `Trækhold`, `Begynder`, `Letøvede`, `Øvede`, `Springhold` og `Parthold`. Hvert hold må have højst 10 elever.
- **Timefordeling & Lektioner**: Tidsplanlægning, fremmøderegistrering og hesteallokering, der forbinder hest og rytter under overholdelse af alle velfærdsregler.
- Rationale: Domæneadskillelse forhindrer sammenfiltret forretningslogik og sikrer, at hestevelfærd, holdadministration og elevønsker kan administreres og valideres uafhængigt.

### III. Assisteret Planlægning & Ridelærerens Kontrol (Human-in-the-Loop Scheduling)
Systemet skal reducere den tunge manuelle byrde ved den månedlige/ugentlige hestefordeling ("puslespillet") uden at umyndiggøre personalet.
- Systemet MUST fungere som en intelligent assistent, der genererer et gennemskueligt **forslag/udkast** til hestefordeling baseret på elevernes ønsker, historik og hestenes begrænsninger.
- Ridelæreren MUST have fuld frihed til at justere, overskrive og godkende fordelingen før offentliggørelse.
- Systemet MUST synliggøre elevønsker og historik (f.eks. hvis en elev gentagne gange har ønsket en hest uden at få den), så fordelingen opleves retfærdig, og systemet ikke gøres til syndebuk.
- Rationale: Ridelærerens relationelle kendskab og pædagogiske erfaring er afgørende for sikkerhed og tryghed; fuldautomatisk "black-box" tildeling skaber utryghed og konflikt.

### IV. Én Fælles Sandhedskilde mod Informationskløfter (Single Source of Truth)
Systemet MUST eliminere de eksisterende uoverensstemmelser mellem staldens A4-mapper, kontorets medlemslister, SMS-beskeder og fysiske whiteboards.
- Staldvisning, fremmødelister, elevstatus og hestetildeling MUST udspringe af én og samme datakilde.
- Akutte ændringer (syge heste, afbud, vikardækning) skal kunne registreres øjeblikkeligt og være tilgængelige for undervisere og hjælperteamet mindst 30 minutter før lektionsstart.
- Fremmøderegistrering MUST kunne dokumenteres præcist som grundlag for kommunal støtte og Dansk Rideforbund.
- Rationale: As-Is processen viser akut stress og overarbejde ved manglende overlevering; en fælles sandhedskilde skaber ro i stalden og sikrer økonomisk compliance.

### V. Rent API-Design for Fremtidig Flerparts-Arkitektur (Extensibility by Contract)
Al datainteraktion og forretningsvalidering MUST formidles via typestærke, asynkrone service- og repository-kontrakter.
- Brugerfladen (UI) må aldrig have direkte adgang til rå lagringsmekanismer.
- Kontrakterne skal muliggøre fremtidig kobling til en forældre-app (ønsker, afbud, prøvetimer), et udvidet hestemanagement-modul og eksterne forbundssystemer uden omskrivning af kerneforretningslogikken.
- Rationale: Bøgegårdens Ridecenter fungerer som pilotprojekt for Dansk Rideforbund; arkitekturen skal være forberedt til modulær skalering.

### VI. Klikbar In-Memory POC uden Databasedrift (Zero-Friction Prototype)
I denne POC-fase MUST løsningen implementeres som en letvægts, klikbar prototype uden eksterne databaser eller komplekse serverinstallationer.
- Data MUST håndteres via in-memory repositories eller lokal browser-persistens med realistiske, deterministiske testdata (fixtures baseret på casens heste, hold og elever).
- Prototypen skal kunne startes og klikkes igennem af alle interessenter uden opsætningskrav.
- Rationale: Hurtig validering af brugerflows, skærmbilleder og beslutningsstøtte med ridelærere og ledelse er vigtigere end produktionsdatabaser i POC-fasen.

## Tekniske Rammer & Forretningsregler

- **De 6 Holdkategorier**: Systemet anerkender eksplicit:
  1. `Trækhold`: Elever trækkes af forældre; de fleste heste kan anvendes.
  2. `Begynder`: Elever rider selv under tæt støtte; kun særligt rolige/tolerante heste tillades.
  3. `Letøvede`: Elever rider på række i trav og galop.
  4. `Øvede`: Elever har individuel kontrol over hesten på ridebanen.
  5. `Springhold`: Specialiseret springundervisning; kun heste godkendt til springning; maks 1 spring pr. hest/uge.
  6. `Parthold`: Fast rytter på fast hest; ventelistehåndtering.
- **Kapacitetsgrænse**: Maksimalt 10 elever pr. hold.
- **Sikkerhed og Matchning**:
  - Hestens max bærekapacitet mod elevens vægt og højde.
  - Hestens temperament (responsiv/sensitiv vs. rolig) mod elevens erfaring og evt. rideangst.
- **Tavs Viden & GDPR-hensyn**:
  - Pædagogiske noter (f.eks. "utryg ved hurtige bevægelser", "behov for trækker ved opstart") skal holdes saglige og direkte relevante for heste- og elevsikkerheden.
- **Repository Pattern**:
  - Datalaget isoleres bag standardiserede serviceinterfaces (`IHorseService`, `IStudentService`, `ITeamService`, `IScheduleService`).

## Udviklingsproces & Kvalitetskrav

- **Velfærds-validering som Quality Gate**: Ingen hestetildeling eller skemaændring må kunne gemmes uden at passere velfærdsreglerne (eller udløse en eksplicit, uafviselig advarsel).
- **Arbejdsgangs-scenarier (BPMN As-Is dækning)**: POC'en skal kunne demonstrere:
  1. Forberedelsesfasen (30 min før start: tjek af hestenes tilstand og dagens plan).
  2. Akuthåndtering (hurtig ombytning af hest ved sygdom/halthed).
  3. Månedlig hestetildeling baseret på ønsker og historik ("puslespillet").
- **Zero-Setup Garanti**: Prototypen skal kunne køres lokalt med standard webværktøjer uden konfiguration af eksterne databaser eller hemmeligheder.

## Governance

- Denne forfatning er den øverste rettesnor for udviklingen af Bøgegårdens Ridecenter POC og pilotprojektet for Dansk Rideforbund.
- **Ændringsprocedure**: Ændringer i principper kræver dokumenteret begrundelse, opdatering af denne fil og godkendelse.
- **Versionspolitik**: Følger Semantic Versioning (MAJOR ved principbrud eller omlægning til produktionsdatabase, MINOR ved nye principper, domæneregler eller holdkategorier, PATCH ved tekstpræciseringer).
- **Compliance**: Alle fremtidige specifikationer, planer og opgaver genereret via Spec Kit MUST overholde disse principper.

**Version**: 1.1.0 | **Ratified**: 2026-10-06 | **Last Amended**: 2026-10-06
