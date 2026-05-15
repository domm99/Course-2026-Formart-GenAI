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
    title: [05 - Natural Language Processing],
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

Oggi vogliamo capire come si fa a lavorare con il testo usando il Machine Learning.

Alla fine dovreste avere chiaro:

- perché il testo è un dato difficile;
- come si trasforma una frase in numeri;
- cosa sono token, vocabolario e vettori;
- cos'è il Bag of Words;
- perché il contesto è un problema;
- quali task NLP esistono prima degli LLM;
- perché il NLP classico ha dei limiti.

---

== Da dove arriviamo

Abbiamo già visto:

- Machine Learning classico;
- regressione e classificazione;
- reti neurali;
- CNN per immagini;
- RNN per sequenze;
- idea di feature;
- idea di modello che trasforma input in output.

Oggi prendiamo un input molto speciale: il linguaggio umano.

---

== Il problema nuovo: il testo

Con le immagini abbiamo pixel.

Con le serie temporali abbiamo valori ordinati nel tempo.

Con il testo abbiamo parole, frasi, significati, contesto, ambiguità.

#alert[Il computer non capisce direttamente le parole: vede numeri.]

---

== Domanda guida

Come facciamo a trasformare questa frase:

#raw(block: true, lang: "txt", "Il cliente chiede un rimborso urgente")

in qualcosa che un modello possa elaborare?

---

== Perché il testo è complicato?

Il linguaggio umano è:

- ambiguo;
- pieno di sinonimi;
- dipendente dal contesto;
- diverso da persona a persona;
- pieno di sottintesi;
- pieno di errori, abbreviazioni e modi di dire.

Esempio:

#raw(block: true, lang: "txt", "Fantastico, un altro ritardo.")

È positivo o sarcastico?

---

== Testo come dato non strutturato

Una tabella ha colonne precise.

Un testo invece può avere:

- lunghezza variabile;
- parole non previste;
- errori grammaticali;
- contesto implicito;
- tono emotivo;
- riferimenti a cose dette prima.

#alert[Per questo il NLP è storicamente difficile.]

---

== NLP: definizione intuitiva

NLP significa Natural Language Processing.

In italiano: elaborazione del linguaggio naturale.

È l'insieme di tecniche che permettono ai computer di lavorare con:

- testo;
- frasi;
- documenti;
- email;
- chat;
- audio trascritto;
- linguaggio umano.

---

== Esempi di NLP quotidiano

Usiamo NLP quando:

- cerchiamo qualcosa su Google;
- usiamo un traduttore automatico;
- dettiamo un messaggio vocale;
- riceviamo suggerimenti della tastiera;
- filtriamo email spam;
- chiediamo a un assistente vocale;
- usiamo un chatbot;
- riassumiamo un documento.

---

== Prima analogia: la macchina traduttrice

Una macchina non legge come noi.

Per lei la frase deve diventare una rappresentazione numerica.

#raw(block: true, lang: "txt", "testo umano → trasformazione → numeri → modello → risultato")

Il cuore del NLP classico è proprio questa trasformazione.

---

== Pipeline NLP classica

Una pipeline tipica:

1. raccolta dei testi;
2. pulizia;
3. tokenizzazione;
4. normalizzazione;
5. trasformazione in numeri;
6. addestramento modello;
7. valutazione;
8. uso su testi nuovi.

---

== Esempio: classificare email

Obiettivo:

#raw(block: true, lang: "txt", "Data una email, decidere se è un reclamo, una richiesta normale o spam.")

Input:

#raw(block: true, lang: "txt", "Il prodotto è arrivato danneggiato. Vorrei una sostituzione urgente.")

Output:

#raw(block: true, lang: "txt", "Categoria: reclamo")

---

== Step 1 — Raccolta dati

Per addestrare un sistema ci servono esempi.

Esempi:

- email vecchie;
- ticket assistenza;
- recensioni;
- messaggi dei clienti;
- FAQ;
- documenti aziendali;
- descrizioni prodotto.

#alert[Senza dati, non c'è apprendimento.]

---

== Step 2 — Etichette

Se vogliamo classificare, ci servono etichette.

Esempio:

#raw(block: true, lang: "txt", "Email 1 → reclamo\nEmail 2 → richiesta informazioni\nEmail 3 → spam\nEmail 4 → assistenza tecnica")

Queste etichette sono la risposta corretta che il modello userà per imparare.

