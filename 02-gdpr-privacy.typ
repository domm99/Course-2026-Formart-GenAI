#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [02 - Privacy, GDPR e uso responsabile dei dati],
    subtitle: [AI Generativa e Prompt Engineering @ FORMart 2026],
    author: author_list(
      (
        (first_author("Davide Domini"), "davide.domini@unibo.it"),
      )
    ),
    date: datetime.today().display("[day] [month repr:long] [year]"),
    //institution: [University of Bologna],
    //logo: align(right)[#image("images/disi.svg", width: 55%)],
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#set raw(tab-size: 4)
#show raw: set text(size: 1em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()


== Obiettivi della lezione

Alla fine della lezione dovreste saper:

- riconoscere dati personali, sensibili, aziendali e riservati;
- capire perché la privacy è un tema centrale nell'uso dell'AI;
- conoscere i concetti base del GDPR;
- distinguere ruoli e responsabilità nel trattamento dei dati;
- capire cosa si può e non si può inserire in un prompt;
- usare una checklist pratica prima di condividere dati con strumenti AI.

---

== Parte 1 — Perché parlare di privacy?

=== Idea chiave

Quando usiamo strumenti AI, spesso copiamo dentro:

- testi;
- email;
- documenti;
- dati clienti;
- dati aziendali;
- informazioni personali;
- informazioni riservate.

#alert[Il problema non è solo cosa produce l'AI, ma anche cosa le diamo in input.]

---

== Privacy non significa “nascondere tutto”

Privacy significa soprattutto:

- controllo sui propri dati;
- uso corretto delle informazioni;
- trasparenza;
- sicurezza;
- rispetto delle finalità;
- responsabilità di chi tratta i dati.

#alert[La privacy è un modo per usare i dati in modo corretto, non un divieto assoluto di usarli.]

---

== Perché è importante in azienda

In azienda i dati possono riguardare:

- clienti;
- dipendenti;
- fornitori;
- pazienti;
- studenti;
- utenti;
- partner;
- processi interni;
- strategie commerciali.

#alert[Un uso sbagliato dei dati può danneggiare persone, aziende e reputazione.]

---

== Esempio semplice

Una email di reclamo può contenere:

- nome del cliente;
- indirizzo email;
- numero d'ordine;
- indirizzo di consegna;
- problema riscontrato;
- tono emotivo;
- informazioni economiche;
- allegati.

#alert[Prima di incollarla in un chatbot, dobbiamo chiederci: posso farlo?]

---

== La domanda centrale

Ogni volta che vogliamo usare l'AI con dati reali, dobbiamo chiederci:

#alert[Sto condividendo informazioni che non dovrei condividere?]

Questa domanda vale per:

- chatbot pubblici;
- strumenti aziendali;
- plugin;
- estensioni browser;
- traduttori online;
- strumenti di riassunto documenti;
- strumenti di trascrizione audio.

---

== Dato utile vs dato rischioso

Un dato può essere molto utile per lavorare meglio.

Ma può essere anche rischioso se:

- identifica una persona;
- rivela informazioni sensibili;
- contiene segreti aziendali;
- è protetto da contratto;
- è coperto da obblighi di riservatezza;
- viene inviato a un servizio non autorizzato.

---

== Dati e fiducia

La fiducia di clienti, colleghi e cittadini dipende anche da come trattiamo i loro dati.

Se un'organizzazione gestisce male i dati, può perdere:

- reputazione;
- clienti;
- credibilità;
- possibilità commerciali;
- fiducia interna;
- conformità normativa.

#alert[La privacy è anche un tema di qualità professionale.]

---

== Privacy e AI generativa

L'AI generativa rende il problema più importante perché:

- è facile copiare grandi quantità di testo;
- spesso non sappiamo bene dove finiscono i dati;
- gli strumenti sono molto accessibili;
- gli output sembrano innocui;
- le persone tendono a condividere più del necessario;
- gli strumenti possono conservare cronologia o metadati.

---

== Attività breve

=== Domanda

Quali informazioni non dovreste mai incollare in un chatbot pubblico?

Pensate a:

- persone;
- clienti;
- documenti;
- email;
- contratti;
- immagini;
- dati economici;
- dati sanitari.

---

== Parte 2 — Che cos'è un dato personale?

=== Definizione pratica

Un dato personale è una qualunque informazione che riguarda una persona identificata o identificabile.

Esempi:

- nome e cognome;
- email;
- numero di telefono;
- indirizzo;
- codice fiscale;
- numero documento;
- matricola;
- identificativo cliente.

---

== Persona identificata

Una persona è identificata quando il dato dice chiaramente chi è.

Esempio:

#raw(block: true, lang: "txt", "Mario Rossi ha acquistato il prodotto X il 12 marzo.")

Qui il dato identifica direttamente Mario Rossi.

---

== Persona identificabile

Una persona è identificabile anche se il nome non è scritto direttamente.

Esempio:

#raw(block: true, lang: "txt", "Il responsabile acquisti della filiale di Bologna ha chiesto uno sconto speciale.")

Magari il nome non c'è, ma in quel contesto potrebbe essere facile capire chi è.

---

== Identificatori diretti

Identificano una persona in modo esplicito.

Esempi:

- nome e cognome;
- codice fiscale;
- numero documento;
- email personale;
- numero di telefono;
- foto del volto;
- firma;
- account personale.

---

== Identificatori indiretti

Non identificano sempre da soli, ma possono farlo se combinati.

Esempi:

- reparto;
- ruolo;
- sede;
- data di nascita;
- numero d'ordine;
- indirizzo IP;
- targa;
- cronologia acquisti;
- dettagli molto specifici di una situazione.

---

== Dato personale o no?

#raw(block: true, lang: "txt", "Cliente 4587 ha segnalato un problema al prodotto.")

Dipende dal contesto.

Se in azienda esiste una tabella che collega “Cliente 4587” a una persona reale, allora può essere dato personale.

#alert[Il contesto conta moltissimo.]

---

== Dati particolari

Alcuni dati personali sono particolarmente delicati.

Esempi:

- salute;
- origine razziale o etnica;
- opinioni politiche;
- convinzioni religiose;
- dati biometrici;
- vita sessuale o orientamento sessuale;
- appartenenza sindacale.

#alert[Questi dati richiedono protezioni più forti.]

---

== Dati giudiziari

Esistono anche dati relativi a:

- condanne penali;
- reati;
- procedimenti;
- misure di sicurezza.

Sono dati molto delicati e devono essere trattati solo quando esiste una base giuridica adeguata.

---

== Dati aziendali non personali

Non tutti i dati aziendali sono personali.

Esempi:

- fatturato aggregato;
- listino prodotti;
- codice articolo;
- quantità in magazzino;
- consumo energetico di una macchina;
- tempi medi di produzione;
- manuale tecnico senza riferimenti personali.

---

== Ma attenzione

Anche dati non personali possono essere riservati.

Esempi:

- margini commerciali;
- strategie aziendali;
- offerte non pubbliche;
- disegni CAD;
- contratti;
- procedure interne;
- dati di produzione;
- roadmap prodotti.

#alert[Privacy e riservatezza aziendale sono collegate, ma non sono la stessa cosa.]

---

== Dato personale vs dato riservato

=== Dato personale

Riguarda una persona.

Esempio:

#raw(block: true, lang: "txt", "Luca Bianchi, luca.bianchi@example.com")

=== Dato riservato

Riguarda informazioni interne o confidenziali.

Esempio:

#raw(block: true, lang: "txt", "Sconto speciale del 32% per il cliente strategico X")

---

== Dato anonimo

Un dato è anonimo quando non permette più di risalire alla persona.

Esempio:

#raw(block: true, lang: "txt", "Nel mese di marzo sono arrivati 43 reclami per ritardi di consegna.")

Qui non sappiamo chi siano le persone coinvolte.

---

== Dato pseudonimizzato

Un dato è pseudonimizzato quando gli identificativi sono sostituiti da codici.

Esempio:

#raw(block: true, lang: "txt", "Cliente A17 ha richiesto assistenza per il prodotto P9.")

Attenzione: se qualcuno possiede la tabella che collega A17 alla persona reale, il dato resta personale.

---

== Anonimizzazione vs pseudonimizzazione

=== Anonimizzazione

Non si può più risalire alla persona.

=== Pseudonimizzazione

Si riduce il rischio, ma la persona può ancora essere identificata con informazioni aggiuntive.

#alert[Per usare l'AI, spesso la pseudonimizzazione è utile, ma non sempre basta.]

---

== Esercizio rapido

=== Classificate

Sono dati personali, particolari, aziendali riservati o anonimi?

- nome cliente;
- fatturato totale mensile;
- certificato medico;
- listino riservato;
- indirizzo email;
- numero di ticket;
- reclami aggregati per mese;
- disegno tecnico di un prodotto.

---

== Parte 3 — Che cosa significa “trattare” dati?

=== Idea semplice

Trattare dati significa fare qualunque operazione sui dati.

Non solo venderli o pubblicarli.

Anche semplicemente conservarli o leggerli può essere trattamento.

---

== Esempi di trattamento

Sono trattamento:

- raccogliere dati;
- registrare dati;
- archiviare dati;
- modificare dati;
- consultare dati;
- inviare dati;
- cancellare dati;
- organizzare dati;
- analizzare dati;
- caricare dati in uno strumento AI.

---

== Caricare dati in AI è trattamento

Quando copiamo una email in un chatbot, stiamo facendo almeno queste operazioni:

- selezione del testo;
- trasmissione a un servizio;
- elaborazione automatica;
- possibile conservazione nella cronologia;
- generazione di un nuovo contenuto.

#alert[Anche un'azione apparentemente semplice può avere implicazioni privacy.]

---

== Esempio: riassunto di un documento

Caso:

#raw(block: true, lang: "txt", "Carico un PDF con dati clienti in uno strumento online per farmelo riassumere.")

Domande:

- ho l'autorizzazione?
- il documento contiene dati personali?
- contiene dati sensibili?
- lo strumento è approvato dall'azienda?
- i dati vengono conservati?
- dove vengono trattati?

---

== Minimizzare il trattamento

Prima di usare dati reali con l'AI, chiedersi:

- mi serve davvero tutto il documento?
- posso rimuovere nomi e riferimenti?
- posso usare un estratto?
- posso descrivere il problema senza allegare il file?
- posso usare dati fittizi?
- posso usare dati aggregati?

#alert[Meno dati condivido, minore è il rischio.]

---

== Parte 4 — Introduzione al GDPR

=== Cos'è il GDPR

Il GDPR è il Regolamento Generale sulla Protezione dei Dati dell'Unione Europea.

Stabilisce regole per il trattamento dei dati personali.

Si applica a organizzazioni pubbliche e private quando trattano dati personali in ambito regolato dal diritto europeo.

---

== Perché esiste il GDPR

Il GDPR nasce per:

- proteggere le persone;
- dare regole comuni in Europa;
- aumentare trasparenza;
- responsabilizzare aziende e pubbliche amministrazioni;
- dare diritti agli interessati;
- regolare l'uso dei dati nel mondo digitale.

---

== GDPR: idea di fondo

Il GDPR non dice:

#raw(block: true, lang: "txt", "Non si possono usare dati personali.")

Dice piuttosto:

#raw(block: true, lang: "txt", "Si possono trattare dati personali solo rispettando regole, finalità, limiti, diritti e responsabilità.")

---

== Il GDPR riguarda anche l'AI

Se uno strumento AI tratta dati personali, allora bisogna considerare il GDPR.

Esempi:

- chatbot con dati clienti;
- classificazione automatica di CV;
- riassunto di cartelle cliniche;
- analisi di performance dei dipendenti;
- profilazione commerciale;
- generazione di risposte basate su ticket reali.

---

== I 7 principi GDPR

I principi fondamentali sono:

1. liceità, correttezza e trasparenza;
2. limitazione della finalità;
3. minimizzazione dei dati;
4. esattezza;
5. limitazione della conservazione;
6. integrità e riservatezza;
7. responsabilizzazione.

---

== Principio 1 — Liceità

Il trattamento deve avere una base giuridica.

In pratica:

#raw(block: true, lang: "txt", "Non posso trattare dati personali solo perché mi è comodo.")

Deve esserci una ragione legittima prevista dalle regole.

---

== Principio 1 — Correttezza

Il trattamento deve essere corretto verso la persona.

Domande pratiche:

- la persona si aspetterebbe questo uso dei dati?
- il trattamento può danneggiarla?
- sto usando i dati in modo ingannevole?
- sto facendo qualcosa di sproporzionato?

---

== Principio 1 — Trasparenza

Le persone devono sapere come vengono usati i loro dati.

In pratica bisogna comunicare:

- chi tratta i dati;
- per quale scopo;
- per quanto tempo;
- con chi vengono condivisi;
- quali diritti ha la persona.

---

== Principio 2 — Limitazione della finalità

I dati devono essere raccolti per uno scopo preciso.

Esempio:

#raw(block: true, lang: "txt", "Raccolgo l'indirizzo email per inviare la ricevuta.")

Non posso poi usarlo automaticamente per scopi completamente diversi senza una base adeguata.

---

== Finalità e AI

Domanda critica:

#raw(block: true, lang: "txt", "Il dato è stato raccolto per essere inserito in uno strumento AI?")

Spesso la risposta è no.

Quindi serve valutare se il nuovo uso è compatibile, autorizzato e proporzionato.

---

== Principio 3 — Minimizzazione

Si devono usare solo i dati necessari.

Esempio sbagliato:

#raw(block: true, lang: "txt", "Carico tutto il fascicolo cliente per scrivere una semplice email di sollecito.")

Esempio migliore:

#raw(block: true, lang: "txt", "Uso solo importo, scadenza e tono desiderato, senza dati personali non necessari.")

---

== Principio 4 — Esattezza

I dati devono essere accurati e aggiornati.

Un dato sbagliato può portare a:

- decisioni sbagliate;
- comunicazioni errate;
- danni alla persona;
- problemi amministrativi;
- output AI scorretti.

#alert[Se l'input è sbagliato, anche l'AI può produrre risultati sbagliati.]

---

== Principio 5 — Limitazione della conservazione

I dati non dovrebbero essere conservati più a lungo del necessario.

Domande pratiche:

- per quanto tempo restano nella piattaforma?
- restano nella cronologia?
- vengono usati per training?
- possono essere cancellati?
- chi può accedervi?

---

== Principio 6 — Integrità e riservatezza

I dati devono essere protetti da:

- accessi non autorizzati;
- perdita;
- modifica illegittima;
- distruzione accidentale;
- diffusione non autorizzata.

Questo riguarda anche:

- password;
- permessi;
- dispositivi;
- piattaforme cloud;
- strumenti AI.

---

== Principio 7 — Accountability

Accountability significa responsabilizzazione.

L'organizzazione deve non solo rispettare le regole, ma anche poterlo dimostrare.

Esempi:

- policy interne;
- registro trattamenti;
- valutazioni di rischio;
- formazione;
- procedure;
- controlli;
- documentazione delle scelte.

---

== Riassunto dei principi

#raw(block: true, lang: "txt", "Usa dati personali solo quando serve.
Spiega perché li usi.
Usane il meno possibile.
Tienili corretti.
Non conservarli inutilmente.
Proteggili.
Sii in grado di dimostrare ciò che fai.")

---

== Parte 5 — Basi giuridiche

=== Perché servono

Per trattare dati personali serve una base giuridica.

Non basta dire:

#raw(block: true, lang: "txt", "Mi serve per lavorare meglio.")

Serve capire quale fondamento legittima il trattamento.

---

== Le principali basi giuridiche

Le basi giuridiche principali sono:

- consenso;
- contratto;
- obbligo legale;
- interesse vitale;
- compito di interesse pubblico;
- legittimo interesse.

#alert[Non tutte sono adatte a tutti i casi.]

---

== Consenso

Il consenso deve essere:

- libero;
- specifico;
- informato;
- inequivocabile;
- revocabile.

Esempio:

#raw(block: true, lang: "txt", "Accetto di ricevere comunicazioni promozionali via email.")

---

== Contratto

Il trattamento può essere necessario per eseguire un contratto.

Esempio:

- uso l'indirizzo per spedire un prodotto;
- uso l'email per inviare una conferma ordine;
- uso dati di pagamento per completare un acquisto.

---

== Obbligo legale

Alcuni dati devono essere trattati perché lo impone la legge.

Esempi:

- fatturazione;
- contabilità;
- obblighi fiscali;
- sicurezza sul lavoro;
- documentazione amministrativa obbligatoria.

---

== Legittimo interesse

Può essere usato quando l'organizzazione ha un interesse legittimo, ma va bilanciato con diritti e libertà delle persone.

Domande:

- l'interesse è reale?
- il trattamento è necessario?
- la persona può aspettarselo?
- il rischio è proporzionato?

---

== Basi giuridiche e AI

Prima di usare AI su dati personali chiedersi:

- qual era la base giuridica originaria?
- il nuovo uso è compatibile?
- sto cambiando finalità?
- serve informare le persone?
- serve una valutazione di rischio?
- lo strumento è autorizzato?

---

== Parte 6 — Ruoli e responsabilità

=== Attori principali

Nel GDPR troviamo alcuni ruoli importanti:

- interessato;
- titolare del trattamento;
- responsabile del trattamento;
- autorizzato al trattamento;
- DPO, se previsto.

---

== Interessato

L'interessato è la persona a cui si riferiscono i dati.

Esempi:

- cliente;
- dipendente;
- studente;
- paziente;
- fornitore persona fisica;
- utente di un servizio.

---

== Titolare del trattamento

Il titolare decide:

- perché trattare i dati;
- quali dati trattare;
- con quali mezzi;
- per quanto tempo;
- con quali soggetti condividerli.

Esempio:

#raw(block: true, lang: "txt", "L'azienda che decide di usare un CRM per gestire i clienti.")

---

== Responsabile del trattamento

Il responsabile tratta dati per conto del titolare.

Esempio:

- fornitore cloud;
- piattaforma software;
- servizio di payroll;
- consulente esterno;
- servizio AI aziendale.

#alert[Non ogni fornitore è automaticamente responsabile: dipende dal rapporto e dal contratto.]

---

== Autorizzato al trattamento

È la persona interna che tratta dati seguendo istruzioni.

Esempi:

- impiegato amministrativo;
- addetto HR;
- operatore customer service;
- tecnico;
- docente;
- segreteria.

---

== DPO

Il DPO, Data Protection Officer, è una figura che supporta e sorveglia la conformità privacy quando prevista.

Può aiutare su:

- valutazioni di rischio;
- policy;
- formazione;
- rapporti con autorità;
- gestione di richieste e incidenti.

---

== Esempio: chatbot pubblico

Caso:

#raw(block: true, lang: "txt", "Un dipendente copia dati clienti in un chatbot pubblico non approvato.")

Possibili problemi:

- mancanza di autorizzazione;
- trasferimento dati non controllato;
- rischio di conservazione;
- assenza di contratto adeguato;
- violazione policy aziendale.

---

== Esempio: strumento AI aziendale

Caso:

#raw(block: true, lang: "txt", "L'azienda fornisce uno strumento AI integrato nel proprio ambiente di lavoro.")

È più controllabile se:

- esiste contratto;
- ci sono impostazioni privacy;
- ci sono policy interne;
- gli accessi sono gestiti;
- i log sono controllati;
- i dati non vengono usati impropriamente.

---

== Parte 7 — Diritti delle persone

=== Perché contano

Il GDPR dà alle persone diritti sui propri dati.

Questo significa che i dati non sono semplicemente “proprietà” dell'azienda che li conserva.

#alert[Le persone mantengono diritti sulle informazioni che le riguardano.]

---

== Diritto di informazione

La persona ha diritto a sapere:

- chi tratta i dati;
- per quale motivo;
- quali dati sono trattati;
- per quanto tempo;
- a chi sono comunicati;
- quali diritti può esercitare.

---

== Diritto di accesso

La persona può chiedere quali dati sono trattati su di lei.

Esempio:

#raw(block: true, lang: "txt", "Quali dati avete su di me nel vostro sistema clienti?")

---

== Diritto di rettifica

La persona può chiedere di correggere dati errati.

Esempio:

#raw(block: true, lang: "txt", "Il mio indirizzo è cambiato.
Vi chiedo di aggiornare i vostri archivi.")

---

== Diritto alla cancellazione

In alcuni casi la persona può chiedere la cancellazione dei propri dati.

