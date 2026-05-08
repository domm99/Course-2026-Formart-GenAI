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
    title: [01 - Introduzione],
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

Alla fine di questa lezione dovreste avere chiaro:

- cosa sono i dati;
- perché oggi le aziende generano enormi quantità di dati;
- perché i dati possono creare valore economico;
- cosa intendiamo per Intelligenza Artificiale;
- cos’è il Machine Learning;
- perché non basta scrivere codice “a mano” per rendere intelligente una macchina;
- quali tipi di problemi possiamo risolvere con l’AI.

---

#focus-slide("Cosa sono i dati?")

== Idea semplice

- *Un dato è una qualunque informazione registrata.*

- Ad esempio:
  - un numero;
  - una parola;
  - una data;
  - una foto;
  - un documento;
  - una email;
  - un click su un sito.

#alert[Se qualcosa può essere registrato, può diventare un dato.]

---

== I dati non sono solo numeri

Quando pensiamo ai dati, spesso immaginiamo tabelle e numeri.

In realtà sono dati anche:

- testi;
- immagini;
- audio;
- video;
- messaggi;
- documenti;
- log di sistema;
- disegni tecnici;
- conversazioni.

#alert[L'AI moderna lavora moltissimo con dati non numerici.]

---

== Esempio quotidiano

=== Una semplice email

```txt
Buongiorno,
vi scrivo perché la consegna prevista per ieri non è arrivata.
Potete farmi sapere quando riceverò il materiale?
Grazie.```

Questa email contiene molti dati:

mittente;
destinatario;
data;
problema;
tono;
urgenza;
oggetto della richiesta;
possibile azione da fare.

--- 

== Dati espliciti e dati impliciti

=== Dati espliciti

Sono scritti chiaramente.

#raw(block: true, lang: "txt", "La consegna non è arrivata.")

=== Dati impliciti

Non sono scritti direttamente, ma si possono dedurre.

#raw(block: true, lang: "txt", "Il cliente potrebbe essere insoddisfatto.\nLa richiesta potrebbe essere urgente.\nServe coinvolgere la logistica.")

---

== Dato, informazione, conoscenza

=== Dato: Elemento grezzo

#raw(block: true, lang: "txt", "26/03/2026\nCliente Rossi\nRitardo consegna")

=== Informazione: Dato messo in contesto

#raw(block: true, lang: "txt", "Il Cliente Rossi ha segnalato un ritardo nella consegna il 26/03/2026.")

=== Conoscenza: Informazione usata per decidere

#raw(block: true, lang: "txt", "Se molti clienti segnalano ritardi, dobbiamo migliorare la logistica.")

---

== Dal dato alla decisione

#raw(block: true, lang: "txt", "Dato → Informazione → Analisi → Decisione → Azione")

Esempio:

#raw(block: true, lang: "txt", "Molte email parlano di ritardi\n→ il problema è ricorrente\n→ serve controllare il processo di spedizione\n→ si interviene sulla logistica")

*I dati diventano utili quando aiutano a prendere decisioni.*

---

== Attività breve: acquisto online

Quali dati vengono prodotti quando una persona compra un prodotto online?

Provate a pensare a:

- cliente;
- prodotto;
- pagamento;
- magazzino;
- spedizione;
- fattura;
- assistenza clienti;
- eventuale recensione.

---

== Possibile risposta

Un acquisto online può generare dati su:

- nome cliente;
- indirizzo;
- prodotto acquistato;
- prezzo;
- metodo di pagamento;
- orario dell’ordine;
- stato della spedizione;
- tempi di consegna;
- eventuale reclamo;
- recensione finale.

*Una sola azione può generare decine di dati.*

---

#focus-slide("Diversi tipi di dati")

== Tipi di dati

=== Tre grandi categorie

Possiamo distinguere:

- dati strutturati;
- dati non strutturati;
- dati semi-strutturati.

*Questa distinzione è importante perché strumenti diversi lavorano meglio con dati diversi.*

---

== Dati strutturati
// #components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
I dati strutturati sono organizzati in modo ordinato.

Esempi:

- tabelle Excel;
- database;
- elenchi clienti;
- listini prezzi;
- registri di magazzino;
- tabelle contabili;
- report numerici.

// #alert[Sono i dati più facili da elaborare con software tradizionali.]
// ][
//   #figure(image("images/", height: 50%))
// ]

---

== Esempio di dato strutturato

#raw(block: true, lang: "txt", "| Cliente | Prodotto | Quantità | Prezzo | Data       |\n|---------|----------|----------|--------|------------|\n| Rossi   | Sedia    | 4        | 80     | 26/03/2026 |\n| Bianchi | Tavolo   | 1        | 250    | 27/03/2026 |")

Domande possibili:

- Quanto abbiamo venduto?
- Quale prodotto vende di più?
- Quale cliente compra più spesso?
- Qual è il fatturato totale?

---

== Schema e istanza

=== Schema

Descrive la struttura.

Esempio:

#raw(block: true, lang: "txt", "Cliente(nome, cognome, email)\nOrdine(id, data, totale)")

=== Istanza

Sono i dati effettivi presenti in un certo momento.

#raw(block: true, lang: "txt", "Mario Rossi, mario@example.com\nOrdine 1024, 26/03/2026, 250 euro")

---

== Schema stabile, dati variabili

In generale:

- lo schema cambia poco;
- i dati cambiano continuamente.

Esempio:

- la struttura della tabella clienti rimane simile;
- ogni giorno vengono aggiunti nuovi clienti.

#alert[Lo schema aiuta a interpretare correttamente i dati.]

---

== Modello relazionale

Il modello relazionale rappresenta i dati con tabelle.

Esempi:

- tabella clienti;
- tabella prodotti;
- tabella ordini;
- tabella fatture.

Le tabelle sono collegate tra loro tramite chiavi.

---

== Esempio relazionale

#raw(block: true, lang: "txt", "CLIENTI\nID | Nome | Email\n1  | Rossi | rossi@example.com\n\nORDINI\nID | ClienteID | Totale\n10 | 1         | 250")

Qui ClienteID collega l'ordine al cliente.

---

== Perché le tabelle sono utili?

Sono utili perché permettono di:

- organizzare dati in modo chiaro;
- evitare duplicazioni inutili;
- fare ricerche;
- filtrare;
- ordinare;
- calcolare statistiche;
- garantire coerenza.

---

== Dati non strutturati

I dati non strutturati non sono organizzati in tabelle.

Esempi:

- email;
- PDF;
- contratti;
- relazioni;
- verbali;
- immagini;
- audio;
- video;
- messaggi di chat;
- note libere.

#alert[Gran parte dei dati aziendali moderni è non strutturata.]

---

== Esempio di dato non strutturato

#raw(block: true, lang: "txt", "Il cliente ha chiamato questa mattina molto irritato.\nDice che il prodotto è arrivato danneggiato e chiede una sostituzione urgente.")

Un'AI può aiutare a estrarre:

- problema: prodotto danneggiato;
- tono: irritato;
- richiesta: sostituzione;
- priorità: urgente;
- reparto coinvolto: assistenza o logistica.

---

== Dati semi-strutturati

Sono dati che hanno una certa struttura, ma non sono semplici tabelle.

Esempi:

- fatture;
- moduli;
- ordini;
- email con campi standard;
- file JSON;
- file XML;
- log;
- preventivi;
- documenti tecnici con sezioni fisse.

---

== Esempio di dato semi-strutturato

#raw(block: true, lang: "txt", "FATTURA N. 1024\n\nCliente: Rossi Mario\nData: 26/03/2026\nTotale: 1.250 euro\nScadenza pagamento: 30/04/2026")

Non è una tabella classica, ma contiene campi riconoscibili.

---

== Esempio di dato semi-strutturato: JSON

```
{
  "persone": [
    {
      "nome": "Luca Rossi",
      "eta": 28,
      "professione": "Data Analyst",
      "interessi": ["tecnologia", "ciclismo", "musica"]
    },
    {
      "nome": "Giulia Bianchi",
      "eta": 34,
      "citta": "Milano",
      "interessi": ["design", "fotografia", "viaggi"]
    }
  ]
}
```

---

== Dati a grafo

Un grafo è composto da:

- nodi;
- archi;
- proprietà.

=== Nodo

Una cosa o entità.

Esempio: persona, luogo, post, azienda.

=== Arco

Una relazione tra entità.

Esempio: conosce, lavora per, ha visitato, ha commentato.

---

== Grafo: esempio semplice

#raw(block: true, lang: "txt", "Alice --è amica di--> Bob\nAlice --lavora per--> AziendaX\nBob   --vive a--> Bologna\nAlice --ha commentato--> Post123")

In un grafo le relazioni sono protagoniste.

---

== Perché i grafi sono potenti?

Permettono di rispondere a domande come:

- chi conosce chi?
- quali persone sono collegate indirettamente?
- quali contenuti sono simili?
- quali utenti hanno interessi comuni?
- quali pagine sono centrali in una rete?
- quali fornitori dipendono dallo stesso nodo critico?

---

== Esempio: Facebook come grafo

#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
In una rete sociale possiamo avere:

- utenti;
- post;
- foto;
- luoghi;
- commenti;
- pagine;
- gruppi.
][
E relazioni come:

- amicizia;
- like;
- commento;
- tag;
- condivisione;
- appartenenza a un gruppo.
]
---

== Facebook e TAO

Meta, cioè Facebook, ha sviluppato internamente un database a grafo chiamato TAO.

L'obiettivo era gestire grandi quantità di relazioni tra oggetti sociali.

Esempi:

- utenti;
- post;
- commenti;
- luoghi;
- like;
- tag;
- relazioni tra utenti.

#alert[Nei social network il valore non è solo nei dati, ma soprattutto nelle relazioni tra dati.]

---

== TAO
#align(center)[
#image("assets/image.png")
]
---

== Database a grafo: casi d'uso

I database a grafo sono utili per:

- social network;
- raccomandazioni;
- antifrode;
- motori di ricerca;
- knowledge graph;
- cybersecurity;
- supply chain;
- analisi di reti biologiche.

---

== Dati sequenziali e temporali

Alcuni dati hanno senso solo se consideriamo l'ordine.

Esempi:

- serie temporali di sensori;
- prezzi di borsa;
- log di sistema;
- audio;
- testo;
- sequenza di click;
- dati di produzione nel tempo.

#alert[In questi casi il tempo è parte dell'informazione.]

---

== Esempio: serie temporale

#raw(block: true, lang: "txt", "Ora 10:00 → temperatura 70°\nOra 10:01 → temperatura 72°\nOra 10:02 → temperatura 75°\nOra 10:03 → temperatura 91°")

La singola misura conta.

Ma conta ancora di più l'andamento.

#align(center)[
#image("assets/image-1.png")
]

---

== Dati multimodali

Oggi molti sistemi AI lavorano con più tipi di dato insieme.

Esempi:

- testo + immagine;
- testo + audio;
- video + sensori;
- documento + tabella;
- disegno tecnico + descrizione;
- foto prodotto + reclamo cliente.

#alert[Multimodale significa combinare più modalità di informazione.]

---

== Dati personali

Un dato personale riguarda una persona identificata o identificabile.

Esempi:

- nome;
- cognome;
- email;
- telefono;
- indirizzo;
- codice fiscale;
- numero documento;
- matricola dipendente;
- identificativo cliente;
- alcuni indirizzi IP.