---

== Step 3 — Pulizia del testo

Prima di usare i testi, spesso li puliamo.

Esempi:

- togliere spazi inutili;
- uniformare maiuscole/minuscole;
- rimuovere simboli non utili;
- correggere errori grossolani;
- togliere firme automatiche;
- togliere HTML dalle email;
- anonimizzare dati personali.

---

== Pulizia: esempio

Testo originale:

#raw(block: true, lang: "txt", "BUONGIORNO!!!\nIl mio pacco è in ritardo...\n\nInviato da iPhone")

Testo pulito:

#raw(block: true, lang: "txt", "buongiorno il mio pacco è in ritardo")

#alert[Pulire troppo però può eliminare informazioni utili.]

---

== Attenzione alla pulizia

A volte la punteggiatura conta.

Esempio:

#raw(block: true, lang: "txt", "Grazie.")

non ha lo stesso tono di:

#raw(block: true, lang: "txt", "Grazie!!!")

La pulizia non è neutrale: è una scelta progettuale.

---

== Step 4 — Tokenizzazione

Tokenizzare significa dividere un testo in pezzi.

Esempio:

#raw(block: true, lang: "txt", "Il cliente chiede un rimborso urgente")

può diventare:

#raw(block: true, lang: "txt", "[Il] [cliente] [chiede] [un] [rimborso] [urgente]")

---

== Cos'è un token?

Un token può essere:

- una parola;
- una parte di parola;
- un simbolo;
- un numero;
- un segno di punteggiatura.

Nel NLP classico spesso si usavano parole intere.

Negli LLM moderni si usano spesso pezzi di parola.

---

== Perché non usare sempre parole intere?

Perché il linguaggio ha tantissime varianti.

Esempi:

- consegna;
- consegne;
- consegnato;
- consegnare;
- riconsegna;
- riconsegnare.

Se trattiamo ogni parola come completamente diversa, perdiamo informazioni.

---

== Vocabolario

Il vocabolario è l'elenco dei token conosciuti dal sistema.

Esempio:

#raw(block: true, lang: "txt", "[cliente, consegna, ritardo, rimborso, urgente, fattura]")

Ogni parola viene associata a una posizione o a un numero.

---

== Problema: parole mai viste

Se una parola non è nel vocabolario, il sistema classico può non sapere cosa farci.

Esempio:

#raw(block: true, lang: "txt", "La spedizione è in giacenza")

Se “giacenza” non è nel vocabolario, il modello potrebbe perdere un'informazione importante.

---

== Normalizzazione

Normalizzare significa rendere le parole più uniformi.

Esempi:

- maiuscole/minuscole;
- singolare/plurale;
- forme verbali;
- accenti;
- punteggiatura.

Obiettivo: ridurre variazioni inutili.

---

== Stemming

Lo stemming taglia le parole per portarle a una radice grezza.

Esempio:

#raw(block: true, lang: "txt", "consegna, consegnato, consegnare → consegn")

È semplice e veloce, ma può essere brutale.

---

== Lemmatizzazione

La lemmatizzazione prova a riportare le parole alla forma base corretta.

Esempio:

#raw(block: true, lang: "txt", "consegnato → consegnare\nclienti → cliente\nmigliori → migliore")

È più precisa, ma richiede più conoscenza linguistica.

---

== Stop words

Le stop words sono parole molto frequenti che a volte si eliminano.

Esempi:

- il;
- la;
- di;
- a;
- con;
- per;
- che.

Ma attenzione: non sempre sono inutili.

---

== Quando le stop words contano

Frase 1:

#raw(block: true, lang: "txt", "Il cliente ha pagato")

Frase 2:

#raw(block: true, lang: "txt", "Il cliente non ha pagato")

La parola “non” è piccola, ma cambia tutto.

#alert[Le regole semplici possono creare errori grossi.]

---

== Bag of Words

Bag of Words significa “sacco di parole”.

L'idea è semplice:

- ignoro l'ordine delle parole;
- conto quali parole compaiono;
- trasformo il testo in una tabella di numeri.

#alert[È semplice, ma sorprendentemente utile per molti task.]

---

== Bag of Words: esempio

Frasi:

#raw(block: true, lang: "txt", "A: consegna in ritardo\nB: richiesta rimborso urgente")

Vocabolario:

