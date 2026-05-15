#import "@preview/touying:0.6.3": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
#let pdfpc-config = pdfpc.config(
    duration-minutes: 480,
    last-minutes: 10,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 1,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [06 - Large Language Models],
    subtitle: [AI Generativa e Prompt Engineering @ FORMart 2026],
    author: author_list(
      (
        (first_author("Davide Domini"), "davide.domini@unibo.it"),
      )
    ),
    date: datetime.today().display("[day] [month repr:long] [year]"),
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#set raw(tab-size: 4)
#show raw: set text(size: 0.95em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

#title-slide()

== Obiettivo della lezione

Oggi vogliamo capire:

- perché Bag of Words non basta;
- cosa sono gli embeddings;
- perché il contesto cambia il significato;
- cos'è l'attention;
- perché i Transformer sono importanti;
- cosa sono gli LLM;
- come vengono addestrati a grandi linee;
- che tipi di modelli esistono oggi;
- quali tradeoff contano per un utilizzatore finale.

---

== Da dove partiamo

NLP classico:

- tokenizzazione;
- Bag of Words;
- TF-IDF;
- n-grammi;
- classificatori;
- feature manuali.

Problema:

#alert[Le parole vengono trattate spesso come simboli separati, non come significati in contesto.]

---

== Esempio: parole diverse, stesso senso

#raw(block: true, lang: "txt", "Il pacco è in ritardo.\nLa spedizione non è ancora arrivata.\nLa consegna tarda ad arrivare.")

Queste frasi sono simili.

Ma con parole diverse.

Un sistema a parole chiave può faticare.

---

== Esempio: stessa parola, senso diverso

#raw(block: true, lang: "txt", "Ho aperto un conto in banca.\nMi sono seduto sulla banca di legno.\nLa barca si è incagliata su una banca di sabbia.")

La stessa parola può cambiare significato.

Serve contesto.

---

== L'idea degli embeddings

Un embedding è una rappresentazione numerica densa.

In modo intuitivo:

#raw(block: true, lang: "txt", "parola o frase → punto in uno spazio di significato")

Parole o frasi simili stanno vicine.

---

== Embedding come mappa

Pensate a una mappa geografica.

Città vicine sulla mappa sono vicine nello spazio.

Con gli embeddings:

- concetti simili sono vicini;
- concetti diversi sono lontani;
- la distanza diventa informazione.

---

== Esempio di vicinanza semantica

Parole vicine:

- fattura;
- pagamento;
- scadenza;
- importo;
- bonifico.

Altro gruppo:

- spedizione;
- corriere;
- consegna;
- magazzino;
- ritardo.

#image("assets/image-54.png")

#image("assets/image-55.png")

---

== Vediamo uno spazio degli embedding

#link("https://projector.tensorflow.org/")

---

== Perché è utile?

Con gli embeddings possiamo fare:

- ricerca semantica;
- raggruppamento di documenti;
- raccomandazioni;
- confronto tra testi;
- recupero informazioni;
- assistenti su documenti aziendali.

#alert[Non cerchiamo solo parole uguali, ma significati simili.]

---

== Ricerca classica vs ricerca semantica

Ricerca classica:

#raw(block: true, lang: "txt", "Trova documenti che contengono la parola 'rimborso'.")

Ricerca semantica:

#raw(block: true, lang: "txt", "Trova documenti che parlano del concetto di restituzione denaro.")

---

== Esempio pratico

Cerco:

#raw(block: true, lang: "txt", "cliente vuole indietro i soldi")

Documenti trovabili semanticamente:

- richiesta rimborso;
- restituzione importo;
- storno pagamento;
- nota di credito;
- contestazione addebito.

---

== Embeddings di parole

I primi embeddings moderni rappresentavano parole.

Esempio:

#raw(block: true, lang: "txt", "cliente → [0.12, -0.41, 0.03, ...]")

Non importa il numero specifico.

Conta che parole simili abbiano vettori simili.

---

== Embeddings di frasi

Oggi possiamo rappresentare anche intere frasi o documenti.

#raw(block: true, lang: "txt", "Il pacco è arrivato in ritardo → vettore")

Questo permette di confrontare testi interi, non solo singole parole.

---

== Problema: embeddings statici

Se una parola ha un solo embedding fisso, abbiamo un problema.

Esempio:

#raw(block: true, lang: "txt", "banca")

Quale significato rappresenta?

- istituto finanziario;
- seduta;
- banco di sabbia?