Non è sempre automatico.

Esempio:

- possibile quando i dati non servono più;
- non possibile se esiste un obbligo legale di conservarli.

---

== Diritto alla limitazione

La persona può chiedere di limitare temporaneamente il trattamento in certi casi.

Esempio:

#raw(block: true, lang: "txt", "Contesto l'esattezza dei dati: nel frattempo limitate il trattamento.")

---

== Diritto alla portabilità

In alcuni casi la persona può ricevere i dati in un formato strutturato e trasferirli a un altro fornitore.

Esempio:

- cambio di servizio;
- trasferimento dati da una piattaforma all'altra.

---

== Diritto di opposizione

La persona può opporsi ad alcuni trattamenti, ad esempio in certe attività di marketing o profilazione.

Domanda pratica:

#raw(block: true, lang: "txt", "La persona può ragionevolmente dire: non usate più i miei dati per questo scopo?")

---

== Decisioni automatizzate

Il GDPR prevede tutele anche rispetto a decisioni basate solo su trattamenti automatizzati, incluse forme di profilazione, quando producono effetti giuridici o significativi sulla persona.

Esempi delicati:

- credito;
- selezione del personale;
- assicurazioni;
- accesso a servizi;
- valutazioni di rischio.

---

== AI e diritti

Se un sistema AI usa dati personali, dobbiamo chiederci:

- la persona è informata?
- può esercitare i propri diritti?
- c'è intervento umano?
- la decisione è spiegabile?
- ci sono rischi di discriminazione?
- i dati sono corretti?

---

== Parte 8 — Data breach

=== Che cos'è

Un data breach è una violazione di sicurezza che porta accidentalmente o illecitamente a:

- distruzione;
- perdita;
- modifica;
- divulgazione non autorizzata;
- accesso non autorizzato a dati personali.

---

== Esempi di data breach

- email inviata al destinatario sbagliato;
- laptop rubato senza cifratura;
- password condivisa;
- database esposto online;
- allegato con dati personali mandato a gruppo errato;
- account compromesso;
- documento caricato su piattaforma non autorizzata.

---

== AI e data breach

Un uso improprio dell'AI può contribuire a un data breach.

Esempio:

#raw(block: true, lang: "txt", "Un dipendente carica un file clienti con dati personali e sensibili in un tool online non approvato.")

Il problema non è solo il contenuto generato, ma anche la trasmissione dei dati.

---

== Cosa fare se succede

In caso di possibile incidente:

- non ignorare il problema;
- non cancellare prove senza indicazioni;
- avvisare subito il referente interno;
- seguire la procedura aziendale;
- documentare cosa è successo;
- non tentare soluzioni improvvisate.

#alert[La rapidità è importante.]

---

== Parte 9 — AI online: rischi concreti

=== Perché gli strumenti AI sono rischiosi

Sono facili da usare.

Questo è un vantaggio, ma anche un rischio.

Basta copiare e incollare:

- email;
- documenti;
- report;
- contratti;
- dati clienti;
- dati interni.

---

== Rischio 1 — Condivisione non autorizzata

Quando inviamo dati a un servizio esterno, potremmo condividerli con un soggetto non autorizzato.

Domande:

- l'azienda ha approvato questo strumento?
- esiste un contratto?
- è previsto dal ruolo?
- ci sono istruzioni interne?

---

== Rischio 2 — Conservazione dei dati

Alcuni strumenti possono conservare:

- prompt;
- risposte;
- cronologia;
- file caricati;
- metadati;
- log tecnici.

Domanda:

#raw(block: true, lang: "txt", "Per quanto tempo restano questi dati? Chi può accedervi?")

---

== Rischio 3 — Uso per addestramento

Alcuni servizi potrebbero usare dati degli utenti per migliorare i modelli, secondo condizioni e impostazioni specifiche.

Domande:

- i dati vengono usati per training?
- l'impostazione si può disattivare?
- il piano aziendale lo esclude?
- cosa dice il contratto?

---

== Rischio 4 — Trasferimento fuori UE

Usare servizi online può comportare trattamenti o trasferimenti internazionali.

Domande:

- dove sono conservati i dati?
- chi li tratta?
- esistono garanzie adeguate?
- il fornitore è conforme?

---

== Rischio 5 — Output apparentemente innocui

Anche se l'output sembra generico, l'input può essere stato rischioso.

Esempio:

#raw(block: true, lang: "txt", "Ho incollato un contratto riservato per farmi scrivere un riassunto.")

Il riassunto finale può essere innocuo, ma il problema è aver condiviso il contratto.

---

== Rischio 6 — Allucinazioni

L'AI può inventare informazioni.

In ambito privacy questo è pericoloso perché può:

- generare riferimenti legali inesistenti;
- inventare policy;
- sbagliare valutazioni;
- suggerire comportamenti non conformi;
- dare falsa sicurezza.

#alert[Per temi legali o privacy, l'output va sempre verificato.]

---

== Rischio 7 — Profilazione nascosta

Usare AI su dati personali può portare a profilare persone.

Esempi:

- clienti “a rischio abbandono”;
- dipendenti “poco produttivi”;
- candidati “non adatti”;
- utenti “ad alto valore commerciale”.

#alert[La profilazione può avere effetti significativi e va valutata attentamente.]

---

== Rischio 8 — Bias

Se i dati contengono distorsioni, l'AI può riprodurle.

Esempi:

- selezione del personale;
- credito;
- assicurazioni;
- valutazione performance;
- priorità nell'assistenza;
- controlli automatizzati.

---

== Rischio 9 — Mancanza di controllo umano

Il rischio aumenta quando:

- l'AI produce decisioni automatiche;
- nessuno controlla;
- l'output viene copiato senza revisione;
- si delegano giudizi importanti;
- il sistema viene percepito come “oggettivo”.

---

== Rischio 10 — Shadow AI

Shadow AI significa usare strumenti AI non approvati dall'organizzazione.

Esempi:

- account personali;
- estensioni browser;
- chatbot gratuiti;
- strumenti di traduzione non autorizzati;
- app per riassumere PDF;
- plugin installati senza controllo.

#alert[È uno dei rischi più comuni.]

---

== Parte 10 — Chatbot pubblico, aziendale, locale

=== Non tutti gli strumenti sono uguali

Bisogna distinguere tra:

- chatbot pubblico gratuito;
- account professionale;
- strumento enterprise;
- AI integrata in software aziendale;
- modello installato localmente;
- sistema interno su dati aziendali.

---

== Chatbot pubblico

Vantaggi:

- facile da usare;
- accessibile;
- veloce;
- utile per prove generiche.

Svantaggi:

- poco controllo aziendale;
- rischio di inserire dati non autorizzati;
- condizioni d'uso da verificare;
- gestione cronologia da controllare.

---

== Account aziendale o enterprise

Vantaggi possibili:

- contratti più chiari;
- gestione utenti;
- impostazioni privacy;
- controllo amministrativo;
- log e sicurezza;
- integrazione con policy interne.