#raw(block: true, lang: "txt", "[consegna, ritardo, richiesta, rimborso, urgente]")

Rappresentazione:

#raw(block: true, lang: "txt", "A: [1, 1, 0, 0, 0]\nB: [0, 0, 1, 1, 1]")

---

== Il testo diventa un vettore

Una frase può diventare una lista di numeri.

#raw(block: true, lang: "txt", "frase → [0, 1, 0, 3, 0, 1, 0]")

A quel punto possiamo usare modelli di Machine Learning classico:

- regressione logistica;
- SVM;
- alberi decisionali;
- random forest;
- naive bayes.

---

== Perché si chiama “bag”?

Perché è come mettere le parole in un sacchetto.

Dentro il sacchetto sappiamo quali parole ci sono.

Ma perdiamo l'ordine.

#raw(block: true, lang: "txt", "Il cane morde l'uomo\nL'uomo morde il cane")

Per Bag of Words sono quasi uguali.

---

== Limite 1: perde l'ordine

Con Bag of Words queste frasi sono molto simili:

#raw(block: true, lang: "txt", "Il cliente ha pagato la fattura\nLa fattura ha pagato il cliente")

Ma il significato è completamente diverso.

---

== Limite 2: perde il contesto

La parola “banca” può indicare:

- istituto finanziario;
- banco di sabbia in altri contesti.

Un sistema semplice vede solo la parola, non il significato nel contesto.

---

== Limite 3: sinonimi

Queste frasi significano cose simili:

#raw(block: true, lang: "txt", "Il pacco è in ritardo\nLa spedizione non è arrivata")

Ma hanno parole diverse.

Bag of Words può non capire che sono vicine.

---

== Limite 4: parole rare

In azienda possono esserci parole specialistiche:

- codici prodotto;
- nomi macchine;
- sigle interne;
- termini tecnici;
- abbreviazioni.

Se appaiono raramente, il modello può gestirle male.

---

== Conteggio semplice

Nel Bag of Words possiamo contare quante volte compare una parola.

Esempio:

#raw(block: true, lang: "txt", "ritardo ritardo ritardo consegna")

Rappresentazione:

#raw(block: true, lang: "txt", "ritardo: 3\nconsegna: 1")

---

== Frequenza non significa importanza

Se una parola appare spesso, non sempre è importante.

Esempio:

#raw(block: true, lang: "txt", "il il il il il cliente ritardo")

“il” è frequente, ma poco informativo.

“ritardo” è meno frequente, ma più utile.

---

== TF-IDF

TF-IDF è un modo per dare più peso alle parole importanti.

Idea intuitiva:

- una parola è importante se appare spesso in un documento;
- ma è meno importante se appare in tutti i documenti.

#alert[Premia le parole caratteristiche di un testo.]

---

== TF-IDF: analogia

Se in tutte le email appare “buongiorno”, non aiuta a distinguere.

Se solo nelle email problematiche appare “rimborso”, allora è più interessante.

TF-IDF cerca di dare più peso a parole come “rimborso” e meno a parole generiche.

---

== N-grammi

Un n-gramma è una sequenza di n parole consecutive.

Esempi:

- unigramma: “ritardo”;
- bigramma: “ritardo consegna”;
- trigramma: “ritardo nella consegna”.

Gli n-grammi recuperano un po' di contesto locale.

---

== Perché gli n-grammi aiutano?

La parola “carta” da sola è ambigua.

Ma:

- carta di credito;
- carta intestata;
- carta geografica;
- carta d'identità.

Il significato emerge dalla combinazione.

---

== N-grammi in ufficio

Frasi utili da riconoscere:

- mancato pagamento;
- ritardo consegna;
- richiesta rimborso;
- prodotto danneggiato;
- sollecito urgente;
- errore fattura;
- assistenza tecnica.

---

== Esempio completo: ticket assistenza

Testo:

#raw(block: true, lang: "txt", "Il prodotto è arrivato danneggiato e chiedo una sostituzione urgente.")

Feature possibili:

- prodotto;
- danneggiato;
- sostituzione;
- urgente;
- prodotto danneggiato;
- sostituzione urgente.

---

== Dal testo alla classificazione

Una volta trasformato il testo in numeri, possiamo classificare.

Esempio:

#raw(block: true, lang: "txt", "testo email → vettore numerico → modello → categoria")

Output:

- reclamo;
- richiesta informazioni;
- problema tecnico;
- amministrazione;
- spam.

---

== Modello classico: Naive Bayes

Naive Bayes è un classificatore storico molto usato nel testo.

Idea intuitiva:

- guarda quali parole appaiono;
- stima quanto quelle parole sono tipiche di una classe;
- sceglie la classe più probabile.

Esempio classico: spam filtering.

---

== Naive Bayes: esempio spam

Parole come:

- gratis;
- premio;
- clicca;
- vincita;
- urgente;
- offerta;

possono aumentare la probabilità che una email sia spam.

#alert[Ma da sole non bastano: il contesto conta.]

---

== Sentiment analysis

La sentiment analysis prova a capire il tono di un testo.

Esempi di classi:

- positivo;
- neutro;
- negativo.

Oppure:

- soddisfatto;
- insoddisfatto;
- arrabbiato;
- urgente.

---

== Sentiment: esempio

Testo:

#raw(block: true, lang: "txt", "Il servizio è stato veloce e il personale molto gentile.")

Output:

#raw(block: true, lang: "txt", "Sentiment: positivo")

---

== Sentiment: problema sarcasmo

Testo:

#raw(block: true, lang: "txt", "Ottimo, il pacco è arrivato rotto anche questa volta.")

Un modello semplice può confondersi per la parola “ottimo”.

#alert[Il sarcasmo richiede contesto e buon senso.]

---

== Topic classification

La topic classification assegna un argomento.

Esempi:

- fatturazione;
- spedizione;
- assistenza tecnica;
- commerciale;
- reclami;
- risorse umane.

È utile per smistare documenti e ticket.

---

== Named Entity Recognition

NER significa riconoscere entità nominate.

Esempi di entità:

- persone;
- aziende;
- luoghi;
- date;
- importi;
- codici prodotto;
- numeri di fattura.

---

== NER in ufficio

Da questa frase:

#raw(block: true, lang: "txt", "Mario Rossi ha inviato la fattura 1024 il 26 marzo per 1.250 euro.")

Un sistema può estrarre:

- persona: Mario Rossi;
- documento: fattura 1024;
- data: 26 marzo;
- importo: 1.250 euro.

---


== Search classica

Prima degli embeddings moderni, la ricerca spesso funzionava per parole chiave.

Esempio:

#raw(block: true, lang: "txt", "cerco: rimborso fattura")

Il sistema cerca documenti che contengono quelle parole.

Funziona bene quando sappiamo esattamente quali parole cercare.

---

== Problema della ricerca per parole chiave

Cerco:

#raw(block: true, lang: "txt", "rimborso")

Ma il documento dice:

#raw(block: true, lang: "txt", "restituzione dell'importo")

La ricerca classica può non trovare il documento.

#alert[Parole diverse possono esprimere lo stesso concetto.]

---

== Traduzione automatica classica

Prima dei modelli moderni, la traduzione automatica usava spesso:

- dizionari;
- regole grammaticali;
- modelli statistici;
- frasi parallele;
- probabilità di traduzione.

Ha funzionato per anni, ma con limiti evidenti.

---

== Esempio: ordine delle parole

Italiano:

#raw(block: true, lang: "txt", "Il cliente ha pagato la fattura.")

In altre lingue l'ordine può cambiare.

La traduzione parola-per-parola non basta.

Serve capire struttura e contesto.

---

== Word sense disambiguation

La stessa parola può avere significati diversi.

Esempio:

#raw(block: true, lang: "txt", "Ho aperto un conto in banca.\nLa barca si è fermata sulla banca di sabbia.")

Il modello deve capire quale significato è corretto.

---

== Coreference resolution

Capire a cosa si riferiscono pronomi e richiami.

Esempio:

#raw(block: true, lang: "txt", "Mario ha chiamato Luca perché lui aveva dimenticato il documento.")

Chi ha dimenticato il documento?

Mario o Luca?

---

== Ambiguità in azienda

Esempio:

#raw(block: true, lang: "txt", "Il cliente ha parlato con il tecnico e gli ha chiesto di richiamare domani.")

Chi deve richiamare?

Il tecnico?

Il cliente?

Serve contesto.

---

== Il problema del contesto lungo

Una frase può dipendere da informazioni dette molte righe prima.

Esempio:

#raw(block: true, lang: "txt", "Il cliente aveva già segnalato il problema la settimana scorsa.\nOggi scrive di nuovo.\nLa richiesta va trattata come urgente.")