---

== Servono embeddings contestuali

Un embedding contestuale cambia in base alla frase.

#raw(block: true, lang: "txt", "Ho acceso il mouse del computer.\nIl gatto ha visto un mouse? No, un topo.")

Il significato dipende dal contesto.

---

== Dal significato al contesto

Il salto importante è questo:

#raw(block: true, lang: "txt", "Non basta sapere quali parole ci sono.\nServe capire quali parole contano per interpretare le altre.")

Qui entra in gioco l'attention.

---

== Attention: idea intuitiva

Attention significa: quando elaboro una parola, decido a quali altre parole devo prestare attenzione.

Non tutte le parole contano allo stesso modo.

#alert[È come evidenziare le parti importanti di una frase.]

---

== Esempio di attention

Frase:

#raw(block: true, lang: "txt", "Il tecnico ha chiamato il cliente perché era preoccupato.")

Domanda:

#raw(block: true, lang: "txt", "Chi era preoccupato?")

Serve capire a cosa si riferisce “era”.

---

== Attention in una frase lunga

#raw(block: true, lang: "txt", "Il contratto, dopo varie modifiche richieste dal cliente e controllate dal legale, è stato finalmente approvato.")

Per capire “approvato”, il modello deve collegarsi a “contratto”.

Anche se sono lontani.

---

== Metafora: evidenziatore intelligente

Immaginate di leggere un documento con un evidenziatore.

Per rispondere a una domanda, non evidenziate tutto.

Evidenziate:

- nomi;
- date;
- riferimenti;
- frasi chiave;
- collegamenti importanti.

L'attention fa qualcosa di simile.

#align(center)[
#image("assets/image-56.png")
]
---

== Attention vs RNN

RNN:

- legge in sequenza;
- una parola dopo l'altra;
- può dimenticare informazioni lontane;
- addestramento più difficile su testi lunghi.

Attention:

- collega direttamente parti diverse del testo;
- gestisce meglio dipendenze lunghe;
- è più parallelizzabile.

---

== Self-attention

Self-attention significa che le parole della stessa frase si guardano tra loro.

Ogni token chiede:

#raw(block: true, lang: "txt", "Quali altri token mi servono per essere interpretato correttamente?")

---

== Esempio self-attention

#raw(block: true, lang: "txt", "La fattura è scaduta, ma il cliente dice di averla pagata.")

Per capire “averla”, bisogna collegarsi a “fattura”.

---

== Transformer

Il Transformer è l'architettura che ha reso possibile la maggior parte degli LLM moderni.

Idea chiave:

- usa attention in modo massiccio;
- elabora sequenze in modo efficiente;
- costruisce rappresentazioni contestuali;
- scala bene con tanti dati e tanta potenza di calcolo.

---

== Perché il Transformer è importante?

Ha cambiato il modo di lavorare con:

- testo;
- immagini;
- audio;
- codice;
- documenti;
- dati multimodali.

#alert[Non è solo una tecnica per chatbot: è una famiglia di architetture molto generale.]

---

== Cosa significa “scala bene”?

Vuol dire che migliorando:

- quantità di dati;
- grandezza del modello;
- potenza di calcolo;
- qualità dell'addestramento;

le prestazioni possono crescere molto.

Questo ha spinto la nascita degli LLM.

---

== Com'é fatto un Transformer?

#align(center)[
#image("assets/image-60.png")
]

#align(center)[
#image("assets/image-57.png")
]

--- 

== Ma perdiamo comunque l'ordine!

I soli embedding non ci bastano a capire in che ordine erano le parole nella frase originale.

---

== Position Embeddings

#align(center)[
#image("assets/image-58.png")
]


#align(center)[
#image("assets/image-59.png")
]

---

== LLM: definizione semplice

LLM significa Large Language Model.

È un modello linguistico molto grande, addestrato su enormi quantità di testo e altri dati.

Sa produrre testo plausibile continuando una sequenza.

#alert[Alla base, impara a prevedere il prossimo pezzo di testo.]

---

== Il gioco del “prossimo token”

Input:

#raw(block: true, lang: "txt", "Il cliente chiede un rimborso perché il prodotto è arrivato...")

Il modello deve prevedere il prossimo token probabile:

- rotto;
- danneggiato;
- in ritardo;
- incompleto.

---

== Sembra banale, ma non lo è

Per prevedere bene il prossimo token, il modello deve imparare moltissime cose:

- grammatica;
- fatti comuni;
- stile;
- strutture dei documenti;
- relazioni tra concetti;
- codice;
- lingue;
- ragionamenti ricorrenti.

---

== Da completamento a conversazione

Il modello di base completa testo.

Il prodotto finale, tipo chatbot, aggiunge:

- istruzioni;
- interfaccia conversazionale;
- filtri di sicurezza;
- memoria o cronologia;
- strumenti esterni;
- ricerca web;
- caricamento file;
- integrazioni aziendali.

---

== Modello base vs assistente

Modello base:

#raw(block: true, lang: "txt", "continua una sequenza di testo")

Assistente:

#raw(block: true, lang: "txt", "segue istruzioni, dialoga, usa strumenti, rispetta vincoli")

#alert[La chat è un prodotto costruito sopra il modello.]

---

== Fasi di addestramento: visione semplice

1. Pretraining su molti dati.
2. Addestramento a seguire istruzioni.
3. Allineamento con feedback umano o automatico.
4. Test di sicurezza.
5. Integrazione in prodotti.


---

== Pretraining

Il pretraining è la fase in cui il modello impara molto dal testo.

Esempi di dati:

- libri;
- pagine web;
- codice;
- articoli;
- documentazione;
- dialoghi;
- dati multimodali nei modelli più recenti.

---

== Instruction tuning

Dopo il pretraining, il modello deve imparare a rispondere a istruzioni.

Esempio:

#raw(block: true, lang: "txt", "Riassumi questo testo in 5 punti.")

Non basta completare testo: deve capire il compito richiesto.

---

== Allineamento

Allineamento significa cercare di rendere il modello più utile, sicuro e coerente con le aspettative umane.

Esempi:

- evitare risposte pericolose;
- seguire meglio le istruzioni;
- ammettere incertezza;
- ridurre tossicità;
- migliorare tono e utilità.

---

== LLM non significa verità

Un LLM genera testo plausibile.

Può essere:

- corretto;
- incompleto;
- inventato;
- vecchio;
- non verificato;
- troppo sicuro.

#alert[Un output ben scritto non è automaticamente vero.]

---

== Allucinazioni
Un'allucinazione è quando il modello produce informazioni false o inventate.

Esempi:

- cita una fonte inesistente;
- inventa una norma;
- sbaglia un numero;
- attribuisce una frase alla persona sbagliata;
- inventa dettagli non presenti nel documento.

---

== Perché succede?

Perché il modello non consulta sempre una base di verità.

Spesso genera ciò che è linguisticamente plausibile.

Se non sa, può comunque completare la risposta in modo credibile.

#alert[La plausibilità linguistica non equivale alla verifica.]

---

== Come ridurre il problema

Per ridurre le allucinazioni:

- dare contesto chiaro;
- chiedere di indicare incertezza;
- usare fonti verificabili;
- usare retrieval su documenti;
- controllare numeri e date;
- chiedere citazioni;
- far revisionare a un umano.

---

== RAG: Retrieval-Augmented Generation

RAG significa combinare generazione e recupero documenti.

Flusso:

#raw(block: true, lang: "txt", "domanda → cerca documenti rilevanti → passa documenti al modello → genera risposta")

È molto usato in contesti aziendali.

---

== Perché RAG è utile in azienda?

Perché il modello può rispondere usando:

- policy interne;
- manuali;
- documenti tecnici;
- procedure;
- FAQ;
- contratti;
- conoscenza aggiornata.

#alert[Il modello non deve sapere tutto: può recuperare il contesto giusto.]

---

== LLM e memoria

Attenzione a distinguere:

- memoria del prodotto;
- cronologia chat;
- contesto della conversazione;
- documenti caricati;
- dati di addestramento;
- strumenti esterni.

Sono cose diverse.

---

== Contesto della conversazione

Il contesto è ciò che il modello “vede” nella conversazione corrente.

Se un'informazione non è nel contesto o negli strumenti disponibili, il modello potrebbe non averla.

#alert[Il modello non ricorda magicamente tutto.]

---

== Context window

La context window è la quantità di testo che il modello può considerare in una richiesta.

Può includere:

- prompt;
- messaggi precedenti;
- documenti caricati;
- output intermedi;
- istruzioni di sistema.

---

== Context window grande: vantaggi

Una finestra di contesto grande permette di:

- analizzare documenti lunghi;
- confrontare più testi;
- mantenere più dettagli;
- lavorare su codice esteso;
- gestire conversazioni complesse.