#alert[I dati personali vanno trattati con attenzione.]

---

== Dati sensibili

Alcuni dati personali sono particolarmente delicati.

Esempi:

- salute;
- opinioni politiche;
- convinzioni religiose;
- dati biometrici;
- appartenenza sindacale;
- orientamento sessuale;
- dati giudiziari in certi casi.

#alert[Questi dati non vanno mai incollati in strumenti AI online senza autorizzazione.]

---

== Dati aziendali riservati

Non tutti i dati pericolosi sono dati personali.

Sono delicati anche:

- contratti;
- listini riservati;
- margini di guadagno;
- offerte commerciali;
- strategie aziendali;
- disegni tecnici;
- procedure interne;
- dati di produzione;
- informazioni sui fornitori.

#alert[Un dato può essere non personale, ma comunque molto riservato.]

---

== Esercizio rapido

=== Classificate questi dati

Sono strutturati, non strutturati o semi-strutturati?

- file Excel con vendite;
- email di reclamo;
- PDF di un contratto;
- fattura;
- foto di un prodotto difettoso;
- registro di magazzino;
- messaggio vocale del cliente;
- disegno CAD.

---

#focus-slide("Come funzionano oggi le aziende?")

== Le aziende di oggi

=== Idea chiave

Le aziende moderne non producono solo beni o servizi.

Producono anche dati continuamente.

#alert[Ogni processo aziendale lascia tracce digitali.]

---

== Com’era prima

In passato molte attività erano:

- manuali;
- su carta;
- difficili da misurare;
- lente da archiviare;
- difficili da cercare;
- poco integrate tra reparti.

Esempi:

- registri cartacei;
- fatture fisiche;
- telefonate non tracciate;
- appunti scritti a mano;
- archivi in armadi.

---

== Com’è adesso

Oggi molte attività passano da strumenti digitali:

- email;
- gestionali;
- CRM;
- ERP;
- software di magazzino;
- ticketing;
- e-commerce;
- pagamenti digitali;
- cloud;
- documenti condivisi;
- macchine connesse.

#alert[Quando il lavoro diventa digitale, produce automaticamente dati.]

---

== Ogni reparto genera dati: vendite e amministrazione

=== Vendite

- offerte;
- ordini;
- clienti;
- trattative;
- storico acquisti;
- previsioni.

=== Amministrazione

- fatture;
- pagamenti;
- scadenze;
- budget;
- costi.

---

== Ogni reparto genera dati: produzione e logistica

=== Produzione

- tempi;
- quantità;
- errori;
- fermi macchina;
- qualità;
- manutenzione.

=== Logistica

- spedizioni;
- ritardi;
- stock;
- percorsi;
- consegne.

---

== Ogni reparto genera dati: assistenza e HR

=== Assistenza clienti

- ticket;
- reclami;
- richieste;
- tempi di risposta;
- soddisfazione.

=== Risorse umane

- presenze;
- turni;
- formazione;
- competenze;
- documenti amministrativi.

---

==  Capire prima l'azienda

=== Perché parlarne in un corso sull'AI?

Prima di parlare di AI dobbiamo capire dove nasce il dato.

Il dato nasce quasi sempre dentro un contesto:

- un'azienda;
- un ufficio;
- un processo;
- una relazione con clienti o fornitori;
- un software;
- una macchina;
- una decisione da prendere.

#alert[Senza capire il contesto aziendale, i dati sembrano solo numeri o file sparsi.]

---

== Che cos'è un'azienda?

Un'azienda è un'organizzazione che usa risorse per raggiungere obiettivi.

Le risorse possono essere:

- persone;
- denaro;
- tempo;
- macchinari;
- edifici;
- software;
- conoscenza;
- dati.

#alert[Un'azienda non è solo un luogo di lavoro: è un sistema organizzato per produrre risultati.]

---

== Aziende private e pubbliche

=== Azienda privata

Spesso ha come obiettivo produrre e vendere beni o servizi generando utile.

Esempi:

- azienda manifatturiera; studio tecnico; e-commerce; software house; impresa di servizi.

=== Azienda pubblica

Ha come obiettivo erogare servizi alla collettività.

Esempi:

- ospedale; comune; scuola; università; azienda sanitaria.

---

== Missione e obiettivi

Ogni azienda esiste per una ragione.

Questa ragione può essere chiamata missione.

Esempi:

- produrre sedie di qualità;
- fornire assistenza sanitaria;
- consegnare pacchi rapidamente;
- progettare componenti meccanici;
- formare studenti;
- gestire pratiche amministrative.

#alert[La missione influenza quali dati servono e quali processi vengono costruiti.]

---

== Per capire un'azienda

Per capire davvero un'azienda bisogna guardare almeno tre cose:

- gli obiettivi;
- la struttura organizzativa;
- i processi funzionali.

In altre parole:

- cosa vuole ottenere;
- chi fa cosa;
- come vengono svolte le attività.

---

== Struttura organizzativa

La struttura organizzativa descrive come l'azienda è divisa in unità.

Esempi di unità organizzative:

- amministrazione;
- vendite;
- marketing;
- produzione;
- logistica;
- assistenza clienti;
- ufficio tecnico;
- direzione.

#alert[La struttura dice chi è responsabile di cosa.]

---

== Gerarchia aziendale

In molte aziende troviamo diversi livelli:

- livello operativo;
- livello manageriale o tattico;
- livello direzionale o strategico.

=== Livello operativo

Svolge attività quotidiane.

=== Livello manageriale

Coordina, controlla, organizza.

=== Livello direzionale

Prende decisioni strategiche.

---

== Esempio: azienda che produce mobili

=== Livello operativo

- taglio materiali;
- assemblaggio;
- controllo qualità;
- spedizione.

=== Livello manageriale

- pianificazione produzione;
- gestione turni;
- controllo magazzino.

=== Livello direzionale

- scelta mercati;
- investimenti;
- nuovi prodotti.

---

== Ogni livello usa dati diversi

#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
=== Operativo

- ordini;
- pezzi prodotti;
- tempi macchina;
- difetti.

=== Manageriale

- report settimanali;
- produttività;
- costi;
- ritardi.
][
=== Direzionale

- margini;
- strategie;
- andamento mercato;
- scenari futuri.
]

#alert[I dati devono arrivare nel formato giusto alla persona giusta.]

---

== Azienda come sistema

Un'azienda può essere vista come un sistema che riceve input e produce output.

#raw(block: true, lang: "txt", "Input → Attività aziendali → Output\n\nRisorse → Processi → Prodotti o servizi")

#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
Esempi di input:

- materie prime;
- informazioni;
- richieste clienti;
- denaro;
- competenze.
][
Esempi di output:

- prodotto finito;
- servizio erogato;
- documento;
- decisione;
- valore per il cliente.
]
---

== L'azienda produce anche informazioni

Mentre produce beni o servizi, l'azienda produce anche informazioni.

Esempi:

- chi ha fatto un ordine;
- quando è stato spedito;
- quanto è costato produrlo;
- chi ha gestito la pratica;
- quali problemi sono emersi;
- quanto tempo è servito.

#alert[Ogni attività aziendale genera tracce informative.]

---

== Blocco B — Processi aziendali

=== Perché sono importanti?

I processi spiegano come l'azienda funziona davvero.

Non basta sapere che esiste un reparto vendite o un reparto logistica.

Bisogna capire come le attività si collegano tra loro.

#alert[L'AI diventa utile quando entra dentro un processo concreto.]

---

== Che cos'è un processo?

Un processo è un insieme di attività collegate tra loro.

Queste attività servono a produrre un risultato definito e misurabile.

Esempi:

- gestire un ordine;
- emettere una fattura;
- rispondere a un reclamo;
- assumere una persona;
- produrre un componente;
- spedire un pacco.

---

== Processo: esempio semplice

=== Processo di gestione ordine

#raw(block: true, lang: "txt", "Richiesta cliente\n→ preventivo\n→ conferma ordine\n→ controllo disponibilità\n→ preparazione merce\n→ spedizione\n→ fattura\n→ pagamento")

Ogni passaggio genera e usa dati.

---

== Processi e reparti

Un processo spesso attraversa più reparti.

Esempio: ordine cliente.

Coinvolge:

- vendite;
- amministrazione;
- magazzino;
- logistica;
- assistenza clienti.

#alert[Il cliente vede un unico servizio, ma dentro l'azienda lavorano più unità.]

---

== Vista per reparti vs vista per processi

=== Vista per reparti

Guarda l'organigramma.

#raw(block: true, lang: "txt", "Vendite | Amministrazione | Magazzino | Logistica")

=== Vista per processi

Guarda il flusso del lavoro.

#raw(block: true, lang: "txt", "Ordine → Fattura → Preparazione → Spedizione → Assistenza")

#alert[La vista per processi aiuta a capire dove nascono i dati e dove si creano problemi.]

---

== Perché i processi generano dati?

Ogni processo deve sapere:

- quali risorse usa;
- chi è coinvolto;
- quali attività sono state fatte;
- quali attività mancano;
- se ci sono errori;
- se ci sono ritardi;
- se il risultato è corretto.

Tutto questo produce dati.

---

== Processo ben gestito

Un processo ben gestito è:

- chiaro;
- misurabile;
- ripetibile;
- controllabile;
- migliorabile.

Per esserlo ha bisogno di informazioni corrette.

#alert[Senza dati, un processo è difficile da controllare e migliorare.]

---

== Indicatori di processo

Un processo può essere misurato con indicatori.

Esempi:

- tempo medio di risposta;
- numero di errori;
- costo per pratica;
- numero di reclami;
- puntualità delle consegne;
- produttività giornaliera;
- soddisfazione cliente.

---

== AI nei processi

L'AI può aiutare un processo in vari punti:

- leggere input complessi;
- classificare richieste;
- estrarre dati da documenti;
- suggerire priorità;
- generare bozze;
- prevedere ritardi;
- segnalare anomalie;
- produrre report.

#alert[L'AI non sostituisce il processo: può migliorarne alcune fasi.]

---

== Esempio: reclamo cliente

Processo classico:

#raw(block: true, lang: "txt", "Email cliente → lettura manuale → classificazione → assegnazione → risposta")

Con AI:

#raw(block: true, lang: "txt", "Email cliente → sintesi automatica → categoria → priorità → bozza risposta → controllo umano")

#alert[La persona resta responsabile, ma lavora più velocemente.]

---

== Processo e responsabilità

Anche se usiamo l'AI, dobbiamo sempre sapere:

- chi controlla l'output;
- chi approva la decisione;
- chi corregge gli errori;
- chi risponde al cliente;
- chi è responsabile del risultato.

#alert[L'AI non elimina la responsabilità organizzativa.]

---


== Le aziende sono sistemi informativi

Un'azienda moderna può essere vista come un grande sistema che:

- riceve informazioni;
- produce informazioni;
- conserva informazioni;
- trasforma informazioni;
- prende decisioni usando informazioni.

#alert[La gestione dei dati è ormai parte centrale del lavoro aziendale.]

---

== Il ruolo dei software aziendali

I software aziendali servono a:

- registrare operazioni;
- coordinare persone;
- automatizzare passaggi;
- archiviare documenti;
- monitorare attività;
- generare report;
- controllare costi;
- misurare risultati.

Ogni funzione produce dati.

---

== ERP (Enterprise Resource Planning)

Un ERP è un sistema gestionale integrato.

Può gestire:

- acquisti;
- vendite;
- magazzino;
- produzione;
- amministrazione;
- contabilità;
- logistica.

#alert[Un ERP collega molti reparti e quindi raccoglie molti dati.]

---

== CRM (Customer Relationship Management)

Un CRM gestisce le relazioni con clienti e potenziali clienti.

Può contenere:

- contatti;
- email;
- telefonate;
- offerte;
- appuntamenti;
- storico acquisti;
- reclami;
- opportunità commerciali.

#alert[Il CRM è una miniera di dati commerciali.]

---

== Ticketing

Un sistema di ticketing registra richieste e problemi.

Esempi:

- richiesta assistenza;
- problema tecnico;
- reclamo;
- richiesta amministrativa;
- richiesta interna.

Dati utili:

- tempo di risposta;
- categoria;
- urgenza;
- reparto coinvolto;
- soluzione applicata.

---

== E-commerce

Un e-commerce registra:

- visite;
- prodotti visti;
- ricerche;
- carrelli abbandonati;
- acquisti;
- pagamenti;
- recensioni;
- resi;
- richieste di assistenza.

#alert[Il comportamento online dei clienti genera enorme quantità di dati.]

---

== Macchine e sensori

Nel mondo industriale, le macchine possono generare dati su:

- temperatura;
- velocità;
- consumi;
- errori;
- produzione;
- vibrazioni;
- qualità;
- tempi di fermo;
- manutenzione.

#alert[Industria 4.0 significa anche usare dati di produzione.]

---

== Una singola vendita genera molti dati

Pensiamo a una vendita.

Dati generati:

- richiesta cliente;
- preventivo;
- ordine;
- disponibilità magazzino;
- fattura;
- pagamento;
- spedizione;
- consegna;
- eventuale assistenza;
- feedback finale.

---


== Perché oggi i dati aumentano?

I dati aumentano perché:

- quasi tutto è digitale;
- i sistemi sono connessi;
- le persone comunicano online;
- i clienti interagiscono su più canali;
- le macchine producono log;
- i documenti sono digitali;
- i processi sono tracciati;
- i software misurano continuamente.

---

== La trasformazione digitale

La trasformazione digitale non significa solo usare computer.

Significa trasformare:

- processi;
- documenti;
- relazioni;
- decisioni;
- controlli;
- comunicazioni;
- archivi.

Tutto questo crea dati.

== Sistema informativo, sistema informatico, base di dati

=== Tre concetti da non confondere

Useremo tre parole simili, ma diverse:

- sistema informativo;
- sistema informatico;
- base di dati.

#alert[Capire questa differenza evita molta confusione.]

---

== Sistema informativo

Il sistema informativo è l'insieme delle informazioni gestite dall'azienda.

Include:

- informazioni generate;
- informazioni usate;
- informazioni elaborate;
- persone che le gestiscono;
- procedure;
- documenti;
- regole;
- flussi informativi.

#alert[Il sistema informativo non è solo tecnologia.]

---

== Sistema informativo: esempio

In una scuola, il sistema informativo include informazioni su:

- studenti;
- docenti;
- lezioni;
- aule;
- presenze;
- voti;
- pagamenti;
- comunicazioni;
- certificati.

Anche se alcune informazioni fossero su carta, farebbero comunque parte del sistema informativo.

---

== Sistema informatico

Il sistema informatico è la parte del sistema informativo gestita con tecnologie digitali.

Include:

- computer;
- server;
- software;
- database;
- reti;
- cloud;
- applicazioni web;
- sistemi di autenticazione.

#alert[Il sistema informatico è la parte tecnologica del sistema informativo.]

---

== Sistema informativo vs informatico

#raw(block: true, lang: "txt", "Sistema informativo = informazioni + persone + processi + regole\nSistema informatico = software + hardware + reti + database")

Esempio:

- una procedura scritta è sistema informativo;
- il gestionale che la supporta è sistema informatico;
- la tabella clienti nel gestionale è base di dati.

---

== Base di dati

Una base di dati è una raccolta organizzata di dati.

Serve a memorizzare informazioni in modo:

- persistente;
- ordinato;
- interrogabile;
- condivisibile;
- controllato.

#alert[La base di dati è una parte del sistema informatico, non tutto il sistema informatico.]

---

== Sistema informativo, informatico, database

#raw(block: true, lang: "txt", "Sistema informativo\n  └── Sistema informatico\n        └── Base di dati")

Oppure:

- sistema informativo: cosa l'azienda deve sapere;
- sistema informatico: strumenti digitali usati;
- base di dati: dove una parte dei dati viene memorizzata.

---

== Esempio: gestione ordini

=== Sistema informativo

Regole, persone, documenti e flussi per gestire gli ordini.

=== Sistema informatico

Gestionale, email, portale clienti, lettori barcode, rete aziendale.

=== Base di dati

Tabelle con clienti, prodotti, ordini, righe ordine, fatture, spedizioni.

---

== Perché questa differenza conta per l'AI?

Perché l'AI non lavora nel vuoto.

Per usarla bene bisogna sapere:

- quali informazioni servono;
- dove sono archiviate;
- chi può usarle;
- chi le aggiorna;
- quali software le gestiscono;
- quali vincoli legali o aziendali esistono.

---

== Evoluzione dei sistemi informativi

Possiamo vedere tre fasi storiche:

1. automatizzare attività operative;
2. supportare controllo e decisioni;
3. integrare applicazioni e comunicazioni.

#alert[Oggi l'AI aggiunge una nuova fase: estrarre valore da dati sempre più complessi.]

---

== Fase 1 — Automazione operativa

Obiettivo:

- raccogliere dati;
- archiviare dati;
- recuperare dati;
- ridurre tempi;
- ridurre errori.

Esempi:

- stipendi;
- fatturazione;
- gestione ordini;
- anagrafica clienti;
- magazzino.

---

== Fase 2 — Supporto al controllo

Il sistema informatico non è più solo archivio.

Inizia a supportare:

- controllo produzione;
- budget;
- analisi vendite;
- scenari what-if;
- report direzionali;
- decisioni manageriali.

#alert[Da semplice registrazione a supporto decisionale.]

---

== Fase 3 — Integrazione

Le applicazioni iniziano a comunicare tra loro.

Esempi:

- ERP integrati;
- CRM collegati al marketing;
- magazzino collegato all'e-commerce;
- produzione collegata alla logistica;
- lavoro da remoto;
- dati condivisi tra sedi diverse.

---

== Problema: sistemi non integrati

Quando i sistemi non comunicano, possono nascere problemi:

- dati duplicati;
- dati incoerenti;
- dati vecchi;
- difficoltà a lavorare da remoto;
- perdita di tempo;
- errori nelle decisioni.

#alert[Molti problemi aziendali sono problemi di informazione, non solo di tecnologia.]

---

== Esempio: dati sanitari frammentati

Nel mondo sanitario, dati sparsi tra sistemi diversi possono creare problemi:

- storia clinica incompleta;
- informazioni non aggiornate;
- duplicazione degli esami;
- difficoltà nel trasferimento tra regioni;
- rischio di errori;
- più fatica per medici e pazienti.

#alert[L'integrazione dei dati può avere impatti concreti sulla qualità del servizio.]

---

== Database e DBMS

=== Perché parlarne?

L'AI ha bisogno di dati.

Ma i dati devono essere:

- archiviati;
- organizzati;
- trovati;
- aggiornati;
- protetti;
- interrogati.

#alert[Database e AI sono collegati: uno conserva e organizza, l'altra prova a estrarre valore.]

---

== Che cos'è un database?

Un database è una collezione organizzata di dati di interesse per una o più applicazioni.

Esempi:

- database clienti;
- database ordini;
- database prodotti;
- database studenti;
- database ticket;
- database cartelle cliniche.

---

== Che cos'è un DBMS?

Un DBMS è un software che gestisce database.

DBMS significa:

#raw(block: true, lang: "txt", "DataBase Management System")

Serve a:

- memorizzare dati;
- interrogare dati;
- aggiornare dati;
- gestire utenti;
- proteggere accessi;
- fare backup;
- mantenere integrità.

---

== Database vs DBMS

=== Database

Sono i dati organizzati.

=== DBMS

È il software che li gestisce.

Esempio:

- database: archivio clienti;
- DBMS: PostgreSQL, MySQL, Oracle, SQL Server, MongoDB.

#alert[Come differenza tra documento e programma che lo gestisce.]

---

== Perché serve un DBMS?

Perché in azienda i dati devono essere:

- condivisi da più utenti;
- aggiornati in sicurezza;
- protetti da accessi non autorizzati;
- recuperabili dopo un guasto;
- coerenti anche con operazioni simultanee;
- interrogabili velocemente.

---

== Concorrenza sui dati

Più persone o applicazioni possono accedere agli stessi dati nello stesso momento.

Esempio:

- due operatori modificano lo stesso ordine;
- due clienti comprano l'ultimo pezzo disponibile;
- due pagamenti arrivano contemporaneamente.

#alert[Il DBMS deve evitare che i dati diventino incoerenti.]

---

== Guasti e recupero

Un sistema può avere problemi:

- blackout;
- crash del server;
- errore software;
- errore umano;
- interruzione di rete.

Il DBMS deve cercare di garantire che i dati non rimangano a metà.

---

== Transazioni

Una transazione è un insieme di operazioni che devono essere trattate come un blocco unico.

Esempio: bonifico.

#raw(block: true, lang: "txt", "Togli 50 euro dal conto A\nAggiungi 50 euro al conto B")

Se la seconda operazione fallisce, anche la prima deve essere annullata.

---

== Proprietà ACID, dette semplice

Le transazioni dovrebbero essere:

- atomiche: tutto o niente;
- coerenti: non rompono le regole del database;
- isolate: non si disturbano tra loro;
- durevoli: una volta confermate, restano salvate.

#alert[Queste proprietà rendono affidabili molte operazioni digitali quotidiane.]

---

== Chi usa i database?

Diverse figure:

- utenti finali;
- impiegati;
- analisti;
- programmatori;
- data analyst;
- data scientist;
- database administrator;
- responsabili aziendali;
- applicazioni automatiche.

#alert[Spesso usiamo database senza vederli direttamente.]

---

#focus-slide("Perché i dati generano valore?")

== Perché i dati generano valore

=== Idea chiave

I dati possono diventare ricchezza perché aiutano l’azienda a:

- capire meglio cosa succede;
- decidere meglio;
- lavorare più velocemente;
- ridurre errori;
- ridurre costi;
- migliorare prodotti e servizi.

#alert[Il dato da solo non vale molto. Il valore nasce dall’uso intelligente del dato.]

---

== Dati come patrimonio aziendale

Un’azienda possiede beni materiali:

- macchinari;
- edifici;
- magazzino;
- attrezzature.

Ma possiede anche beni immateriali:

- conoscenza;
- processi;
- relazioni;
- marchio;
- dati.

#alert[I dati sono una risorsa strategica.]

---

== Esempio: dati clienti

Con i dati clienti, un’azienda può capire:

- chi compra più spesso;
- quali prodotti interessano;
- quali clienti sono insoddisfatti;
- quali offerte funzionano;
- quali clienti rischiano di andarsene;
- quali problemi si ripetono.

---

== Esempio: dati di vendita

I dati di vendita permettono di rispondere a domande come:

- quali prodotti vendono di più?
- quali vendono di meno?
- in quali periodi aumentano le vendite?
- quali zone funzionano meglio?
- quali venditori performano meglio?
- quali promozioni hanno avuto effetto?

---

== Esempio: dati di magazzino

I dati di magazzino aiutano a:

- evitare mancanze di prodotto;
- evitare scorte eccessive;
- capire quali articoli ruotano di più;
- ridurre sprechi;
- programmare gli acquisti;
- migliorare la logistica.

---

== Esempio: dati di assistenza

Le richieste di assistenza possono mostrare:

- problemi ricorrenti;
- prodotti difettosi;
- istruzioni poco chiare;
- clienti insoddisfatti;
- reparti sovraccarichi;
- tempi di risposta troppo lunghi.

#alert[Un reclamo non è solo un problema: è anche una fonte di informazione.]

---

== Esempio: dati di produzione

I dati di produzione possono aiutare a:

- ridurre difetti;
- prevedere manutenzione;
- ottimizzare tempi;
- ridurre consumi;
- migliorare qualità;
- evitare fermi macchina.

---

== Dal dato al risparmio

Esempio:

#raw(block: true, lang: "txt", "Dati macchina → scoperta di frequenti micro-fermi\n→ manutenzione preventiva\n→ meno interruzioni\n→ meno costi")

Il valore economico può nascere anche dalla riduzione degli sprechi.

---

== Dal dato al nuovo servizio

Esempio:

#raw(block: true, lang: "txt", "Dati di utilizzo prodotto\n→ capiamo come i clienti lo usano davvero\n→ miglioriamo il prodotto\n→ offriamo assistenza personalizzata\n→ aumentiamo fidelizzazione")

Il dato può aiutare a creare nuovi servizi.

---

== Dati e vantaggio competitivo

Un’azienda che usa bene i dati può:

- muoversi più velocemente;
- capire prima i problemi;
- servire meglio i clienti;
- ridurre costi;
- prevedere cambiamenti;
- personalizzare offerte;
- migliorare la qualità.

#alert[Usare bene i dati può fare la differenza tra aziende concorrenti.]

---

== Decisioni basate su impressioni

Senza dati, spesso si decide così:

#raw(block: true, lang: "txt", "Mi sembra che molti clienti siano scontenti.\nForse il problema è la spedizione.\nSecondo me questo prodotto vende poco.")

Il rischio è basarsi su sensazioni.

---

== Decisioni basate su dati

Con i dati, si può dire:

#raw(block: true, lang: "txt", "I reclami sono aumentati del 18% negli ultimi due mesi.\nIl 65% riguarda ritardi di spedizione.\nIl problema è concentrato su due aree geografiche.")

#alert[I dati aiutano a passare dalle opinioni alle evidenze.]

---

== Attenzione: i dati non parlano da soli

I dati vanno:

- raccolti;
- puliti;
- capiti;
- contestualizzati;
- interpretati;
- usati correttamente.

#alert[Avere tanti dati non significa automaticamente prendere buone decisioni.]

---

== Dati di bassa qualità

Un dato può essere:

- sbagliato;
- duplicato;
- incompleto;
- vecchio;
- incoerente;
- inserito male;
- non aggiornato.

Esempio:

#raw(block: true, lang: "txt", "Lo stesso cliente appare tre volte con nomi leggermente diversi.")

---

== Garbage in, garbage out

#raw(block: true, lang: "txt", "Dati scadenti → analisi scadente → decisione scadente")

In italiano:

#raw(block: true, lang: "txt", "Se metto spazzatura dentro, ottengo spazzatura fuori.")

#alert[L'AI non può fare miracoli con dati pessimi.]

---

== Rischi nell'uso dei dati

I dati possono creare problemi se:

- vengono usati senza autorizzazione;
- violano la privacy;
- sono interpretati male;
- sono incompleti;
- contengono pregiudizi;
- vengono condivisi con strumenti non sicuri;
- producono decisioni automatiche ingiuste.

---

== Valore e responsabilità

I dati possono creare grande valore.

Ma più dati raccogliamo, più aumentano:

- responsabilità;
- rischi;
- obblighi legali;
- necessità di sicurezza;
- necessità di controllo umano.

#alert[Il valore dei dati va sempre bilanciato con la responsabilità.]

---

== Dai dati alle decisioni

#align(center)[#image("images/image.png")]

---

#focus-slide("L'Intelligenza Artificiale")

== Cos’è l'Intelligenza Artificiale?

=== Definizione semplice

L'Intelligenza Artificiale è un insieme di tecniche che permettono a una macchina di svolgere compiti che normalmente richiederebbero intelligenza umana.

Esempi:

- capire un testo;
- riconoscere un’immagine;
- tradurre;
- classificare;
- prevedere;
- generare contenuti.

---

== AI è già ovunque

Prima di definire l'AI in modo preciso, partiamo da un'idea semplice:

#alert[probabilmente la usiamo già ogni giorno, anche quando non ce ne accorgiamo.]

Esempi rapidi:

- filtri antispam;
- suggerimenti della tastiera;
- traduttori automatici;
- mappe e navigatori;
- raccomandazioni su piattaforme;
- sistemi antifrode.

#alert[Più avanti vedremo questi esempi in modo più approfondito.]

---

== AI non significa coscienza

Un sistema AI può sembrare intelligente.

Ma non significa che abbia:

- coscienza;
- intenzioni;
- emozioni;
- buon senso umano;
- vera comprensione del mondo;
- responsabilità morale.

#alert[Un sistema può produrre risposte utili senza capire come una persona.]

---

== AI come riconoscimento di schemi

Molti sistemi AI funzionano cercando schemi nei dati.

Esempi:

- parole tipiche delle email spam;
- immagini simili tra loro;
- clienti con comportamenti simili;
- testi con tono negativo;
- macchine con segnali di guasto.

---

== AI tradizionale vs AI generativa

=== AI tradizionale

Spesso classifica, prevede, riconosce.

#raw(block: true, lang: "txt", "Questa email è spam?")

=== AI generativa

Produce nuovi contenuti.

#raw(block: true, lang: "txt", "Scrivi una risposta professionale a questa email.")

---

== AI stretta

La maggior parte dell'AI attuale è *AI stretta*.

Significa che è progettata per compiti specifici.

Esempi:

- tradurre testi;
- riconoscere immagini;
- suggerire prodotti;
- rispondere a domande;
- generare testi;
- classificare documenti.

#alert[Non è intelligenza generale come quella umana.]

---

== AI e automazione

Automazione tradizionale:

#raw(block: true, lang: "txt", "Ripete una procedura fissa.")

AI:

#raw(block: true, lang: "txt", "Gestisce variabilità, linguaggio, immagini, pattern e incertezza.")

Esempio:

- automazione: inviare una fattura ogni venerdì;
- AI: riassumere reclami e proporre priorità di intervento.

---

== Esempio di software tradizionale

#raw(block: true, lang: "txt", "SE importo_fattura > 1000\nALLORA richiedi approvazione del responsabile")

Questa è una regola esplicita.

Funziona bene quando il problema è chiaro e stabile.

---

== Esempio di AI

#raw(block: true, lang: "txt", "Leggi questa email e dimmi se il cliente è arrabbiato,\nse la richiesta è urgente e quale reparto deve intervenire.")

Qui le regole sarebbero difficili da scrivere tutte a mano.

---

== Perché il linguaggio è difficile

Il linguaggio umano è:

- ambiguo;
- pieno di contesto;
- diverso da persona a persona;
- spesso implicito;
- influenzato dal tono;
- ricco di sinonimi;
- pieno di eccezioni.

#alert[Per questo l’AI è utile nel trattamento del testo.]

---

#focus-slide("Un po' di storia")

== Test di Turing e tipi di AI

=== Domanda storica

Alan Turing si chiese:

#raw(block: true, lang: "txt", "Le macchine possono pensare?")

Ma la domanda è difficile perché anche “pensare” è difficile da definire.

---

== Imitation Game

Nel Test di Turing abbiamo tre attori:

- un umano;
- una macchina;
- un interrogatore.

L'interrogatore comunica senza vedere gli altri.

Obiettivo:

capire chi è umano e chi è macchina.

---

== Idea del Test di Turing

Se una macchina riesce a conversare in modo tale da non essere distinta da un umano, possiamo dire che mostra un comportamento intelligente?

#alert[Il test non misura necessariamente la coscienza: misura la capacità di imitare una conversazione umana.]

---

== Abilità necessarie per il Test di Turing

Per superare il test servono varie capacità:

- elaborazione del linguaggio naturale;
- rappresentazione della conoscenza;
- ragionamento automatico;
- apprendimento automatico;
- gestione del contesto;
- capacità di dialogo.

---

== Oltre il Test di Turing

Non tutta l'intelligenza passa dalla conversazione.

Altri contesti richiedono:

- percezione visiva;
- movimento;
- manipolazione oggetti;
- pianificazione;
- decisioni in tempo reale;
- interazione con il mondo fisico.

#alert[Un robot intelligente deve fare molto più che parlare bene.]

---

== AI debole e AI forte

=== AI debole

Sistemi che agiscono come se fossero intelligenti in compiti specifici.

Esempi:

- traduttore;
- chatbot;
- classificatore immagini.

=== AI forte

Ipotesi di sistemi realmente intelligenti e coscienti.

#alert[Oggi lavoriamo quasi sempre con AI debole.]

---

== AI specifica e AI generale

=== AI specifica

Risolve uno o pochi compiti.

Esempio:

- riconoscere gatti nelle immagini.

=== AI generale

Sarebbe in grado di affrontare compiti molto diversi come un essere umano.

#alert[L'AI generale resta un obiettivo aperto e discusso.]

---

== ANI, AGI, ASI

Altra classificazione comune:

- ANI: Artificial Narrow Intelligence;
- AGI: Artificial General Intelligence;
- ASI: Artificial Super Intelligence.

=== ANI

AI limitata a compiti specifici.

=== AGI

AI generale paragonabile all'essere umano.

=== ASI

AI superiore all'essere umano in molti ambiti.

---

== Dove siamo oggi?

La maggior parte dei sistemi attuali è ANI.

Anche i sistemi generativi molto potenti:

- scrivono;
- riassumono;
- traducono;
- generano immagini;
- aiutano a programmare;
- ragionano in alcuni contesti;

ma non sono esseri coscienti.

---

== AI simbolica

L'AI simbolica usa:

- regole;
- logica;
- simboli;
- ontologie;
- rappresentazioni esplicite;
- ragionamento formale.

Esempio:

#raw(block: true, lang: "txt", "SE persona è cliente premium\nE ordine è in ritardo\nALLORA priorità alta")

---

== AI non simbolica

L'AI non simbolica apprende dai dati.

Esempi:

- reti neurali;
- deep learning;
- modelli linguistici;
- riconoscimento immagini;
- sistemi generativi.

#alert[È spesso molto potente, ma meno interpretabile.]

---

== Top-down vs bottom-up

=== Top-down

Partiamo da regole e conoscenza umana.

#raw(block: true, lang: "txt", "Regole → comportamento")

=== Bottom-up

Partiamo da esempi e dati.

#raw(block: true, lang: "txt", "Dati → apprendimento → comportamento")

---

== Ragionamento deduttivo

Esempio classico:

#raw(block: true, lang: "txt", "Tutti gli uomini sono mortali.\nSocrate è un uomo.\nQuindi Socrate è mortale.")