La terza frase dipende dalle prime due.

---

== RNN e testo

Le RNN sono state usate molto per il testo perché leggono una sequenza un pezzo alla volta.

#raw(block: true, lang: "txt", "parola 1 → parola 2 → parola 3 → parola 4")

Mantengono una specie di memoria interna.

---

== Perché le RNN sembravano adatte?

Il testo è una sequenza.

Le parole hanno ordine.

Quindi sembrava naturale usare modelli sequenziali:

- RNN;
- LSTM;
- GRU.

#alert[Per anni sono state molto importanti nel NLP.]

---

== Limite delle RNN nel testo lungo

Le RNN leggono una parola alla volta.

Questo crea problemi quando:

- il testo è lungo;
- una parola dipende da una frase lontana;
- servono collegamenti tra parti distanti;
- l'addestramento diventa lento.

---

== Esempio di dipendenza lunga

#raw(block: true, lang: "txt", "Il contratto firmato dal cliente dopo settimane di trattativa, nonostante le modifiche richieste dal legale, è stato approvato.")

Per capire “è stato approvato”, bisogna ricordare “il contratto”.

---

== Feature engineering nel NLP classico

Prima degli LLM, spesso bisognava progettare manualmente le feature.

Esempi:

- conteggio parole;
- lunghezza frase;
- presenza di parole chiave;
- n-grammi;
- punteggiatura;
- dizionari di sentiment;
- regole linguistiche.

---

== Feature engineering: esempio pratico

Per riconoscere email urgenti potremmo usare feature come:

- contiene “urgente”;
- contiene “entro oggi”;
- contiene molti punti esclamativi;
- arriva da cliente premium;
- riguarda ordine già in ritardo;
- ha tono negativo.

---

== Limite del feature engineering

Le feature manuali funzionano, ma:

- richiedono tempo;
- sono fragili;
- dipendono dal dominio;
- vanno aggiornate;
- non catturano tutto;
- non scalano bene a molti problemi diversi.

---

== Perché il NLP classico era comunque utile

Nonostante i limiti, il NLP classico è ancora utile quando:

- il problema è semplice;
- i dati sono pochi;
- serve interpretabilità;
- servono costi bassi;
- bisogna lavorare offline;
- basta una buona approssimazione.

---

== Esempio: filtro semplice per ticket

Se un'azienda riceve pochi ticket, un sistema basato su parole chiave e regole può bastare.

Esempio:

- “fattura” → amministrazione;
- “password” → IT;
- “ritardo” → logistica;
- “danneggiato” → assistenza.

---

== Quando serve qualcosa di più potente

Il NLP classico fatica quando servono:

- contesto;
- ragionamento;
- parafrasi;
- sinonimi;
- testi lunghi;
- domande aperte;
- generazione;
- comprensione del tono.

Qui entrano rappresentazioni più moderne.

---

== Verso le rappresentazioni dense

Bag of Words crea vettori enormi e pieni di zeri.

Esempio:

#raw(block: true, lang: "txt", "[0, 0, 0, 1, 0, 0, 0, 0, 1, ...]")

L'idea successiva è creare rappresentazioni più compatte e significative.

#alert[Questo ci porta agli embeddings.]

---

== Sparse vs dense

Rappresentazione sparsa:

- tanti numeri;
- quasi tutti zero;
- ogni posizione rappresenta una parola.

Rappresentazione densa:

- meno numeri;
- quasi tutti utili;
- cattura somiglianze.

---

== Intuizione degli embeddings

Un embedding rappresenta parole o frasi come punti in uno spazio.

Parole simili finiscono vicine.

Esempi:

- fattura vicino a pagamento;
- reclamo vicino a lamentela;
- spedizione vicino a consegna.

---

== Ma gli embeddings li vediamo meglio dopo

Per ora ci basta sapere che il NLP moderno nasce da un'esigenza:

#raw(block: true, lang: "txt", "non contare solo parole, ma rappresentare significati")

Questa è la transizione dal NLP classico agli LLM.

---

== Confronto veloce

NLP classico:

- parole chiave;
- Bag of Words;
- TF-IDF;
- n-grammi;
- feature manuali;
- modelli relativamente semplici.

NLP moderno:

- embeddings;
- reti profonde;
- attention;
- transformer;
- LLM.