---

== Context window grande: svantaggi

Non significa automaticamente qualità migliore.

Problemi possibili:

- costo maggiore;
- lentezza;
- distrazione del modello;
- difficoltà a trovare il dettaglio giusto;
- rischio di includere dati non necessari.

---

== Modelli piccoli e modelli grandi

Modelli grandi:

- più capacità generale;
- migliore ragionamento;
- più robusti su task complessi;
- più costosi;
- più lenti;
- richiedono più infrastruttura.

Modelli piccoli:

- economici;
- veloci;
- più facili da eseguire localmente;
- buoni per task specifici;
- meno capaci su problemi complessi.


#align(center)[
#image("assets/image-61.png")
]

---

== Parametri: idea intuitiva

I parametri sono i numeri interni del modello che vengono imparati durante l'addestramento.

Metafora:

#raw(block: true, lang: "txt", "Sono le manopole interne che regolano come il modello trasforma input in output.")

Più parametri non significa sempre migliore, ma spesso aumenta la capacità.

---

== Modelli specializzati

Non tutti i modelli devono essere generali.

Esistono modelli specializzati per:

- codice;
- medicina;
- finanza;
- legale;
- traduzione;
- speech;
- embeddings;
- immagini;
- moderazione.

---

== Modelli multimodali

I modelli più recenti possono lavorare con più modalità:

- testo;
- immagini;
- audio;
- video;
- codice;
- documenti.

Esempio:

#raw(block: true, lang: "txt", "Carico una foto di un componente e chiedo una descrizione tecnica.")

---

== Open, closed, open weights

Termini da distinguere:

- closed/proprietario: modello accessibile via prodotto o API;
- open weights: pesi scaricabili, ma licenza non sempre pienamente open source;
- open source: maggiore apertura di codice, pesi, licenza e possibilità di modifica.

#alert[“Open” non vuol dire sempre la stessa cosa.]

---

== Modelli chiusi: vantaggi

Vantaggi tipici:

- ottime prestazioni;
- interfaccia pronta;
- manutenzione gestita dal fornitore;
- aggiornamenti frequenti;
- integrazioni;
- sicurezza e compliance contrattuale nei piani business.

---

== Modelli chiusi: svantaggi

Svantaggi possibili:

- dipendenza dal fornitore;
- costi variabili;
- meno controllo tecnico;
- dati inviati a servizi esterni;
- cambiamenti di modello o policy;
- meno trasparenza.

---

== Modelli open-weight: vantaggi

Vantaggi:

- maggiore controllo;
- possibilità di esecuzione locale;
- personalizzazione;
- costi prevedibili in certi scenari;
- indipendenza dal vendor;
- utili per ricerca e sperimentazione.

---

== Modelli open-weight: svantaggi

Svantaggi:

- servono competenze tecniche;
- serve hardware adeguato;
- sicurezza da gestire;
- aggiornamenti a carico proprio;
- prestazioni non sempre pari ai migliori modelli chiusi;
- licenze da leggere con attenzione.

---

== Cloud vs locale per gli LLM

Cloud:

- facile da usare;
- potenza disponibile;
- modelli aggiornati;
- paghi a consumo o abbonamento.

Locale:

- più controllo;
- possibile maggiore privacy;
- funziona anche offline;
- richiede hardware e manutenzione.

---

== Tradeoff per l'utente finale

Quando scegliete uno strumento, chiedetevi:

- quanto è sensibile il dato?
- quanto deve essere accurato il risultato?
- serve velocità?
- serve basso costo?
- serve integrazione con Office?
- serve lavorare su documenti lunghi?
- serve generare testo o solo cercare informazioni?

---

== Modelli disponibili oggi: esempi

Esempi di famiglie note:

- OpenAI GPT;
- Anthropic Claude;
- Google Gemini;
- Meta Llama;
- Mistral;
- modelli specializzati per codice, audio, immagini, embeddings.

#alert[Il panorama cambia velocemente: la scelta va aggiornata nel tempo.]

---

== Costo: non solo abbonamento

Il costo reale include:

- prezzo per uso;
- tempo risparmiato;
- errori evitati;
- tempo di verifica;
- formazione utenti;
- integrazione;
- gestione dati;
- rischio di vendor lock-in.

---

== Latenza

Latenza significa tempo di risposta.

Conta molto quando:

- l'utente aspetta davanti allo schermo;
- il sistema deve rispondere in tempo reale;
- si fanno molte chiamate API;
- si automatizzano processi.

---

== Accuratezza vs velocità

Spesso c'è un tradeoff:

- modello grande: più accurato ma più lento/costoso;
- modello piccolo: più veloce ma meno robusto;
- modello specializzato: ottimo su un compito, meno generale.

---

== Privacy e dati

Domande importanti:

- i dati escono dall'azienda?
- dove vengono processati?
- vengono usati per addestramento?
- esiste un contratto business?
- ci sono log?
- chi può accedere?
- il dato è personale o riservato?

---

== Fine-tuning

Fine-tuning significa riaddestrare o adattare un modello su dati specifici.

Può servire per:

- stile aziendale;
- dominio tecnico;
- classificazioni specifiche;
- formato output;
- task ripetitivi.

Ma non è sempre necessario.

---

== Fine-tuning non è magia

Prima del fine-tuning, spesso conviene provare:

- prompt migliori;
- esempi nel prompt;
- RAG;
- template;
- workflow;
- modelli più adatti;
- pulizia dei dati.

#alert[Molti problemi si risolvono senza addestrare un modello nuovo.]

---

== Quando può servire fine-tuning?

Ha senso quando:

- il task è molto ripetitivo;
- avete molti esempi buoni;
- serve output coerente;
- il prompt non basta;
- il dominio è specifico;
- il volume d'uso giustifica il costo.

---

== Embeddings + database vettoriale

Una soluzione aziendale comune:

1. trasformo documenti in embeddings;
2. salvo gli embeddings in un database vettoriale;
3. cerco documenti simili alla domanda;
4. passo i risultati all'LLM;
5. genero una risposta.

---

== Database vettoriale: intuizione

Un database tradizionale cerca valori esatti.

Un database vettoriale cerca vicinanza di significato.

Esempio:

#raw(block: true, lang: "txt", "domanda: come faccio a chiedere rimborso?\ntrova documenti semanticamente vicini")

---

== AI agenti

Sempre più strumenti non si limitano a rispondere.

Possono:

- usare tool;
- cercare file;
- eseguire codice;
- leggere email;
- creare documenti;
- pianificare passaggi;
- chiedere conferme.

#alert[Più autonomia significa più utilità, ma anche più controllo necessario.]

---

== LLM e strumenti esterni

Un LLM da solo genera testo.

Con strumenti può:

- fare calcoli;
- consultare documenti;
- navigare web;
- interrogare database;
- creare file;
- chiamare API.

Questo aumenta molto le possibilità.

---

== Esempio: scelta modello per email

Task: riscrivere email in tono professionale.

Probabilmente basta:

- modello piccolo/medio;
- costo basso;
- buona velocità;
- prompt chiaro;
- verifica umana.

Non serve sempre il modello più potente.

---

== Esempio: analisi contratto

Task: leggere un contratto lungo e trovare rischi.

Serve valutare:

- contesto lungo;
- qualità su documenti legali;
- privacy;
- citazioni precise;
- controllo umano esperto;
- eventuale ambiente enterprise.

---

== Esempio: assistente documentale interno

Task: rispondere usando manuali aziendali.

Soluzione tipica:

- embeddings;
- database vettoriale;
- RAG;
- LLM;
- fonti citate;
- permessi di accesso;
- logging e controllo.

---

== Come valutare uno strumento LLM

Non basta chiedersi “è intelligente?”.

Chiediamoci:

- è utile per il mio task?
- sbaglia in modo pericoloso?
- posso verificare?
- quanto costa?
- dove finiscono i dati?
- è integrabile?
- gli utenti lo capiscono?

---

== Benchmark

I benchmark sono test standardizzati.

Servono per confrontare modelli.

Ma hanno limiti:

- possono non rappresentare il vostro caso;
- possono diventare saturi;
- possono essere ottimizzati;
- non misurano sempre usabilità e sicurezza.

---

== Testare sul proprio caso

La valutazione migliore è spesso un piccolo test realistico.

Esempi:

- 20 email reali anonimizzate;
- 10 documenti aziendali;
- 30 ticket storici;
- 5 report da riassumere;
- 10 domande frequenti.

---

== Ponte al Prompt Engineering

Capire come funzionano gli LLM aiuta a usarli meglio.

Nel prossimo pacco vedremo come scrivere richieste efficaci.

#alert[Prompt Engineering = progettare bene l'interazione con il modello.]