Svantaggi:

- costo;
- configurazione;
- serve formazione;
- non elimina automaticamente ogni rischio.

---

== Modello locale

Un modello locale gira su infrastruttura controllata dall'organizzazione o dal dispositivo.

Vantaggi:

- maggiore controllo sui dati;
- minore dipendenza da fornitori esterni;
- possibilità di lavorare offline;
- personalizzazione.

Svantaggi:

- costi tecnici;
- manutenzione;
- prestazioni variabili;
- competenze necessarie;
- aggiornamenti da gestire.

---

== AI interna su documenti aziendali

Un sistema interno può permettere di interrogare documenti aziendali.

Esempi:

- manuali;
- procedure;
- policy;
- FAQ;
- contratti tipo;
- documentazione tecnica.

#alert[Anche se è interno, servono permessi e controllo accessi.]

---

== Regola pratica

Più i dati sono delicati, più serve controllo.

#raw(block: true, lang: "txt", "Dati pubblici → rischio più basso
Dati interni → serve attenzione
Dati personali → serve base e regole
Dati sensibili → rischio alto
Dati strategici → rischio aziendale alto")

---

== Parte 11 — Europa, USA e altri approcci

=== Approccio europeo

In Europa la protezione dei dati personali è considerata un diritto fondamentale.

Il GDPR stabilisce un quadro comune e principi generali validi in tutti gli Stati membri.

---

== Approccio statunitense

Negli Stati Uniti l'approccio è spesso più settoriale.

Ci sono regole diverse per ambiti diversi, ad esempio:

- sanità;
- finanza;
- minori;
- consumatori;
- singoli Stati.

#alert[Non esiste un equivalente unico e generale del GDPR valido allo stesso modo in tutto il sistema USA.]

---

== Altri approcci

Nel mondo esistono modelli diversi:

- alcuni più vicini al modello europeo;
- alcuni più basati sul mercato;
- alcuni più centrati sul controllo statale;
- alcuni in fase di evoluzione.

Con strumenti cloud e AI globali, capire dove e come viaggiano i dati diventa importante.

---

== Perché conta per noi

Molti strumenti digitali sono offerti da aziende internazionali.

Quindi dobbiamo chiederci:

- dove si trova il fornitore?
- dove tratta i dati?
- quali garanzie offre?
- il contratto è adeguato?
- l'uso è compatibile con le regole interne?

---

== Trasferimenti internazionali

Quando dati personali escono dallo Spazio Economico Europeo, servono garanzie adeguate.

Esempi di strumenti giuridici:

- decisioni di adeguatezza;
- clausole contrattuali standard;
- regole vincolanti d'impresa;
- altre garanzie previste.

---

== Parte 12 — AI Act: cenno utile

=== Non è il tema principale di oggi

Il GDPR protegge i dati personali.

L'AI Act riguarda invece la regolazione dei sistemi di AI, soprattutto in base al rischio.

I due temi possono sovrapporsi.

#alert[Un sistema AI può dover rispettare sia regole privacy sia regole specifiche sull'AI.]

---

== Approccio basato sul rischio

L'idea generale dell'AI Act è distinguere usi dell'AI in base al rischio.

Esempi concettuali:

- usi vietati;
- usi ad alto rischio;
- usi con obblighi di trasparenza;
- usi a rischio limitato o minimo.

---

== Perché parlarne ora

Perché in ufficio potremmo usare AI per attività molto diverse:

- scrivere una email;
- riassumere un documento;
- valutare un candidato;
- classificare reclami;
- stimare performance;
- decidere priorità di servizio.

#alert[Non tutte queste attività hanno lo stesso rischio.]

---

== Parte 13 — Cosa non inserire nei prompt

=== Regola generale

Non inserire dati reali se non è necessario e autorizzato.

Da evitare soprattutto:

- dati personali identificativi;
- dati particolari;
- dati sanitari;
- dati finanziari individuali;
- contratti riservati;
- segreti aziendali;
- credenziali;
- documenti interni non pubblici.

---

== Mai inserire credenziali

Non incollare mai:

- password;
- token API;
- chiavi private;
- codici OTP;
- link riservati;
- credenziali temporanee;
- dati di accesso a sistemi aziendali.

#alert[Questo vale per qualunque strumento online, non solo per l'AI.]

---

== Attenzione agli allegati

Gli allegati possono contenere più dati di quanto sembri.

Esempi:

- metadati del file;
- commenti nascosti;
- revisioni;
- firme;
- nomi autori;
- dati in fogli nascosti;
- immagini con informazioni visibili.

---

== Attenzione agli screenshot

Uno screenshot può contenere:

- nomi;
- email;
- numeri ordine;
- dati cliente;
- URL riservati;
- notifiche;
- schede aperte;
- informazioni aziendali.

#alert[Prima di caricare immagini, controllare tutto ciò che è visibile.]

---

== Attenzione alle email inoltrate

Le email inoltrate possono includere:

- thread precedenti;
- indirizzi di molte persone;
- allegati;
- note interne;
- firme;
- numeri di telefono;
- disclaimer;
- informazioni non necessarie.

---

== Attenzione ai documenti lunghi

I documenti lunghi sono rischiosi perché è difficile controllarli completamente.

Prima di caricarli:

- leggere almeno le parti sensibili;
- rimuovere dati personali;
- rimuovere allegati non necessari;
- creare una versione ridotta;
- usare dati fittizi;
- chiedere autorizzazione se serve.

---

== Parte 14 — Come preparare un prompt sicuro

=== Strategia 1: generalizzare

Invece di scrivere:

#raw(block: true, lang: "txt", "Mario Rossi non ha pagato la fattura 1024 da 3.450 euro.")

Meglio:

#raw(block: true, lang: "txt", "Un cliente non ha pagato una fattura scaduta. Scrivi un sollecito cortese.")

---

== Strategia 2: pseudonimizzare

Sostituire nomi e riferimenti.

Esempio:

#raw(block: true, lang: "txt", "Cliente A, fornitore B, prodotto X, città Y.")

Utile quando servono relazioni tra elementi, ma non identità reali.

---

== Strategia 3: ridurre

Non caricare tutto.

Caricare solo:

- il paragrafo rilevante;
- la domanda specifica;
- il contesto minimo;
- i vincoli necessari;
- il formato desiderato.

#alert[Il prompt migliore spesso è anche più breve e più sicuro.]

---

== Strategia 4: usare dati fittizi

Per creare modelli, template o esempi, usare dati inventati.

Esempio:

#raw(block: true, lang: "txt", "Crea un modello di email per un cliente fittizio chiamato Cliente A.")

---

== Strategia 5: separare contenuto e dati

A volte non serve dare il dato reale.

Esempio:

#raw(block: true, lang: "txt", "Ho bisogno di una email formale per comunicare un ritardo.
Il destinatario è un cliente.
Il tono deve essere professionale.
Non includere dettagli specifici.")