Qui la conclusione segue logicamente dalle premesse.

---

== Ragionamento induttivo

Esempio:

#raw(block: true, lang: "txt", "Ho visto molti uccelli volare.\nQuindi gli uccelli volano.")

Problema:

#raw(block: true, lang: "txt", "E i pinguini?")

L'induzione crea conoscenza nuova, ma può sbagliare.

---

== Ragionamento abduttivo

Esempio:

#raw(block: true, lang: "txt", "Il prato è bagnato.\nSe piove, il prato si bagna.\nForse ha piovuto.")

Ma potrebbe esserci un'altra causa:

#raw(block: true, lang: "txt", "Qualcuno ha acceso l'irrigazione.")

---

== Ragionamento per analogia

Si ragiona per somiglianza.

Esempio:

#raw(block: true, lang: "txt", "Questo cliente assomiglia ad altri clienti che hanno comprato il prodotto X.\nForse anche lui sarà interessato al prodotto X.")

Molti sistemi di raccomandazione usano idee simili.

---

== Storia dell'AI

=== Perché studiare la storia?

Per capire che l'AI non nasce con ChatGPT.

È una storia lunga, fatta di:

- grandi aspettative;
- risultati importanti;
- delusioni;
- periodi di rallentamento;
- nuove tecnologie;
- ritorni di interesse.

---

== 1943–1956: nascita dell'AI

In questa fase nascono idee fondamentali:

- neuroni artificiali;
- calcolo automatico;
- macchine universali;
- possibilità di simulare aspetti dell'intelligenza;
- prime basi teoriche.

---

== 1956: Dartmouth workshop

Il workshop di Dartmouth è spesso considerato un momento simbolico di nascita dell'AI come disciplina.

Idea forte:

#raw(block: true, lang: "txt", "Ogni aspetto dell'apprendimento o dell'intelligenza può essere descritto così precisamente da poter essere simulato da una macchina.")

---

== 1950–1960: entusiasmo iniziale

Prime grandi aspettative:

- risoluzione automatica di problemi;
- linguaggi per AI;
- reti neurali iniziali;
- giochi;
- dimostrazione di teoremi;
- traduzione automatica.

#alert[Molti pensavano che l'AI generale fosse vicina.]

---

== 1960–1970: primi limiti

Molti sistemi funzionavano bene solo in esempi piccoli.

Problemi:

- poca potenza di calcolo;
- pochi dati;
- linguaggio naturale difficile;
- mondo reale troppo complesso;
- costi elevati;
- aspettative troppo alte.

---

== ELIZA

ELIZA era un famoso programma conversazionale degli anni '60.

Simulava un dialogo in stile psicoterapeuta.

Mostrava una cosa importante:

- anche regole semplici possono sembrare intelligenti;
- le persone tendono ad attribuire comprensione alla macchina.

#alert[Questo effetto è ancora attuale con i chatbot moderni.]

---

== 1969–1979: sistemi esperti

I sistemi esperti cercavano di catturare conoscenza di specialisti.

Usavano:

- regole;
- basi di conoscenza;
- inferenze;
- domini ristretti.

Esempi:

- diagnosi medica;
- configurazione prodotti;
- supporto decisionale.

---

== 1980–1988: AI in azienda

L'AI entra in alcuni contesti industriali.

Soprattutto tramite:

- sistemi esperti;
- supporto decisionale;
- automazione di conoscenza specialistica;
- investimenti aziendali.

Poi emergono limiti di manutenzione e scalabilità.

---

== AI winter

AI winter indica periodi in cui:

- l'entusiasmo diminuisce;
- i fondi calano;
- le promesse non vengono mantenute;
- i risultati sembrano inferiori alle aspettative.

#alert[L'AI ha avuto più cicli di hype e delusione.]

---

== 1990–2010: web e dati

Con Internet aumentano enormemente:

- dati disponibili;
- testi;
- immagini;
- link;
- comportamenti utenti;
- potenza computazionale;
- applicazioni commerciali.

Nascono sistemi sempre più data-driven.

---

== 2010–oggi: deep learning

Il deep learning cresce grazie a:

- grandi dataset;
- GPU;
- reti neurali profonde;
- cloud computing;
- miglioramenti algoritmici;
- investimenti industriali.

Risultati importanti in:

- visione artificiale;
- voce;
- traduzione;
- giochi;
- linguaggio.

---

== 2020–oggi: AI generativa

L'AI generativa diventa accessibile al grande pubblico.

Esempi:

- generazione testo;
- generazione immagini;
- generazione codice;
- riassunti;
- chatbot;
- assistenti da ufficio;
- modelli multimodali.

#alert[La novità non è solo tecnica: è anche l'accessibilità per utenti non esperti.]

---

== Perché l'AI esplode proprio ora?

Fattori principali:

- enorme quantità di dati;
- potenza computazionale;
- GPU e data center;
- cloud;
- modelli più grandi;
- strumenti facili da usare;
- investimenti;
- domanda aziendale;
- democratizzazione degli strumenti.

---

== Diffusione dell'AI oggi

=== AI sempre più presente

L'AI è ormai usata in molti settori:

- aziende;
- pubblica amministrazione;
- sanità;
- scuola;
- industria;
- finanza;
- marketing;
- software;
- creatività.

---

== Adozione nelle organizzazioni

Secondo il report Stanford AI Index 2025, nel 2024 il 78% delle organizzazioni dichiarava di usare AI, in crescita rispetto al 55% dell'anno precedente.

#alert[Il dato importante non è solo “quanti la provano”, ma quanto entra davvero nei processi.]

---

== AI generativa e aziende

Secondo McKinsey, nel 2025 quasi nove rispondenti su dieci dichiarano che la propria organizzazione usa regolarmente AI.

Ma molte aziende sono ancora in una fase iniziale:

- sperimentazione;
- progetti pilota;
- uso individuale;
- integrazione parziale;
- difficoltà a misurare valore.

---

== Diffusione non uniforme

L'adozione dell'AI non è uguale ovunque.

Può variare per:

- paese;
- settore;
- dimensione aziendale;
- competenze disponibili;
- infrastruttura digitale;
- regolamentazione;
- cultura organizzativa;
- disponibilità di dati.

---

== Perché tante aziende fanno fatica?

Motivi comuni:

- dati disordinati;
- processi poco chiari;
- mancanza di competenze;
- paura per privacy e sicurezza;
- costi;
- integrazione con software esistenti;
- output non affidabili;
- mancanza di governance.

#alert[Il problema spesso non è “avere l'AI”, ma usarla bene.]

---

== Uso individuale vs uso aziendale

=== Uso individuale

Una persona usa un chatbot per scrivere meglio o riassumere.

=== Uso aziendale

L'AI viene integrata in processi, sistemi, regole, policy e controlli.

#alert[Passare dal primo al secondo livello è molto più difficile.]

---

== AI e produttività

#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
L'AI può aumentare produttività quando aiuta a:

- ridurre lavoro ripetitivo;
- accelerare scrittura;
- trovare informazioni;
- generare bozze;
- automatizzare passaggi;
- supportare decisioni;
- migliorare qualità.
][
Ma può ridurla se genera:

- errori;
- distrazioni;
- revisioni infinite;
- fiducia eccessiva;
- output non verificati.
]
---

== AI e competenze

L'AI non elimina il bisogno di competenze.

Lo sposta.

Servono persone capaci di:

- formulare richieste;
- valutare output;
- capire il contesto;
- proteggere dati;
- integrare strumenti;
- riconoscere errori;
- prendere responsabilità.

---

== AI e lavoro

L'AI può cambiare il lavoro in tre modi:

- automatizza alcune attività;
- assiste alcune attività;
- trasforma alcune attività.

Esempio:

- prima scrivo una email da zero;
- ora genero una bozza;
- poi controllo, adatto e approvo.

---

== Dati + modelli = AI

=== La relazione fondamentale

L'AI moderna nasce dall'incontro tra:

- dati;
- modelli;
- calcolo;
- obiettivi;
- valutazione.

#raw(block: true, lang: "txt", "Dati + Modelli + Calcolo → Sistema AI")

Senza dati, un modello non può imparare pattern utili.

Ma non basta avere tanti dati: servono dati rilevanti, corretti, aggiornati, rappresentativi, ben organizzati e trattati legalmente.

---

== Data is the new oil

Si dice spesso:

#raw(block: true, lang: "txt", "Data is the new oil")

Il senso è:

- i dati grezzi da soli valgono poco;
- devono essere raffinati;
- devono essere trasformati;
- devono essere analizzati;
- devono essere usati per creare valore.

#alert[Come il petrolio, anche i dati possono essere preziosi e pericolosi.]

---

== Raffinare i dati

Raffinare i dati significa:

- pulire errori;
- rimuovere duplicati;
- completare valori mancanti;
- correggere formati;
- unire fonti diverse;
- anonimizzare;
- etichettare;
- validare qualità.

---

== Problemi di qualità dei dati

Problemi comuni:

- rumore;
- errori di inserimento;
- valori mancanti;
- dati duplicati;
- etichette sbagliate;
- dati obsoleti;
- bias;
- dati non rappresentativi.

#alert[La qualità dei dati influenza direttamente la qualità dell'AI.]

---

== Bias nei dati

Il bias può nascere quando i dati riflettono:

- squilibri storici;
- discriminazioni;
- campioni non rappresentativi;
- errori di raccolta;
- decisioni umane passate;
- stereotipi presenti online.

#alert[Il modello può imparare anche le ingiustizie presenti nei dati.]

---

== Bias: idea semplice

Un sistema AI impara da esempi passati.

Se gli esempi passati sono distorti, il sistema può imparare quella distorsione.

#raw(block: true, lang: "txt", "Dati storici distorti → modello distorto → decisioni distorte")

Esempio intuitivo:

- se in passato un'azienda ha assunto quasi solo uomini in ruoli tecnici;
- un sistema addestrato su quei dati può imparare che i profili maschili sono “più adatti”;
- anche se nessuno ha scritto esplicitamente una regola discriminatoria.

---

== Bias: caso COMPAS

Negli Stati Uniti ha fatto molto discutere COMPAS, un sistema usato per stimare il rischio di recidiva.

Il caso è importante perché mostra un problema concreto:

- il sistema produceva un punteggio apparentemente oggettivo;
- quel punteggio poteva influenzare decisioni giudiziarie;
- ProPublica ha sostenuto che il sistema generasse errori sbilanciati tra gruppi razziali.

#alert[Quando un punteggio automatico entra in una decisione ad alto impatto, il bias diventa un problema sociale.]

Fonte: #link("https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing")[ProPublica — Machine Bias]

---

== Bias: COMPAS in pratica

Il punto didattico non è “l'algoritmo è cattivo”.

Il punto è più sottile:

- quali dati storici sono stati usati?
- cosa significa davvero “rischio”?
- quali errori sono più gravi?
- chi controlla il sistema?
- chi subisce le conseguenze?

#alert[Un modello può essere matematicamente accurato e comunque socialmente problematico.]

---

== Bias: caso Amazon recruiting

Nel 2018 Reuters ha raccontato il caso di uno strumento sperimentale di recruiting sviluppato da Amazon.

L'idea era usare AI per assegnare punteggi ai CV.

Il problema:

- il modello era stato addestrato su dati storici di selezione del personale;
- quei dati riflettevano un settore storicamente dominato da uomini;
- il sistema finiva per penalizzare alcuni segnali associati a candidature femminili.