---

== Strategia 6: chiedere struttura, non contenuto

Invece di caricare un report riservato, chiedere:

#raw(block: true, lang: "txt", "Dammi una struttura per un report mensile vendite con sezioni, tabelle e indicatori utili.")

Poi si compilano i dati internamente.

---

== Strategia 7: fare controllare all'AI il rischio

Si può chiedere all'AI di aiutare a identificare dati sensibili in un testo.

Ma attenzione:

- non farlo con testi reali se lo strumento non è autorizzato;
- meglio usare esempi fittizi;
- la decisione finale resta umana.

---

== Esempio di prompt sicuro

#raw(block: true, lang: "txt", "Agisci come assistente amministrativo.
Scrivi una email formale per ricordare a un cliente una scadenza di pagamento.
Non usare nomi reali.
Usa placeholder come [NOME CLIENTE], [NUMERO FATTURA], [DATA SCADENZA].
Tono cortese, massimo 120 parole.")

---

== Esempio di prompt rischioso

#raw(block: true, lang: "txt", "Scrivi una email a Mario Rossi, codice fiscale RSSMRA..., telefono..., dicendo che non ha pagato la fattura allegata. Ti incollo anche il contratto completo.")

Problemi:

- dati personali;
- dati fiscali;
- dati economici;
- contratto;
- eccesso di informazioni.

---

== Parte 15 — Checklist prima di usare AI

=== Domanda 1

Sto usando dati personali?

Se sì:

- quali?
- sono necessari?
- posso rimuoverli?
- ho una base per usarli?
- lo strumento è autorizzato?

---

== Checklist — Domanda 2

Ci sono dati particolari o sensibili?

Esempi:

- salute;
- sindacato;
- religione;
- politica;
- dati biometrici;
- dati giudiziari.

#alert[Se sì, fermarsi e chiedere indicazioni.]

---

== Checklist — Domanda 3

Ci sono dati aziendali riservati?

Esempi:

- contratti;
- prezzi;
- margini;
- offerte;
- disegni tecnici;
- procedure;
- roadmap;
- dati fornitori.

---

== Checklist — Domanda 4

Lo strumento è approvato?

Chiedersi:

- è previsto dalla policy aziendale?
- uso account personale o aziendale?
- esiste un contratto?
- ci sono istruzioni?
- il mio ruolo mi autorizza?

---

== Checklist — Domanda 5

Posso ottenere lo stesso risultato con meno dati?

Opzioni:

- anonimizzare;
- pseudonimizzare;
- usare estratti;
- usare dati fittizi;
- chiedere solo una struttura;
- lavorare offline;
- usare strumento interno.

---

== Checklist — Domanda 6

L'output deve essere controllato?

Sì, soprattutto se contiene:

- riferimenti normativi;
- numeri;
- date;
- nomi;
- valutazioni su persone;
- consigli legali;
- decisioni importanti;
- comunicazioni esterne.

---

== Checklist breve da ricordare

#raw(block: true, lang: "txt", "1. Serve davvero questo dato?
2. Posso rimuovere o mascherare qualcosa?
3. Lo strumento è autorizzato?
4. Il dato è personale, sensibile o riservato?
5. Il risultato sarà controllato da una persona?")

---

== Parte 16 — Casi pratici

=== Caso 1: email cliente

Situazione:

#raw(block: true, lang: "txt", "Un cliente invia una email molto lunga con nome, telefono, indirizzo, numero ordine e reclamo.")

Obiettivo:

#raw(block: true, lang: "txt", "Vogliamo farci aiutare dall'AI a scrivere una risposta.")

---

== Caso 1 — Cosa fare

Approccio migliore:

- non incollare tutta l'email;
- rimuovere nome, telefono e indirizzo;
- descrivere il problema in modo generale;
- usare numero ordine solo se necessario e autorizzato;
- chiedere una bozza generica;
- verificare il testo finale.

---

== Caso 1 — Prompt migliorato

#raw(block: true, lang: "txt", "Scrivi una risposta cortese a un cliente che segnala un ritardo di consegna.
Il cliente è irritato e chiede aggiornamenti.
Non includere dati personali.
Tono professionale, massimo 150 parole.
Proponi un aggiornamento entro 24 ore.")

---

== Caso 2: contratto fornitore

Situazione:

#raw(block: true, lang: "txt", "Voglio caricare un contratto con un fornitore per farmi riassumere clausole e rischi.")

Rischi:

- dati aziendali riservati;
- condizioni economiche;
- clausole confidenziali;
- possibili dati personali;
- output legale non affidabile.

---

== Caso 2 — Approccio prudente

Meglio:

- usare uno strumento approvato;
- chiedere autorizzazione;
- rimuovere dati non necessari;
- usare solo sezioni specifiche;
- non chiedere pareri legali definitivi;
- verificare con persona competente.

---

== Caso 3: CV di candidati

Situazione:

#raw(block: true, lang: "txt", "Carico CV di candidati in un tool AI per classificarli automaticamente.")

Rischi:

- dati personali;
- dati potenzialmente sensibili;
- bias;
- decisioni automatizzate;
- discriminazione;
- mancanza di trasparenza.

---

== Caso 3 — Domande da porsi

- i candidati sono informati?
- lo strumento è approvato?
- quali criteri usa?
- c'è controllo umano?
- il sistema può discriminare?
- i dati vengono conservati?
- serve valutazione di impatto?

---

== Caso 4: dati sanitari

Situazione:

#raw(block: true, lang: "txt", "Un operatore vuole riassumere una relazione sanitaria usando un chatbot online.")

Problema:

- dati particolari;
- alto rischio;
- informazioni molto delicate;
- necessità di strumenti e autorizzazioni specifiche.

#alert[Con dati sanitari: massima cautela.]

---

== Caso 5: report vendite

Situazione:

#raw(block: true, lang: "txt", "Voglio farmi aiutare a scrivere il commento di un report vendite mensile.")

Rischio variabile:

- basso se i dati sono aggregati e non riservati;
- medio se ci sono clienti specifici;
- alto se ci sono margini, strategie o dati confidenziali.

---

== Caso 5 — Prompt sicuro

#raw(block: true, lang: "txt", "Aiutami a scrivere un commento per un report vendite.
Usa dati aggregati e fittizi.
Evidenzia andamento generale, possibili cause e prossime azioni.
Tono professionale, adatto a una riunione interna.")

---

== Caso 6: traduzione

Situazione:

#raw(block: true, lang: "txt", "Devo tradurre una comunicazione aziendale riservata con un traduttore online.")

Domande:

- il testo contiene dati personali?
- contiene segreti aziendali?
- il traduttore è approvato?
- posso tradurre una versione anonimizzata?

---

== Caso 7: trascrizione audio

Situazione:

#raw(block: true, lang: "txt", "Registro una riunione e carico l'audio in un servizio AI per ottenere il verbale.")

Rischi:

- voce delle persone;
- contenuti riservati;
- consenso o informativa;
- dati personali nei dialoghi;
- conservazione dell'audio;
- accesso da parte del fornitore.

---

== Caso 8: immagini e OCR

Situazione:

#raw(block: true, lang: "txt", "Carico una foto di un documento per estrarre il testo.")

Attenzione a:

- nomi;
- indirizzi;
- codici;
- firme;
- volti;
- targhe;
- badge;
- informazioni sullo sfondo.

---

== Parte 17 — Esercitazione: pulizia di un testo

=== Testo originale

#raw(block: true, lang: "txt", "Buongiorno,
sono Mario Rossi, codice cliente 83472.
Il mio ordine 2026-5521 doveva arrivare in Via Garibaldi 18 a Bologna.
Il pacco contiene materiale urgente per una visita medica di mia figlia.
Il mio numero è 333 1234567.")

---

== Cosa contiene?

Il testo contiene:

- nome e cognome;
- codice cliente;
- numero ordine;
- indirizzo;
- numero di telefono;
- possibile dato sanitario indiretto;
- informazione su un familiare.

#alert[È un testo molto rischioso da incollare in un tool AI pubblico.]

---

== Versione pulita

#raw(block: true, lang: "txt", "Un cliente segnala che un ordine urgente non è arrivato all'indirizzo previsto.
Chiede un aggiornamento rapido e un contatto da parte dell'assistenza.")

Questa versione conserva il problema operativo, ma rimuove i dettagli personali.

---

== Prompt dopo pulizia

#raw(block: true, lang: "txt", "Scrivi una risposta cortese a un cliente che segnala la mancata consegna di un ordine urgente.
Evita riferimenti a dati personali.
Tono empatico e professionale.
Prometti una verifica con la logistica e un aggiornamento entro la giornata.")

---

== Esercitazione: individuare problemi

=== Testo

#raw(block: true, lang: "txt", "Ti allego il file con tutti i dipendenti, stipendi, assenze e valutazioni. Puoi dirmi chi secondo te è meno produttivo?")

Domande:

- quali dati contiene?
- quali rischi ci sono?
- che tipo di decisione si vuole automatizzare?
- cosa bisognerebbe fare prima?

---

== Possibili problemi

- dati personali dei dipendenti;
- dati economici;
- dati sulle assenze;
- valutazioni personali;
- rischio discriminazione;
- decisione significativa;
- possibile uso non autorizzato;
- assenza di controllo e trasparenza.

---

== Esercitazione: alternativa sicura

Prompt più prudente:

#raw(block: true, lang: "txt", "Aiutami a costruire una griglia generale per analizzare carichi di lavoro e colli di bottiglia in un team.
Non usare dati personali.
Suggerisci indicatori aggregati e domande da discutere con i responsabili.")

---

== Parte 18 — Buone pratiche operative

=== 1. Usare strumenti approvati

Prima di usare un tool AI per lavoro, verificare:

- se è autorizzato;
- con quale account usarlo;
- quali dati sono ammessi;
- quali funzioni sono abilitate;
- quali policy interne si applicano.

---

== Buona pratica 2

=== Separare test e dati reali

Per imparare a usare l'AI:

- usare esempi fittizi;
- creare documenti inventati;
- non usare dati clienti reali;
- non usare casi HR reali;
- non usare contratti veri;
- non usare informazioni confidenziali.

---

== Buona pratica 3

=== Controllare sempre l'output

Controllare:

- fatti;
- numeri;
- nomi;
- date;
- riferimenti normativi;
- tono;
- completezza;
- eventuali dati personali rimasti;
- coerenza con policy aziendali.

---

== Buona pratica 4

=== Non automatizzare decisioni delicate senza controllo

Decisioni delicate:

- assunzioni;
- licenziamenti;
- valutazioni dipendenti;
- credito;
- assicurazioni;
- priorità sanitarie;
- accesso a servizi.

#alert[Qui serve sempre molta cautela e supervisione qualificata.]

---

== Buona pratica 5

=== Tenere traccia

Per usi rilevanti dell'AI può essere utile documentare:

- strumento usato;
- dati usati;
- finalità;
- output prodotto;
- controlli svolti;
- persona responsabile;
- eventuali correzioni.

---

== Buona pratica 6

=== Non confondere comodità e legittimità

Il fatto che uno strumento sia:

- facile;
- gratuito;
- veloce;
- molto utile;
- tecnicamente capace;

non significa che sia automaticamente adatto a trattare dati personali o riservati.

---

== Parte 19 — Mini policy personale

=== Prima di usare AI mi chiedo

#raw(block: true, lang: "txt", "1. Che dati sto condividendo?
2. Sono autorizzato?
3. Posso ridurre o anonimizzare?
4. Lo strumento è approvato?
5. Il risultato può avere effetti su persone?
6. Chi controllerà l'output?")

---

== Mini policy per email

Quando uso AI per email:

- non incollo thread completi se non serve;
- rimuovo nomi e riferimenti;
- uso placeholder;
- controllo tono e contenuto;
- non mando direttamente senza revisione;
- verifico che non siano rimasti dati non voluti.

---

== Mini policy per documenti

Quando uso AI per documenti:

- verifico il livello di riservatezza;
- uso estratti invece del file completo;
- rimuovo dati personali;
- evito documenti legali o sanitari su tool non autorizzati;
- controllo il riassunto;
- non considero l'output come parere ufficiale.

---

== Mini policy per tabelle

Quando uso AI con tabelle:

- rimuovo nomi e identificativi;
- uso dati aggregati;
- elimino colonne non necessarie;
- controllo se ci sono dati sensibili;
- verifico formule e calcoli;
- non condivido file interi senza motivo.

---

== Mini policy per immagini

Quando uso AI con immagini:

- controllo volti;
- controllo targhe;
- controllo badge;
- controllo documenti visibili;
- controllo schermi sullo sfondo;
- controllo metadati se rilevanti.

---

== Parte 20 — AI e cultura aziendale

=== Non basta vietare

Una buona cultura privacy non si basa solo su divieti.

Serve:

- formazione;
- esempi pratici;
- strumenti approvati;
- policy chiare;
- supporto;
- responsabilità condivisa.

---

== Il ruolo dell'utente

Chi usa l'AI deve:

- capire cosa sta condividendo;
- seguire le regole;
- chiedere se ha dubbi;
- ridurre i dati non necessari;
- verificare gli output;
- segnalare incidenti;
- non usare scorciatoie rischiose.

---

== Il ruolo dell'organizzazione

L'organizzazione dovrebbe:

- definire strumenti autorizzati;
- formare le persone;
- creare linee guida;
- gestire contratti con fornitori;
- valutare rischi;
- controllare accessi;
- aggiornare procedure;
- supportare chi lavora.

---

== Privacy by design

Significa pensare alla privacy fin dall'inizio.

Esempio:

- progettare un processo già minimizzando i dati;
- limitare accessi;
- impostare cancellazioni automatiche;
- evitare raccolte inutili;
- usare pseudonimizzazione;
- scegliere strumenti sicuri.

---

== Privacy by default

Significa che le impostazioni predefinite devono essere protettive.

Esempio:

- condivisione disattivata di default;
- accessi minimi;
- cronologia limitata;
- dati non pubblici automaticamente;
- permessi assegnati solo se necessari.

---

== Sicurezza minima quotidiana

Buone abitudini:

- password forti;
- autenticazione a due fattori;
- non condividere account;
- bloccare lo schermo;
- attenzione al phishing;
- usare reti sicure;
- aggiornare software;
- controllare destinatari email.

---

== AI e phishing

L'AI può aiutare anche gli attaccanti a creare:

- email più credibili;
- messaggi personalizzati;
- finte comunicazioni aziendali;
- testi senza errori;
- truffe più convincenti.

#alert[La sicurezza informatica diventa ancora più importante.]

---

== Deepfake e identità

L'AI può generare o modificare:

- immagini;
- voce;
- video;
- documenti;
- messaggi.

Rischi:

- furto identità;
- truffe;
- falsi ordini;
- reputazione;
- disinformazione.

---

== Esempio: finta richiesta urgente

#raw(block: true, lang: "txt", "Ciao, sono il direttore.
Serve fare subito un bonifico urgente al nuovo fornitore.
Non chiamarmi, sono in riunione.")

Domanda:

- come verifichiamo che sia reale?
- esiste una procedura?
- chi autorizza?

---

== Parte 21 — Confronto tra usi a basso e alto rischio

=== Uso a basso rischio

Esempi:

- generare una scaletta generica;
- migliorare tono di un testo senza dati reali;
- creare un template;
- spiegare concetti;
- fare brainstorming;
- scrivere esempi fittizi.

---

== Uso a rischio medio

Esempi:

- riassumere documenti interni;
- analizzare email clienti anonimizzate;
- generare report su dati aggregati;
- aiutare con FAQ interne;
- tradurre testi non sensibili;
- classificare ticket senza dati particolari.

---

== Uso ad alto rischio

Esempi:

- dati sanitari;
- dati HR;
- valutazione persone;
- decisioni su credito;
- grandi quantità di dati personali;
- dati di minori;
- dati giudiziari;
- profilazione;
- documenti strategici.

#alert[In questi casi non si improvvisa.]

---

== Parte 22 — Quiz di ripasso

=== Domanda 1

Un numero cliente è sempre dato personale?

- A. No, mai
- B. Sì, sempre
- C. Dipende se permette di risalire a una persona

#alert[Risposta: C]

---

== Quiz — Domanda 2

Quale principio dice di usare solo i dati necessari?

- A. Trasparenza
- B. Minimizzazione
- C. Conservazione
- D. Esattezza

#alert[Risposta: B]

---

== Quiz — Domanda 3

Posso incollare in un chatbot pubblico un contratto riservato se poi cancello la chat?

- A. Sì, sempre
- B. No, non necessariamente: il rischio resta
- C. Sì, se il contratto è lungo

#alert[Risposta: B]

---

== Quiz — Domanda 4

Pseudonimizzare significa:

- A. rendere impossibile identificare una persona;
- B. sostituire identificativi con codici;
- C. cancellare tutti i dati;
- D. pubblicare i dati.

#alert[Risposta: B]

---

== Quiz — Domanda 5

Quale uso è più prudente?

- A. Caricare tutta l'email reale del cliente
- B. Descrivere il problema senza dati identificativi
- C. Caricare anche gli allegati per completezza

#alert[Risposta: B]

---

== Parte 23 — Laboratorio finale

=== Obiettivo

Trasformare un testo rischioso in un prompt sicuro.

Passaggi:

1. individuare i dati personali;
2. individuare dati sensibili o riservati;
3. rimuovere ciò che non serve;
4. creare una versione pulita;
5. scrivere un prompt utile;
6. controllare l'output.

---

== Testo per laboratorio

#raw(block: true, lang: "txt", "La cliente Laura Verdi, telefono 345 9876543, ha scritto che il pacco con materiale medico per il padre malato non è arrivato. L'ordine 88421 era destinato a Via Roma 22. È molto arrabbiata e minaccia di scrivere una recensione negativa.")

---

== Analisi del testo

Contiene:

- nome e cognome;
- telefono;
- ordine;
- indirizzo;
- informazione sanitaria indiretta;
- stato emotivo;
- possibile dato familiare;
- problema logistico.

---

== Versione pulita per AI

#raw(block: true, lang: "txt", "Una cliente segnala un ritardo nella consegna di un ordine urgente.
È molto insoddisfatta e minaccia una recensione negativa.
Serve una risposta empatica, professionale e orientata alla soluzione.")

---

== Prompt finale

#raw(block: true, lang: "txt", "Scrivi una risposta professionale a una cliente insoddisfatta per un ritardo di consegna.
Non includere dati personali.
Tono empatico, calmo e orientato alla soluzione.
Prometti una verifica immediata con la logistica e un aggiornamento entro la giornata.
Massimo 140 parole.")

---

== Debrief laboratorio

Domande:

- abbiamo rimosso abbastanza dati?
- il prompt è ancora utile?
- ci sono dettagli non necessari?
- l'output potrebbe essere inviato direttamente?
- quali controlli servono prima dell'invio?

---

== Riepilogo finale

Oggi abbiamo visto:

- perché privacy e AI sono collegate;
- cosa sono dati personali e dati particolari;
- cosa significa trattamento;
- i principi base del GDPR;
- ruoli e diritti;
- rischi degli strumenti AI online;
- differenze tra strumenti pubblici, aziendali e locali;
- checklist per usare AI in modo più sicuro.

---

== Messaggio chiave 1

#alert[Non tutto ciò che possiamo tecnicamente fare con l'AI è automaticamente corretto o autorizzato.]

La facilità dello strumento non elimina le responsabilità.

---

== Messaggio chiave 2

#alert[Il prompt è anche un possibile canale di fuga dei dati.]

Quando scriviamo un prompt, stiamo decidendo quali informazioni condividere.

---

== Messaggio chiave 3

#alert[Usare meno dati spesso significa lavorare meglio e in modo più sicuro.]

Minimizzazione non è solo una regola legale.

È anche una buona pratica professionale.

---

== Messaggio chiave 4

#alert[L'AI può aiutare moltissimo, ma deve restare sotto controllo umano.]

Soprattutto quando sono coinvolti:

- persone;
- diritti;
- decisioni importanti;
- dati sensibili;
- comunicazioni esterne.

---

== Collegamento alla prossima lezione

Nella prossima lezione parleremo di:

- perché il codice tradizionale non basta per fare macchine intelligenti;
- come le macchine imparano dagli esempi;
- dataset, modelli, addestramento;
- errori, bias e limiti;
- modelli predittivi e generativi.

#alert[Privacy e qualità dei dati resteranno sempre sullo sfondo.]