Fonte: #link("https://www.reuters.com/article/us-amazon-com-jobs-automation-insight/amazon-scraps-secret-ai-recruiting-tool-that-showed-bias-against-women-idUSKCN1MK08G")[Reuters — Amazon recruiting tool]

---

== Bias: lezione dal caso recruiting

Un modello può discriminare anche senza usare esplicitamente la variabile “genere”.

Può usare variabili correlate, per esempio:

- parole nel CV;
- università frequentata;
- esperienze precedenti;
- percorsi professionali storicamente più comuni in certi gruppi.

#alert[Rimuovere una colonna sensibile non elimina automaticamente il bias.]

---

== Bias: credito e scoring

Nel credito, algoritmi e punteggi automatici possono aiutare a valutare il rischio.

Ma possono anche creare problemi se usano dati storici o proxy che penalizzano certi gruppi.

Esempi di variabili delicate o proxy:

- area geografica;
- professione;
- storico creditizio;
- tipo di contratto;
- rete di relazioni economiche;
- dati socio-demografici indiretti.

#alert[Anche una variabile apparentemente neutra può diventare discriminatoria.]

---

== Bias: esempio Sicilia e credito

Esempio didattico spesso citato: un sistema di scoring può penalizzare richieste provenienti da una certa area geografica, per esempio perché nei dati storici quell'area appare più rischiosa.

Il rischio è questo:

- il modello non valuta solo la persona;
- valuta anche pattern aggregati del gruppo o del territorio;
- persone affidabili possono essere penalizzate per caratteristiche indirette.

Approfondimento generale sul diritto a trasparenza e logica dello scoring nel credito: #link("https://www.garanteprivacy.it/home/docweb/-/docweb-display/docweb/9141964")[Garante Privacy — sistemi di informazione creditizia]

---

== Bias: immagini generate

I modelli generativi possono riflettere stereotipi presenti nei dati online.

Esempi tipici:

- “CEO” rappresentato spesso come uomo bianco;
- “infermiera” rappresentata spesso come donna;
- “ingegnere” associato più spesso a uomini;
- alcune etnie sovra-rappresentate in ruoli negativi o stereotipati.

#alert[Il modello non inventa gli stereotipi dal nulla: spesso li assorbe dai dati.]

---

== Bias: perché è difficile eliminarlo

Eliminare il bias è difficile perché:

- spesso non sappiamo esattamente cosa il modello ha imparato;
- le variabili sono correlate tra loro;
- la società stessa produce dati squilibrati;
- l'idea di “equità” può avere definizioni diverse;
- accuratezza e giustizia non coincidono sempre.

#alert[Non basta dire “lo decide il computer”: qualcuno deve progettare, controllare e rispondere delle decisioni.]

---

== Bias: domande da fare

Quando usiamo AI in un processo decisionale, chiediamoci:

- chi è rappresentato nei dati?
- chi manca dai dati?
- quali errori fa il sistema?
- gli errori colpiscono tutti allo stesso modo?
- una persona può contestare la decisione?
- c'è supervisione umana reale?
- il sistema è usato come supporto o come giudice automatico?

---

== AI per tutto? No

L'AI funziona bene in alcuni compiti:

- traduzione;
- classificazione immagini;
- riconoscimento vocale;
- riassunto;
- generazione bozze.

Funziona peggio in altri:

- giudizi morali;
- contesti ambigui;
- responsabilità legali;
- sarcasmo;
- decisioni critiche senza supervisione.

---

== Attenti all'hype

L'AI non è magia.

Attenzione a frasi come:

- “risolve tutto”;
- “sostituisce tutti”;
- “non sbaglia mai”;
- “capisce come una persona”;
- “basta premere un pulsante”.

#alert[Un buon uso dell'AI richiede competenza, controllo e senso critico.]

---

== Hype cycle

Molte tecnologie attraversano fasi:

- entusiasmo iniziale;
- aspettative eccessive;
- delusione;
- comprensione più realistica;
- uso produttivo.

#alert[L'obiettivo non è seguire la moda, ma capire dove l'AI crea valore reale.]

#align(center)[
#image("assets/image-2.png")
]
---

== AI responsabile

Usare AI in modo responsabile significa considerare:

- accuratezza;
- privacy;
- sicurezza;
- bias;
- trasparenza;
- controllo umano;
- impatto sul lavoro;
- conformità normativa;
- responsabilità finale.

---

== Domande da fare prima di usare AI

- Qual è il problema concreto?
- Quali dati useremo?
- Possiamo usare quei dati?
- Chi verifica l'output?
- Cosa succede se sbaglia?
- Come misuriamo il valore?
- Come proteggiamo privacy e sicurezza?

---

#focus-slide("Machine Learning")

== Cos'è il Machine Learning?

=== Definizione semplice

Il Machine Learning è un modo per costruire sistemi che imparano dagli esempi.

Invece di scrivere tutte le regole a mano, forniamo molti esempi.

#raw(block: true, lang: "txt", "Esempi → apprendimento → modello → nuova risposta")

---

== Programmazione tradizionale

Nella programmazione tradizionale:

#raw(block: true, lang: "txt", "Regole + Dati → Risultato")

Esempio:

#raw(block: true, lang: "txt", "Regola: se il totale supera 1000 euro, chiedi approvazione.\nDato: totale = 1200 euro.\nRisultato: serve approvazione.")

---

== Machine Learning

Nel Machine Learning:

#raw(block: true, lang: "txt", "Dati + Esempi → Modello\nModello + Nuovo caso → Predizione")

Esempio:

#raw(block: true, lang: "txt", "Molte email già classificate come spam/non spam\n→ modello\n→ nuova email classificata automaticamente")

---

== Workflow di Machine Learning
#align(center)[
#image("assets/image-3.png")]
---

== Perché non basta il codice?

Alcuni problemi sono facili da programmare.

Esempio:

- calcolare l’IVA;
- ordinare una tabella;
- controllare se un campo è vuoto.

Altri problemi sono difficili.

Esempio:

- capire se una email è sarcastica;
- capire se un cliente è arrabbiato;
- riassumere un contratto.

---

== Quando le regole funzionano bene

Le regole funzionano bene quando:

- il problema è chiaro;
- ci sono poche eccezioni;
- i dati sono ordinati;
- la logica è stabile;
- il risultato è deterministico.

Esempio:

#raw(block: true, lang: "txt", "Se la data di scadenza è passata, segnala ritardo.")

---

== Quando le regole non bastano

Le regole non bastano quando:

- ci sono troppe eccezioni;
- il linguaggio è variabile;
- il contesto conta molto;
- le immagini sono complesse;
- le situazioni cambiano;
- non sappiamo scrivere tutte le condizioni.

---

== Esempio: riconoscere un reclamo

Regola semplice:

#raw(block: true, lang: "txt", "SE il testo contiene “reclamo”\nALLORA è un reclamo.")

Problema:

#raw(block: true, lang: "txt", "Sono tre settimane che aspetto una risposta.\nMi sembra un comportamento poco serio.")

È un reclamo anche senza la parola “reclamo”.

---

== Esempio: tono di una email

#raw(block: true, lang: "txt", "Va bene, fate pure come volete.")

Questa frase può essere:

- neutra;
- irritata;
- sarcastica;
- rassegnata.

Per capirlo serve contesto.

---

== Dataset

Un dataset è una raccolta di esempi.

Esempio:

#raw(block: true, lang: "txt", "Email 1 → spam\nEmail 2 → non spam\nEmail 3 → spam\nEmail 4 → non spam")

Il sistema usa gli esempi per riconoscere schemi.

---

== Addestramento

L’addestramento è il processo con cui il sistema impara dai dati.

Idea semplificata:

#raw(block: true, lang: "txt", "Guarda tanti esempi.\nTrova schemi ricorrenti.\nUsa quegli schemi su casi nuovi.")

#alert[Non serve entrare nella matematica per capire il concetto.]

---

== Modello

Il modello è il risultato dell’addestramento.

Non è semplicemente una copia dei dati.

È un sistema che usa ciò che ha imparato per produrre risposte su casi nuovi.

#raw(block: true, lang: "txt", "Nuova email → modello → probabilmente spam")

---

== Predizione

Una predizione è una risposta prodotta dal modello.

Esempi:

- questa email è urgente;
- questo cliente potrebbe abbandonare;
- questa macchina potrebbe guastarsi;
- questo testo è un reclamo;
- questa fattura sembra anomala.

---

== Probabilità, non certezza

Molti modelli non danno certezze.

In pratica dicono:

#raw(block: true, lang: "txt", "Visti gli esempi passati, questa sembra la risposta più probabile.")

#alert[Probabile non significa sicuro.]

---

== Errore

Un modello può sbagliare.

Può sbagliare perché:

- i dati erano sbagliati;
- i dati erano pochi;
- i dati erano vecchi;
- il caso nuovo è diverso;
- il problema è ambiguo;
- mancano informazioni importanti.

---

== Bias nel modello

Qui il punto non è più solo la qualità del dato.

Il bias può entrare anche nelle scelte di progettazione:

- quali dati raccogliamo;
- quali dati ignoriamo;
- quale obiettivo ottimizziamo;
- quale errore consideriamo accettabile;
- chi valuta il risultato finale.

#alert[Il bias non è solo un problema tecnico: è anche un problema organizzativo.]

---

== Overfitting, detto semplice

A volte un modello impara troppo bene gli esempi visti.

È come uno studente che memorizza le risposte del compito, ma non capisce il metodo.

Risultato:

- va bene sugli esempi già visti;
- va male su casi nuovi.

#alert[Un buon modello deve funzionare anche su situazioni nuove.]

---

== Generalizzazione

Generalizzare significa applicare ciò che si è imparato a casi nuovi.

Esempio:

#raw(block: true, lang: "txt", "Ho visto molti esempi di email urgenti.\nOra riesco a riconoscere una nuova email urgente.")

#alert[La vera utilità del Machine Learning è lavorare su casi mai visti prima.]

---

#focus-slide("Problemi che possiamo risolvere")

== Tipi di problemi che possiamo risolvere

=== Principali categorie

- classificazione;
- regressione;
- clustering;
- generazione;
- apprendimento per rinforzo.

---

== Classificazione

La classificazione assegna una categoria.

Esempi:

- spam / non spam;
- urgente / non urgente;
- reclamo / richiesta normale;
- positivo / neutro / negativo;
- fattura / contratto / report;
- rischio basso / medio / alto.

---

== Classificazione: esempio da ufficio

Input:

#raw(block: true, lang: "txt", "Il prodotto è arrivato danneggiato e chiedo una sostituzione urgente.")

Output possibile:

#raw(block: true, lang: "txt", "Categoria: reclamo\nPriorità: alta\nReparto: assistenza clienti")

---

== Regressione

La regressione stima un numero.

Esempi:

- vendite del prossimo mese;
- ritardo previsto in giorni;
- costo stimato;
- consumo energetico;
- domanda di prodotto;
- probabilità di abbandono cliente.

---

== Regressione: esempio

Input:

#raw(block: true, lang: "txt", "Vendite passate, stagione, promozioni, disponibilità magazzino.")

Output:

#raw(block: true, lang: "txt", "Vendite previste per il prossimo mese: 1250 unità.")

---

== Clustering

Il clustering raggruppa elementi simili.

Esempi:

- clienti con comportamenti simili;
- reclami con argomenti simili;
- prodotti con andamento simile;
- documenti che parlano dello stesso tema.

---

== Clustering: esempio

Abbiamo 5000 messaggi clienti.

Il sistema può raggrupparli in:

- ritardi di consegna;
- problemi di pagamento;
- prodotto danneggiato;
- assistenza tecnica;
- richieste commerciali.

---

== Generazione

La generazione crea nuovo contenuto.

Esempi:

- scrivere una email;
- riassumere un documento;
- creare un report;
- generare una checklist;
- preparare una scaletta;
- scrivere codice;
- generare immagini.

#alert[La Generative AI è il centro di questo corso.]

---

== Generazione: esempio

Prompt:

#raw(block: true, lang: "txt", "Scrivi una email gentile a un cliente per spiegare\nche la consegna subirà un ritardo di due giorni.")

Output:

#raw(block: true, lang: "txt", "Gentile cliente,\nci scusiamo per il ritardo...")

---

== Apprendimento per rinforzo

L’apprendimento per rinforzo si basa su tentativi e feedback.

Idea semplice:

#raw(block: true, lang: "txt", "Provo un’azione.\nRicevo un premio o una penalità.\nImparo a scegliere meglio in futuro.")

Esempi:

- giochi;
- robotica;
- ottimizzazione;
- alcuni sistemi di raccomandazione.

---

== Tabella riassuntiva

#raw(block: true, lang: "txt", "Classificazione  → scegliere una categoria\nRegressione      → stimare un numero\nClustering       → trovare gruppi\nGenerazione      → creare contenuti\nRinforzo         → imparare da feedback")

---

#focus-slide("Modelli predittivi vs modelli generativi")

== Modelli predittivi e modelli generativi

=== Modello predittivo

Stima o classifica qualcosa.

Esempi:

#raw(block: true, lang: "txt", "Questa email è urgente?\nQuesto cliente comprerà ancora?\nQuesta macchina si guasterà?")

---

== Modello generativo

Produce qualcosa di nuovo.

Esempi:

#raw(block: true, lang: "txt", "Scrivi una email.\nRiassumi questo documento.\nCrea una checklist.\nPrepara una bozza di report.")

---

== Stesso input, due usi diversi

Input:

#raw(block: true, lang: "txt", "Email di un cliente arrabbiato per una consegna in ritardo.")

Uso predittivo:

#raw(block: true, lang: "txt", "Classifica: reclamo urgente.")

Uso generativo:

#raw(block: true, lang: "txt", "Scrivi una risposta professionale e rassicurante.")

---

== AI generativa in ufficio

Può aiutare a:

- scrivere email;
- migliorare testi;
- riassumere documenti;
- preparare report;
- creare checklist;
- tradurre;
- semplificare linguaggio tecnico;
- organizzare idee;
- produrre bozze.

---

== Attenzione alle allucinazioni

I modelli generativi possono inventare:

- fatti;
- numeri;
- date;
- nomi;
- riferimenti;
- norme;
- fonti;
- spiegazioni plausibili ma sbagliate.

#alert[Un testo scritto bene non è necessariamente vero.]

---

== Perché sembrano così convincenti?

Perché sono molto bravi a produrre testo plausibile.

Un output può essere:

- ordinato;
- elegante;
- grammaticalmente corretto;
- sicuro nel tono;
- ben strutturato;

ma comunque sbagliato.

---

== Regola pratica

Usare l’AI come:

- assistente;
- bozza;
- supporto;
- strumento di lavoro.

Non come:

- autorità finale;
- giudice;
- esperto infallibile;
- sostituto del controllo umano.

---

#focus-slide("Esempi da ufficio")

== Esempi pratici da ufficio

=== Esempio 1: email

Input grezzo:

#raw(block: true, lang: "txt", "Cliente arrabbiato. Consegna in ritardo. Scrivere risposta.")

Output AI:

#raw(block: true, lang: "txt", "Gentile cliente,\nci scusiamo per il disagio causato dal ritardo...")

Utilità:

- tono più professionale;
- meno tempo;
- struttura migliore.

---

== Esempio 2: riassunto

Input:

#raw(block: true, lang: "txt", "Documento di 12 pagine su una procedura interna.")

Output:

- riassunto breve;
- punti principali;
- responsabilità;
- scadenze;
- rischi;
- azioni da fare.

---

== Esempio 3: verbale di riunione

Appunti disordinati:

#raw(block: true, lang: "txt", "Mario sente fornitore.\nAnna aggiorna cliente.\nProblema fattura.\nScadenza venerdì.")

Output:

- sintesi riunione;
- decisioni prese;
- attività assegnate;
- responsabili;
- scadenze.

---

== Esempio 4: report

Input:

#raw(block: true, lang: "txt", "Vendite in calo a marzo.\nAumentati reclami su consegne.\nProblema concentrato nel nord Italia.")

Output:

- report breve;
- analisi;
- possibili cause;
- proposte operative;
- prossimi passi.

---

== Esempio 5: assistenza clienti

AI può aiutare a:

- leggere richieste;
- classificare problemi;
- individuare urgenza;
- proporre risposte;
- creare FAQ;
- trovare problemi ricorrenti.

---

== Esempio 6: amministrazione

AI può aiutare a:

- scrivere solleciti di pagamento;
- spiegare documenti;
- preparare checklist;
- riassumere contratti;
- organizzare scadenze;
- trasformare note in comunicazioni formali.

---

== Esempio 7: lavoro tecnico

AI può aiutare a:

- scrivere descrizioni tecniche;
- semplificare istruzioni;
- creare checklist di controllo;
- documentare procedure;
- preparare specifiche;
- riassumere note tecniche.

#alert[Ma la verifica tecnica resta responsabilità della persona.]

---

== Assaggio: prompt semplice

Questa parte anticipa la lezione sul Prompt Engineering.

#raw(block: true, lang: "txt", "Scrivi una email a un cliente per scusarti del ritardo.")

Problema:

- poco contesto;
- tono non specificato;
- lunghezza non specificata;
- mancano dettagli;
- risultato generico.

---

== Assaggio: prompt migliore

#raw(block: true, lang: "txt", "Agisci come assistente amministrativo.\nScrivi una email formale e gentile a un cliente.\nDevi scusarti per un ritardo di consegna di 2 giorni.\nNon ammettere responsabilità legali.\nProponi di ricontattarlo appena la spedizione parte.\nMassimo 120 parole.")

#alert[Più il prompt è chiaro, più il risultato è utile.]

---

== Data center, cloud e locale

=== Dove vivono i dati?

I dati non sono sospesi nell'aria.

Devono essere salvati fisicamente da qualche parte:

- su un computer;
- su un server aziendale;
- in un data center;
- nel cloud;
- su backup;
- su dispositivi distribuiti.

---

== Che cos'è un server?

Un server è un computer progettato per fornire servizi ad altri computer.

Esempi di servizi:

- sito web;
- email;
- database;
- file condivisi;
- applicazione aziendale;
- autenticazione utenti;
- backup.

#alert[Quando usiamo un'app online, quasi sempre stiamo parlando con server remoti.]

---

== Che cos'è un data center?

Un data center è un edificio o ambiente specializzato che ospita molti server.

Contiene:

- server;
- sistemi di rete;
- sistemi di alimentazione;
- gruppi di continuità;
- raffreddamento;
- sicurezza fisica;
- sistemi antincendio;
- monitoraggio continuo.

---

== Perché i data center sono importanti per l'AI?

L'AI moderna richiede molte risorse:

- dati;
- potenza di calcolo;
- GPU;
- memoria;
- rete veloce;
- sistemi di archiviazione;
- energia elettrica;
- raffreddamento.

#alert[Dietro una semplice chat AI può esserci un'enorme infrastruttura fisica.]

---

== GPU

Le GPU sono processori molto adatti a fare tanti calcoli in parallelo.

Sono nate per la grafica, ma sono diventate fondamentali per:

- deep learning;
- addestramento di modelli;
- inferenza AI;
- elaborazione immagini;
- simulazioni scientifiche.

---

== Addestramento vs uso del modello

=== Addestramento

Fase in cui il modello impara dai dati.

Richiede molte risorse.

=== Inferenza

Fase in cui il modello viene usato per rispondere a una richiesta.

Esempio:

#raw(block: true, lang: "txt", "Prompt dell'utente → modello già addestrato → risposta")

---

== Cloud

Il cloud significa usare risorse informatiche disponibili via Internet.

Esempi:

- archiviazione file;
- email;
- server virtuali;
- database gestiti;
- strumenti AI online;
- software in abbonamento;
- backup remoti.

#alert[Cloud non significa “senza computer”: significa computer di qualcun altro, accessibili via rete.]

---

== Locale / on-premise

Locale, o on-premise, significa che sistemi e dati sono gestiti direttamente dall'organizzazione.

Esempi:

- server in azienda;
- computer interni;
- software installato localmente;
- database aziendale interno;
- modello AI eseguito su infrastruttura propria.

---

== Cloud: vantaggi

Il cloud può offrire:

- scalabilità;
- accesso da remoto;
- aggiornamenti gestiti;
- minori costi iniziali;
- disponibilità rapida;
- servizi avanzati già pronti;
- backup e ridondanza;
- accesso a potenza di calcolo elevata.

---

== Cloud: svantaggi

Il cloud può portare problemi su:

- dipendenza dal fornitore;
- costi ricorrenti;
- privacy;
- localizzazione dei dati;
- connessione Internet necessaria;
- controllo limitato sull'infrastruttura;
- rischio di configurazioni sbagliate;
- lock-in tecnologico.

---

== Locale: vantaggi

Il locale può offrire:

- maggiore controllo;
- dati dentro l'organizzazione;
- minore dipendenza da fornitori esterni;
- possibilità di personalizzazione;
- funzionamento anche con rete esterna limitata;
- gestione diretta di sicurezza e accessi.

---

== Locale: svantaggi

Il locale richiede:

- investimento iniziale;
- personale tecnico;
- manutenzione;
- aggiornamenti;
- backup;
- sicurezza fisica;
- gestione guasti;
- capacità di scalare.

#alert[Il controllo ha un costo.]

---

== Cloud vs locale per l'AI

=== Cloud AI

Utile per:

- iniziare velocemente;
- usare modelli potenti;
- pagare a consumo;
- evitare infrastruttura complessa.

=== AI locale

Utile per:

- dati riservati;
- controllo;
- personalizzazioni;
- requisiti normativi;
- continuità interna.

---

== Domanda pratica

Prima di scegliere cloud o locale, chiedersi:

- che dati useremo?
- sono dati personali?
- sono dati aziendali riservati?
- serve scalare molto?
- abbiamo competenze tecniche interne?
- quanto possiamo spendere?
- quali obblighi normativi abbiamo?

---

== AI nella vita quotidiana

=== Non è una tecnologia lontana

L'AI è già presente in molti strumenti quotidiani.

Spesso la usiamo senza chiamarla AI.

#alert[Molte esperienze digitali moderne sono personalizzate o filtrate da sistemi AI.]

---

== Raccomandazioni

Sistemi di raccomandazione suggeriscono contenuti o prodotti.

Esempi:

- film su Netflix;
- video su YouTube;
- prodotti su Amazon;
- musica su Spotify;
- post sui social;
- articoli di news;
- annunci pubblicitari.

---

== Come funzionano le raccomandazioni?

Idea semplice:

- guardano cosa hai fatto tu;
- guardano cosa hanno fatto utenti simili;
- guardano caratteristiche degli oggetti;
- stimano cosa potrebbe interessarti;
- ordinano i contenuti.

#alert[Non vediamo tutto: vediamo ciò che il sistema decide di mostrarci per primo.]

---

== Raccomandazioni: vantaggi

Possono aiutare a:

- trovare contenuti interessanti;
- ridurre il tempo di ricerca;
- scoprire prodotti utili;
- personalizzare l'esperienza;
- aumentare vendite;
- migliorare engagement.

---

== Raccomandazioni: rischi

Possono anche creare:

- bolle informative;
- dipendenza da piattaforma;
- manipolazione dell'attenzione;
- esposizione a contenuti estremi;
- perdita di varietà;
- privacy issues.

#alert[La personalizzazione non è sempre neutrale.]

---

== Netflix Prize

Netflix lanciò una competizione pubblica per migliorare il proprio algoritmo di raccomandazione.

Obiettivo:

- migliorare la qualità dei suggerimenti;
- usare dati storici di valutazione;
- coinvolgere ricercatori e sviluppatori esterni.

#alert[Le raccomandazioni sono così importanti da valere investimenti enormi.]

---

== Filtri antispam

I filtri antispam classificano email come:

- legittime;
- sospette;
- spam;
- phishing.

Usano segnali come:

- parole nel testo;
- mittente;
- link;
- allegati;
- comportamento storico;
- somiglianza con messaggi già noti.

---

== Traduzione automatica

I traduttori automatici sono esempi quotidiani di AI.

Servono per:

- tradurre email;
- capire documenti;
- comunicare con clienti esteri;
- leggere manuali;
- supportare assistenza internazionale.

#alert[La traduzione è utile, ma va controllata nei testi tecnici o legali.]

---

== Riconoscimento vocale

Il riconoscimento vocale trasforma audio in testo.

Esempi:

- dettatura vocale;
- sottotitoli automatici;
- trascrizione riunioni;
- assistenti vocali;
- call center;
- comandi vocali in auto.

---

== Assistenti vocali

Esempi:

- Siri;
- Alexa;
- Google Assistant;
- assistenti in auto;
- sistemi domotici.

Possono:

- interpretare comandi;
- rispondere a domande;
- controllare dispositivi;
- impostare promemoria;
- cercare informazioni.

---

== Correzione e scrittura assistita

Strumenti di scrittura AI aiutano a:

- correggere errori;
- suggerire parole;
- migliorare tono;
- riscrivere frasi;
- semplificare testi;
- adattare stile;
- completare email.

#alert[Molte funzioni di office automation usano già AI da anni.]

---

== Mappe e navigazione

AI e algoritmi predittivi possono aiutare a:

- stimare traffico;
- suggerire percorsi;
- prevedere tempi di arrivo;
- rilevare incidenti;
- ottimizzare consegne;
- gestire flotte aziendali.

---

== Fotocamera dello smartphone

Molti smartphone usano AI per:

- riconoscere scene;
- migliorare foto;
- ridurre rumore;
- sfocare lo sfondo;
- riconoscere volti;
- organizzare album;
- leggere testo nelle immagini.

---

== Banking e antifrode

Le banche usano AI per rilevare:

- transazioni insolite;
- accessi sospetti;
- furti di identità;
- frodi con carte;
- pattern anomali;
- rischio di credito.

#alert[Qui l'AI lavora spesso dietro le quinte.]

---

== Customer service

Nel supporto clienti, l'AI può:

- rispondere a domande frequenti;
- aprire ticket;
- classificare richieste;
- suggerire risposte agli operatori;
- riassumere conversazioni;
- rilevare clienti insoddisfatti.

---

== E-commerce

Nell'e-commerce l'AI può aiutare con:

- raccomandazioni;
- ricerca prodotti;
- descrizioni automatiche;
- prezzi dinamici;
- previsione domanda;
- gestione resi;
- assistenza clienti;
- rilevazione frodi.

---

== Social media

Nei social media, l'AI può essere usata per:

- ordinare il feed;
- raccomandare contenuti;
- riconoscere immagini;
- moderare contenuti;
- suggerire amici;
- mostrare pubblicità;
- rilevare spam e bot.

#alert[Il feed non è una lista neutrale: è il risultato di algoritmi.]

---

== AI in industria e ricerca

=== Oltre l'ufficio

L'AI non serve solo per scrivere email.

È usata anche in:

- medicina;
- industria;
- robotica;
- biologia;
- chimica;
- fisica;
- logistica;
- progettazione;
- ricerca scientifica.

---

== Medicina e diagnostica

L'AI può supportare:

- analisi di immagini mediche;
- individuazione anomalie;
- supporto alla diagnosi;
- triage;
- previsione rischio;
- medicina personalizzata;
- analisi di letteratura scientifica.

#alert[Supporto non significa sostituzione del medico.]

---

== Manutenzione predittiva

Obiettivo:

prevedere guasti prima che accadano.

Dati usati:

- vibrazioni;
- temperatura;
- rumore;
- storico guasti;
- tempi di lavoro;
- log macchina.

Vantaggio:

- meno fermi macchina;
- meno costi;
- più sicurezza.

---

== Robotica

In robotica l'AI può aiutare a:

- percepire l'ambiente;
- evitare ostacoli;
- pianificare movimenti;
- manipolare oggetti;
- collaborare con persone;
- adattarsi a situazioni nuove.

---

== Veicoli autonomi

I veicoli autonomi combinano molti sottosistemi:

- sensori;
- visione artificiale;
- mappe;
- pianificazione;
- controllo;
- previsione del comportamento altrui;
- sicurezza.

#alert[È un problema molto più difficile che “riconoscere la strada”.]

---

== CAD e progettazione

In ambito tecnico l'AI può aiutare a:

- generare varianti progettuali;
- controllare documentazione;
- scrivere specifiche;
- cercare componenti simili;
- suggerire checklist;
- supportare simulazioni;
- migliorare comunicazione tecnica.

---

== Musica e creatività

L'AI generativa può produrre:

- melodie;
- accompagnamenti;
- effetti sonori;
- testi;
- bozze creative;
- variazioni di stile;
- idee per contenuti.

#alert[Questo apre anche domande su copyright, originalità e lavoro creativo.]

---

== Immagini generate

L'AI può generare immagini da testo.
#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
Esempi:

- bozzetti;
- concept art;
- immagini per presentazioni;
- prototipi visivi;
- moodboard;
- illustrazioni;
- mockup.
][
Rischi:

- immagini false;
- deepfake;
- bias;
- copyright;
- uso ingannevole.
]
---

== Ricerca: apprendimento per rinforzo

L'apprendimento per rinforzo è usato quando un agente deve imparare agendo.

Esempi:

- giochi;
- robotica;
- controllo industriale;
- ottimizzazione;
- simulazioni;
- strategie in ambienti complessi.

#alert[L'idea è imparare da premi e penalità.]

---

== Ricerca: AlphaFold

AlphaFold è un esempio famoso di AI applicata alla biologia.

Ha mostrato come modelli avanzati possano aiutare a prevedere strutture proteiche.

Impatto potenziale:

- biologia molecolare;
- ricerca farmaceutica;
- comprensione di malattie;
- accelerazione della ricerca scientifica.

---

== Ricerca: swarm robotics

Swarm robotics studia gruppi di robot che collaborano.

Ispirazione:

- formiche;
- api;
- stormi;
- banchi di pesci.

Idea:

molti agenti semplici possono produrre comportamenti collettivi complessi.

---

== Ricerca: AI per la scienza

L'AI può aiutare nella ricerca scientifica per:

- analizzare grandi dataset;
- trovare pattern;
- simulare fenomeni;
- suggerire ipotesi;
- automatizzare esperimenti;
- leggere letteratura scientifica;
- progettare nuovi materiali.

---

== Ricerca: AI e simulazioni

In molti campi non possiamo fare esperimenti reali infiniti.

L'AI può essere combinata con simulazioni per:

- testare scenari;
- ridurre costi;
- esplorare possibilità;
- ottimizzare parametri;
- prevedere comportamenti.

Esempi:

- clima;
- materiali;
- fluidodinamica;
- logistica;
- traffico.

---

#focus-slide("Esercizi")

== Esercizio 1

=== Identificare dati in un processo

Processo:

#raw(block: true, lang: "txt", "Un cliente ordina un prodotto.\nIl magazzino prepara il pacco.\nIl corriere consegna in ritardo.\nIl cliente scrive una email.\nL’azienda offre uno sconto.")

Domanda:

#raw(block: true, lang: "txt", "Quali dati vengono prodotti in ogni fase?")

---

== Esercizio 2

=== Trovare il valore

Per ogni fonte dati, chiediamoci:

#raw(block: true, lang: "txt", "Come può aiutare l’azienda?")

Fonti:

- email clienti;
- vendite storiche;
- ticket assistenza;
- dati di magazzino;
- dati macchina;
- note commerciali.

---

== Esercizio 3

=== Classificare il tipo di problema

È classificazione, regressione, clustering o generazione?

- prevedere vendite;
- scrivere una email;
- individuare reclami;
- raggruppare ticket simili;
- stimare ritardo consegna;
- generare un report;
- classificare documenti.

---

== Esercizio 4

=== Dato personale o aziendale?

Classificare:

- email cliente;
- listino riservato;
- numero di telefono;
- disegno tecnico;
- contratto fornitore;
- indirizzo di consegna;
- margine commerciale;
- certificato medico.

#alert[Alcuni dati possono appartenere a più categorie.]

---

== Messaggio chiave 1

I dati sono ovunque.

Non sono solo numeri.

Possono essere:

- testi;
- immagini;
- documenti;
- conversazioni;
- azioni;
- transazioni;
- log;
- misurazioni.

---

== Messaggio chiave 2

Le aziende moderne generano enormi quantità di dati perché i processi sono digitali.

Ogni attività lascia una traccia:

- ordine;
- email;
- pagamento;
- ticket;
- documento;
- spedizione;
- macchina;
- riunione.

#alert[L’azienda moderna è anche una macchina che produce dati.]

---

== Messaggio chiave 3

I dati possono creare ricchezza quando permettono di:

- ridurre costi;
- aumentare vendite;
- migliorare qualità;
- capire i clienti;
- automatizzare attività;
- evitare errori;
- prendere decisioni migliori.

---

== Messaggio chiave 4

L’AI non è magia.

Funziona usando:

- dati;
- esempi;
- schemi;
- probabilità;
- modelli.

#alert[Può essere molto utile, ma può anche sbagliare.]

---

== Messaggio chiave 5

Il Machine Learning serve quando non sappiamo scrivere tutte le regole a mano.

Invece di programmare ogni eccezione:

- forniamo esempi;
- il sistema trova schemi;
- il modello lavora su nuovi casi.

---

== Messaggio chiave 6

L’AI generativa è utile in ufficio perché lavora bene con il linguaggio.

Può aiutare a:

- scrivere;
- riassumere;
- correggere;
- tradurre;
- organizzare;
- spiegare;
- trasformare documenti.

#alert[Ma serve sempre revisione umana.]

---

== Domande finali

Per chiudere:

- quali dati usate ogni giorno nel vostro lavoro?
- quali dati sono più delicati?
- quali attività ripetitive potrebbero essere aiutate dall'AI?
- dove vedete più opportunità?
- dove vedete più rischi?