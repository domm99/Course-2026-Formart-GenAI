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
    title: [03 - Come imparano le macchine],
    subtitle: [Machine Learning dai dati, spiegato semplice],
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

== Obiettivi della lezione

Alla fine della lezione dovreste saper spiegare, a parole semplici:

- cos'è il Machine Learning;
- cos'è un modello;
- cosa significa addestrare un modello;
- qual è il flusso tipico di lavoro;
- quali problemi possiamo risolvere con classificazione, regressione, clustering e reinforcement learning;
- perché servono dati buoni;
- perché i modelli sbagliano;
- perché dal Machine Learning classico si arriva al Deep Learning.

#alert[Obiettivo: capire l'idea, non fare matematica avanzata.]

---

== Roadmap

1. Perché il codice tradizionale non basta sempre
2. Cos'è il Machine Learning
3. Dati, esempi, etichette e feature
4. Cos'è un modello
5. Workflow di addestramento
6. Modelli semplici
7. Valutazione degli errori
8. Tipi di task
9. Dal Machine Learning al Deep Learning
10. Casi pratici ed esercizi

---

== La domanda di oggi

=== Come può una macchina imparare dai dati?

Non nel senso umano di “capire il mondo”.

Ma nel senso pratico di:

- osservare esempi;
- trovare regolarità;
- usarle su casi nuovi;
- migliorare un risultato utile.

#alert[Il Machine Learning è apprendimento da esempi.]

---

== Esempio di partenza

Immaginiamo di voler riconoscere email di reclamo.

Email A:

#raw(block: true, lang: "txt", "Sono molto deluso dal servizio. La consegna è in ritardo di 10 giorni.")

Email B:

#raw(block: true, lang: "txt", "Vorrei informazioni sui tempi di consegna del prodotto.")

Domanda:

- quale delle due è un reclamo?
- come lo spiegheremmo a un computer?

---

== Regole scritte a mano

Potremmo scrivere regole come:

#raw(block: true, lang: "txt", "SE il testo contiene \"deluso\" ALLORA reclamo\nSE il testo contiene \"ritardo\" ALLORA reclamo\nSE il testo contiene \"pessimo\" ALLORA reclamo")

Questo approccio può funzionare per casi semplici.

Ma il linguaggio umano è molto più vario.

---

== Il problema delle regole

Questa email è un reclamo?

#raw(block: true, lang: "txt", "Sono tre settimane che attendo una risposta.\nMi sembra un comportamento poco professionale.")

Non contiene necessariamente parole come:

- reclamo;
- pessimo;
- arrabbiato;
- deluso.

Eppure un umano capisce che c'è un problema.

---

== Il linguaggio è pieno di sfumature

Quando le persone scrivono, possono essere:

- dirette;
- indirette;
- sarcastiche;
- educate ma irritate;
- confuse;
- sintetiche;
- prolisse;
- tecniche;
- emotive.

#alert[Scrivere tutte le regole possibili diventa impossibile.]

---

== Quando il codice tradizionale va benissimo

Il codice classico è perfetto quando le regole sono chiare.

Esempi:

- calcolare l'IVA;
- ordinare una tabella;
- verificare se un campo è vuoto;
- calcolare uno sconto;
- generare un numero di protocollo;
- controllare una scadenza.

#alert[Non tutto deve essere AI.]

---

== Quando il Machine Learning diventa utile

Il Machine Learning è utile quando:

- le regole sono troppe;
- ci sono molti casi particolari;
- abbiamo esempi del passato;
- il problema riguarda testo, immagini, audio o comportamento;
- il risultato può essere probabilistico;
- vogliamo adattarci a nuovi dati.

---

== Idea centrale

Programmazione tradizionale:

#raw(block: true, lang: "txt", "Regole + Dati → Risultato")

Machine Learning:

#raw(block: true, lang: "txt", "Dati + Risultati attesi → Modello\nModello + Nuovi dati → Nuova previsione")

#alert[Non scriviamo tutte le regole: facciamo imparare uno schema dai dati.]

---

== Un'analogia semplice

=== Insegnare a riconoscere frutta

A un bambino non spieghiamo la formula matematica della mela.

Gli mostriamo tanti esempi:

- questa è una mela;
- questa è una pera;
- questa è una banana;
- questa mela è verde;
- questa mela è rossa;
- questa mela è tagliata.

Piano piano impara a riconoscere nuovi esempi.

---

== Il Machine Learning fa qualcosa di simile

Un modello vede molti esempi.

Da questi esempi prova a imparare:

- quali caratteristiche sono importanti;
- quali combinazioni ricorrono;
- quali segnali distinguono una categoria da un'altra;
- quali pattern aiutano a prevedere un risultato.

#alert[Non capisce come un umano, ma può riconoscere pattern utili.]

---

== Parte 1 — Cos'è il Machine Learning?

=== Definizione semplice

Il Machine Learning è un insieme di tecniche che permettono a un sistema di migliorare su un compito usando dati ed esempi.

Invece di programmare manualmente ogni regola, addestriamo un modello.

#alert[Machine Learning = imparare regolarità dai dati.]

---

== Tre parole fondamentali

Per capire il Machine Learning servono tre parole:

- dati;
- modello;
- addestramento.

Tutto il resto viene dopo.

---

== Dati

I dati sono gli esempi da cui il sistema impara.

Possono essere:

- righe di una tabella;
- email;
- immagini;
- registrazioni audio;
- log di macchine;
- transazioni;
- recensioni;
- comportamenti degli utenti.

---

== Modello

Un modello è una rappresentazione semplificata della realtà.

Serve a rispondere a una domanda.

Esempi:

- questa email è spam?
- questo cliente comprerà ancora?
- quale prezzo è ragionevole?
- questa immagine contiene un cane?
- questa macchina sta per guastarsi?

#alert[Un modello non è la realtà: è uno strumento per fare previsioni.]

---

== Addestramento

L'addestramento è la fase in cui il modello osserva esempi e aggiusta il proprio comportamento.

Idea intuitiva:

- prova una previsione;
- confronta con la risposta corretta;
- misura l'errore;
- corregge un po' il modello;
- ripete molte volte.

---

== Esempio: email spam

Dataset:

#raw(block: true, lang: "txt", "Email 1 → spam\nEmail 2 → non spam\nEmail 3 → spam\nEmail 4 → non spam\n...")

Il modello impara quali segnali sono spesso associati allo spam.

Poi riceve una nuova email e prova a classificarla.

---

== Esempio: prezzo di una casa

Dati storici:

#raw(block: true, lang: "txt", "mq, zona, piano, stato, prezzo finale")

Il modello prova a imparare una relazione tra caratteristiche della casa e prezzo.

Poi riceve una nuova casa:

#raw(block: true, lang: "txt", "80 mq, zona centrale, secondo piano, ristrutturata")

e stima un prezzo.

---

== Esempio: manutenzione predittiva

Una macchina industriale produce dati:

- temperatura;
- vibrazioni;
- pressione;
- errori;
- ore di lavoro;
- consumi;
- storico guasti.

Il modello può imparare a riconoscere segnali che precedono un guasto.

#alert[Obiettivo: intervenire prima che il problema blocchi la produzione.]

---

== Parte 2 — Esempi, feature ed etichette

Per addestrare un modello dobbiamo trasformare la realtà in esempi utilizzabili.

Parole chiave:

- esempio;
- feature;
- etichetta;
- dataset.

---

== Cos'è un esempio?

Un esempio è un caso osservato.

Esempi:

- una email;
- una vendita;
- un cliente;
- una foto;
- una richiesta di assistenza;
- una misurazione di sensore;
- una transazione bancaria.

Ogni esempio contiene informazioni utili per imparare.

---

== Cos'è una feature?

Una feature è una caratteristica dell'esempio.

Esempio cliente:

- età;
- città;
- numero acquisti;
- spesa media;
- ultimo acquisto;
- numero reclami;
- canale preferito.

#alert[Le feature sono gli indizi che il modello usa.]

---

== Feature in una email

Per una email, possibili feature sono:

- parole presenti;
- lunghezza del testo;
- presenza di allegati;
- mittente;
- orario di invio;
- tono del messaggio;
- presenza di parole urgenti;
- argomento principale.

---

== Feature in un'immagine

Per un'immagine, le feature possono essere:

- colori;
- bordi;
- forme;
- texture;
- parti dell'oggetto;
- posizione degli elementi;
- combinazioni di pixel.

Nel Deep Learning molte feature vengono imparate automaticamente.

---

== Cos'è un'etichetta?

L'etichetta è la risposta corretta che vogliamo insegnare al modello.

Esempi:

- spam / non spam;
- reclamo / non reclamo;
- prezzo finale;
- guasto / non guasto;
- cane / gatto;
- cliente perso / cliente mantenuto.

---

== Dataset etichettato

Un dataset etichettato contiene esempi + risposta corretta.

#raw(block: true, lang: "txt", "Email: \"Hai vinto un premio\" → spam\nEmail: \"Riunione alle 15\" → non spam\nEmail: \"Il prodotto è arrivato rotto\" → reclamo")

Questo permette l'apprendimento supervisionato.

---

== Dataset non etichettato

A volte abbiamo solo esempi, senza risposta corretta.

#raw(block: true, lang: "txt", "Cliente 1: acquisti, spesa, visite\nCliente 2: acquisti, spesa, visite\nCliente 3: acquisti, spesa, visite")

In questo caso possiamo cercare gruppi, somiglianze o pattern.

Questo è apprendimento non supervisionato.

---

== Dati buoni vs dati cattivi

Il modello impara dai dati che gli diamo.

Se i dati sono:

- sbagliati;
- incompleti;
- duplicati;
- vecchi;
- distorti;
- non rappresentativi;

anche il modello sarà problematico.

#alert[Garbage in, garbage out.]

---

== Esempio: dati sbilanciati

Immaginiamo un dataset di email:

#raw(block: true, lang: "txt", "990 email normali\n10 email spam")

Il modello potrebbe imparare a dire sempre “non spam”.

Risultato:

- accuratezza apparentemente alta;
- ma non riconosce lo spam.

#alert[Bisogna guardare bene cosa c'è nei dati.]

---

== Esempio: dati non rappresentativi

Vogliamo creare un modello per riconoscere scarpe.

Ma nel dataset ci sono quasi solo scarpe da ginnastica.

Quando arriva una scarpa elegante, il modello può sbagliare.

#alert[Il modello conosce bene solo il mondo che ha visto nei dati.]

---

== Parte 3 — Cos'è davvero un modello?

=== Idea fondamentale

Un modello è una macchina per trasformare input in output.

Input:

- dati del caso nuovo.

Output:

- previsione;
- classificazione;
- stima;
- gruppo;
- decisione suggerita.

---

== Modello come ricetta

Analogia:

Un modello è come una ricetta imparata da tanti esempi.

Ha capito che certi ingredienti portano spesso a un certo risultato.

Esempio:

- molte parole sospette + mittente sconosciuto + link strani → forse spam.

#alert[La ricetta è semplificata e può sbagliare.]

---

== Modello come lente

Un modello è anche una lente.

Ti fa vedere alcuni aspetti della realtà, ma ne nasconde altri.

Esempio:

- un modello di vendita guarda prezzo, stagione e prodotto;
- ma magari ignora una crisi economica improvvisa;
- oppure ignora un evento locale importante.

#alert[Ogni modello è una semplificazione.]

---

== Modello come studente

Un modello assomiglia a uno studente che fa esercizi.

- vede esempi;
- prova risposte;
- riceve correzioni;
- migliora;
- poi fa un test su esercizi nuovi.

Se ha solo memorizzato, fallisce sui casi nuovi.

---

== Modello semplice: una soglia

Il modello più semplice possibile può essere una soglia.

Esempio:

#raw(block: true, lang: "txt", "SE importo > 1000 euro\nALLORA richiedi approvazione")

Questo non è ancora “intelligente”, ma ci aiuta a capire l'idea:

input → regola/modello → output.

---

== Modello semplice: punteggio

Un modello può assegnare un punteggio.

Esempio email urgente:

#raw(block: true, lang: "txt", "+2 se contiene \"urgente\"\n+2 se contiene \"bloccato\"\n+1 se arriva da cliente importante\n+1 se ha molti punti esclamativi")

Se il punteggio supera una soglia, segnaliamo alta priorità.

---

== Modello semplice: linea

Per stimare un numero, un modello può usare una relazione semplice.

Esempio intuitivo:

- più metri quadrati ha una casa, più il prezzo tende a salire;
- più chilometri ha un'auto, più il prezzo tende a scendere;
- più reclami ha un cliente, più aumenta il rischio di abbandono.

#alert[Non serve la formula: conta capire la relazione.]

---

== Modello semplice: albero decisionale

Un albero decisionale fa domande in sequenza.

#raw(block: true, lang: "txt", "Il cliente ha scritto \"urgente\"?\n├─ sì → ha già aperto altri ticket?\n│  ├─ sì → priorità alta\n│  └─ no → priorità media\n└─ no → priorità bassa")

È intuitivo perché assomiglia a un diagramma di decisione.

---

== Albero decisionale: perché piace

Vantaggi:

- facile da spiegare;
- simile a domande umane;
- utile per esempi didattici;
- può gestire diverse condizioni.

Svantaggi:

- può diventare molto grande;
- può imparare troppo a memoria;
- può essere fragile se i dati cambiano.

---

== Modello semplice: vicini più simili

Un altro approccio è guardare i casi più simili già visti.

Domanda:

- questo nuovo cliente assomiglia a quali clienti del passato?
- questa email assomiglia a quali email già classificate?
- questa casa assomiglia a quali case già vendute?

#alert[Idea: casi simili spesso hanno risposte simili.]

---

== Analogia: chiedere ai vicini

Devo stimare il prezzo di una casa.

Guardo case simili:

- stessa zona;
- metri quadrati simili;
- stato simile;
- piano simile.

Poi faccio una stima basata sui prezzi delle case più simili.

---

== Modello semplice: gruppi

A volte non voglio prevedere una risposta.

Voglio solo capire se ci sono gruppi naturali.

Esempio clienti:

- clienti occasionali;
- clienti fedeli;
- clienti ad alto valore;
- clienti a rischio;
- clienti interessati solo a promozioni.

Questo è clustering.

---

== Parte 4 — Workflow di addestramento

Ora vediamo il flusso tipico.

Non è solo “butto dati dentro e ottengo AI”.

Serve un processo.

#alert[Il Machine Learning è anche organizzazione, pulizia e controllo.]

---

== Workflow completo

Flusso tipico:

#raw(block: true, lang: "txt", "1. Definire il problema\n2. Raccogliere dati\n3. Pulire e preparare dati\n4. Dividere train/validation/test\n5. Scegliere un modello\n6. Addestrare\n7. Valutare\n8. Migliorare\n9. Mettere in uso\n10. Monitorare nel tempo")

---

== Step 1 — Definire il problema

Prima domanda:

Che cosa vogliamo ottenere?

Esempi:

- prevedere vendite;
- classificare reclami;
- stimare tempi di consegna;
- raggruppare clienti;
- individuare anomalie;
- suggerire prodotti.

#alert[Un problema vago produce un modello inutile.]

---

== Domanda corretta vs domanda vaga

Domanda vaga:

#raw(block: true, lang: "txt", "Vogliamo usare l’AI per migliorare il servizio clienti.")

Domanda migliore:

#raw(block: true, lang: "txt", "Vogliamo classificare automaticamente i ticket in 5 categorie\ne stimare quali hanno priorità alta entro 2 ore dalla ricezione.")

#alert[Il problema deve essere misurabile.]

---

== Step 2 — Raccogliere i dati

Dobbiamo capire:

- quali dati servono;
- dove sono salvati;
- chi può usarli;
- se sono completi;
- se sono aggiornati;
- se possiamo usarli legalmente;
- se contengono dati personali o sensibili.

---

== Step 3 — Pulire i dati

La pulizia dei dati può includere:

- rimuovere duplicati;
- correggere errori;
- uniformare formati;
- gestire valori mancanti;
- eliminare campi inutili;
- anonimizzare dati personali;
- controllare casi strani.

#alert[Spesso la pulizia richiede più tempo dell'addestramento.]

---

== Esempio di pulizia dati

Prima:

#raw(block: true, lang: "txt", "Mario Rossi\nM. Rossi\nROSSI MARIO\nmario.rossi@email.it\nMario Rossi ")

Potrebbero essere la stessa persona.

Se non sistemiamo il dato, il sistema può contare cinque clienti diversi.

---

== Step 4 — Preparare le feature

Preparare le feature significa trasformare i dati in forma utile.

Esempi:

- da data di nascita a età;
- da testo email a parole importanti;
- da indirizzo a zona geografica;
- da storico acquisti a spesa media;
- da log macchina a temperatura media.

#alert[Questa fase si chiama spesso feature engineering.]

---

== Feature engineering

Il feature engineering è l'arte di scegliere buoni indizi.

Esempio per prevedere ritardi di consegna:

- distanza;
- corriere;
- periodo dell'anno;
- meteo;
- area geografica;
- tipo di prodotto;
- storico ritardi.

#alert[Buoni indizi aiutano molto il modello.]

---

== Step 5 — Dividere i dati

Di solito dividiamo i dati in tre parti:

- training set: per imparare;
- validation set: per scegliere e migliorare il modello;
- test set: per valutare alla fine su dati mai usati.

#alert[Come a scuola: esercizi, simulazioni, esame finale.]

---

== Analogia scolastica

Training set:

- gli esercizi fatti in classe.

Validation set:

- le verifiche di prova.

Test set:

- l'esame finale con esercizi nuovi.

Se lo studente conosce già le domande dell'esame, il risultato non vale.

---

== Step 6 — Scegliere un modello

Non esiste un modello migliore per tutto.

La scelta dipende da:

- tipo di dato;
- quantità di dati;
- obiettivo;
- bisogno di spiegabilità;
- risorse disponibili;
- rischio dell'errore.

---

== Step 7 — Addestrare

Durante l'addestramento il modello:

- guarda esempi;
- produce risposte;
- confronta con le risposte corrette;
- misura quanto sbaglia;
- modifica i propri parametri;
- ripete il processo.

#alert[Imparare = ridurre l'errore sui dati di training.]

---

== Cosa sono i parametri?

I parametri sono le “manopole interne” del modello.

Analogia:

- una radio ha manopole per volume e frequenza;
- un modello ha numeri interni che regolano le sue decisioni;
- durante l'addestramento queste manopole vengono aggiustate.

#alert[Non dobbiamo conoscere ogni manopola, ma sapere che esistono.]

---

== Step 8 — Valutare

Dopo l'addestramento chiediamo:

- quanto sbaglia?
- su quali casi sbaglia?
- sbaglia in modo accettabile?
- funziona anche su dati nuovi?
- è abbastanza spiegabile?
- è giusto usarlo in quel contesto?

---

== Step 9 — Migliorare

Se il modello non va bene, possiamo:

- raccogliere più dati;
- pulire meglio i dati;
- aggiungere feature;
- cambiare modello;
- modificare impostazioni;
- bilanciare il dataset;
- semplificare il problema.

---

== Step 10 — Mettere in uso

Mettere un modello in produzione significa usarlo nel mondo reale.

Qui servono:

- integrazione con software aziendali;
- controlli;
- responsabilità;
- monitoraggio;
- aggiornamenti;
- gestione degli errori.

#alert[Il lavoro non finisce quando il modello funziona in laboratorio.]

---

== Monitoraggio nel tempo

Un modello può peggiorare nel tempo.

Perché?

- cambiano i clienti;
- cambiano i prodotti;
- cambiano le abitudini;
- cambiano i dati;
- cambia il mercato;
- cambiano le parole usate dalle persone.

#alert[Un modello va controllato e aggiornato.]

---

== Esempio: spam nel tempo

I filtri antispam devono aggiornarsi continuamente.

Gli spammer cambiano:

- parole;
- link;
- mittenti;
- immagini;
- tecniche di inganno.

Un modello addestrato anni fa potrebbe non bastare più.

---

== Parte 5 — Come si impara riducendo l'errore

Ora introduciamo l'idea di errore.

Non faremo matematica.

Ci basta capire questo:

- il modello prova;
- sbaglia;
- misura quanto sbaglia;
- cambia un po';
- riprova.

---

== Errore

L'errore misura la distanza tra:

- risposta del modello;
- risposta corretta.

Esempio prezzo casa:

- prezzo reale: 200.000 euro;
- prezzo stimato: 180.000 euro;
- errore: 20.000 euro.

#alert[Addestrare significa cercare di ridurre gli errori.]

---

== Funzione di perdita, detta semplice

La funzione di perdita è un modo per dare un punteggio all'errore.

Più il modello sbaglia, più la perdita è alta.

Analogia:

- è come il voto negativo di un esercizio;
- il modello cerca di migliorare il voto;
- l'obiettivo è ridurre la perdita.

---

== Discesa del gradiente: analogia della collina

Immaginate di essere su una collina nella nebbia.

Volete arrivare nel punto più basso.

Non vedete tutta la mappa.

Potete solo sentire in che direzione il terreno scende.

Fate piccoli passi verso il basso.

#alert[Questa è l'idea intuitiva della discesa del gradiente.]

---

== Piccoli passi

Se il passo è troppo grande:

- rischio di saltare il punto giusto;
- posso andare avanti e indietro.

Se il passo è troppo piccolo:

- arrivo lentamente;
- ci metto troppo tempo.

Nel Machine Learning questo è collegato al learning rate.

---

== Learning rate

Il learning rate è la dimensione del passo durante l'apprendimento.

- troppo alto: il modello è instabile;
- troppo basso: il modello impara lentamente;
- giusto: il modello migliora in modo regolare.

#alert[Non serve la formula: pensate alla dimensione del passo in discesa.]

---

== Addestramento come regolazione

Un altro modo per vederlo:

Il modello ha tante manopole.

Dopo ogni errore, gira leggermente alcune manopole.

Dopo moltissimi esempi, le manopole sono regolate meglio.

#alert[Questo è particolarmente importante nel Deep Learning.]

---

== Parte 6 — Overfitting e underfitting

Due errori molto importanti:

- underfitting: il modello è troppo semplice;
- overfitting: il modello ha imparato troppo a memoria.

Sono concetti fondamentali, ma si capiscono bene con esempi.

---

== Underfitting

Underfitting significa che il modello è troppo semplice per il problema.

Esempio:

- voglio prevedere prezzi delle case;
- uso solo i metri quadrati;
- ignoro zona, stato, piano, servizi, mercato.

Risultato:

- il modello sbaglia spesso;
- non coglie aspetti importanti.

---

== Analogia underfitting

È come spiegare tutto con una sola regola.

Esempio:

“Tutte le case grandi costano tanto.”

Ma:

- una casa grande in cattivo stato può costare meno;
- una casa piccola in centro può costare molto;
- il contesto conta.

---

== Overfitting

Overfitting significa che il modello ha imparato troppo bene i dati di training.

È bravo sugli esempi già visti.

Ma va male su esempi nuovi.

#alert[Ha memorizzato invece di generalizzare.]

---

== Analogia overfitting

Uno studente impara a memoria le risposte di 100 esercizi.

Durante la verifica trova domande leggermente diverse.

Non sa rispondere.

Perché non ha capito il metodo.

Ha solo memorizzato.

---

== Generalizzazione

Generalizzare significa funzionare bene su casi nuovi.

È lo scopo vero del Machine Learning.

Non ci interessa un modello perfetto sui dati già visti.

Ci interessa un modello utile nel mondo reale.

---

== Come ridurre l'overfitting

Possibili strategie:

- usare più dati;
- semplificare il modello;
- usare validation/test set;
- controllare gli errori;
- evitare feature inutili;
- fermare l'addestramento al momento giusto.

#alert[La regola: non fidarsi solo del risultato sul training set.]

---

== Parte 7 — Valutare un modello

Dire “funziona bene” non basta.

Dobbiamo misurare.

Ma dobbiamo anche capire cosa stiamo misurando.

---

== Accuratezza

L'accuratezza dice quante risposte sono corrette sul totale.

Esempio:

- 100 email;
- 90 classificate correttamente;
- accuratezza 90%.

Sembra semplice, ma può ingannare.

---

== Quando l'accuratezza inganna

Dataset:

#raw(block: true, lang: "txt", "990 email normali\n10 email spam")

Un modello che dice sempre “non spam” ha 99% di accuratezza.

Ma non trova nemmeno una email spam.

#alert[Un numero alto non significa sempre buon modello.]

---

== Matrice di confusione

Per la classificazione possiamo guardare:

#raw(block: true, lang: "txt", "               Predetto sì   Predetto no\nReale sì       corretto      errore\nReale no       errore        corretto")

Ci aiuta a capire che tipo di errori fa il modello.

---

== Errore falso positivo

Falso positivo:

Il modello segnala un problema, ma il problema non c'è.

Esempi:

- email normale segnata come spam;
- transazione lecita segnalata come frode;
- cliente normale indicato come a rischio.

#alert[Può creare fastidio o costi inutili.]

---

== Errore falso negativo

Falso negativo:

Il modello non segnala un problema che invece c'è.

Esempi:

- email spam che passa;
- guasto imminente non rilevato;
- reclamo urgente classificato come normale;
- frode non riconosciuta.

#alert[A volte è molto più grave del falso positivo.]

---

== Quale errore è peggiore?

Dipende dal contesto.

Filtro spam:

- falso positivo: perdo una email importante;
- falso negativo: ricevo spam.

Diagnosi medica:

- falso positivo: allarme inutile;
- falso negativo: problema non diagnosticato.

#alert[La valutazione è anche una scelta di rischio.]

---

== Precision e recall, dette semplice

Precision:

- quando il modello segnala qualcosa, quante volte ha ragione?

Recall:

- tra tutti i casi importanti, quanti ne riesce a trovare?

Esempio:

- meglio pochi allarmi ma molto precisi?
- o meglio trovare quasi tutto, anche con qualche falso allarme?

---

== Metriche per regressione

Per stimare numeri, guardiamo quanto siamo lontani dal valore reale.

Esempi:

- errore medio sul prezzo;
- errore medio sui giorni di ritardo;
- differenza media tra vendite previste e reali.

#alert[Anche qui conta il contesto: sbagliare di 1 euro o di 10.000 euro non è uguale.]

---

== Parte 8 — Apprendimento supervisionato

Apprendimento supervisionato:

Abbiamo esempi con risposta corretta.

Il modello impara a collegare input e output.

Esempi:

- email → spam/non spam;
- casa → prezzo;
- cliente → rischio abbandono;
- immagine → categoria.

---

== Classificazione

La classificazione assegna una categoria.

Esempi:

- reclamo / non reclamo;
- urgente / non urgente;
- spam / non spam;
- cane / gatto;
- difettoso / non difettoso;
- rischio basso / medio / alto.

---

== Classificazione: esempio simpatico

Problema:

#raw(block: true, lang: "txt", "Classificare messaggi WhatsApp del gruppo di condominio.")

Categorie possibili:

- informazione utile;
- lamentela;
- polemica inutile;
- richiesta urgente;
- messaggio fuori tema.

#alert[Esempio leggero, ma il task è reale: classificare testi.]

---

== Classificazione: esempio aziendale

Ticket assistenza:

- tecnico;
- amministrativo;
- commerciale;
- logistico;
- reclamo;
- richiesta informazioni.

Il modello può aiutare a inoltrare il ticket al reparto corretto.

---

== Regressione

La regressione stima un numero.

Esempi:

- prezzo;
- quantità venduta;
- giorni di ritardo;
- tempo di lavorazione;
- consumo energetico;
- probabilità di abbandono.

---

== Regressione: esempio simpatico

Prevedere il tempo di consegna della pizza.

Possibili feature:

- distanza;
- giorno della settimana;
- orario;
- pioggia;
- numero ordini;
- traffico;
- tipo di pizza.

Output:

- minuti stimati.

---

== Regressione: esempio aziendale

Prevedere vendite del prossimo mese.

Possibili feature:

- vendite passate;
- stagione;
- promozioni;
- prezzo;
- disponibilità magazzino;
- andamento mercato;
- festività.

---

== Parte 9 — Apprendimento non supervisionato

Apprendimento non supervisionato:

Non abbiamo la risposta corretta.

Il modello cerca strutture nei dati.

Esempi:

- gruppi di clienti;
- argomenti ricorrenti nei reclami;
- comportamenti anomali;
- prodotti simili.

---

== Clustering

Il clustering raggruppa esempi simili.

Non diciamo prima quali gruppi esistono.

Il sistema prova a scoprirli.

#alert[È utile per esplorare dati quando non sappiamo ancora cosa cercare.]

---

== Clustering: esempio supermercato

Clienti raggruppati per comportamento:

- chi compra solo offerte;
- chi compra biologico;
- chi fa spese grandi nel weekend;
- chi compra prodotti per bambini;
- chi compra spesso ma poco.

Questi gruppi possono aiutare marketing e logistica.

---

== Clustering: esempio assistenza

Abbiamo migliaia di ticket.

Il clustering può far emergere gruppi come:

- problemi di login;
- fatture errate;
- ritardi di consegna;
- prodotto danneggiato;
- richieste tecniche ricorrenti.

#alert[A volte scopriamo problemi che non avevamo previsto.]

---

== Anomaly detection

Un task collegato è trovare anomalie.

Esempi:

- transazione bancaria strana;
- consumo energetico anomalo;
- macchina con comportamento insolito;
- login da paese insolito;
- ordine con quantità fuori scala.

#alert[Non sempre sappiamo cosa sia l'anomalia prima di vederla.]

---

== Parte 10 — Reinforcement Learning

Il reinforcement learning è diverso.

Un agente impara interagendo con un ambiente.

Fa azioni.

Riceve premi o penalità.

Impara una strategia.

---

== Analogia: videogame

Un personaggio in un videogioco:

- prova a muoversi;
- perde punti se cade;
- guadagna punti se raggiunge un obiettivo;
- dopo molti tentativi impara una strategia migliore.

#alert[Imparare per prove, errori e ricompense.]

---

== Reinforcement Learning: esempi

Possibili applicazioni:

- giochi;
- robotica;
- controllo di droni;
- ottimizzazione di percorsi;
- gestione di risorse;
- sistemi di raccomandazione avanzati;
- controllo industriale.

Non è il focus principale del corso, ma è utile conoscerne l'idea.

---

== Esempio: robot magazzino

Un robot deve muoversi in magazzino.

Azioni:

- avanti;
- indietro;
- gira;
- raccogli pacco;
- evita ostacolo.

Premi:

- arriva velocemente;
- non urta;
- consegna pacco corretto.

---

== Parte 11 — Altri task utili

Oltre alle categorie base, esistono task pratici molto comuni.

- raccomandazione;
- ranking;
- previsione temporale;
- estrazione di informazioni;
- ricerca semantica;
- riduzione dimensionale.

---

== Sistemi di raccomandazione

Raccomandare significa suggerire qualcosa.

Esempi:

- film;
- prodotti;
- canzoni;
- articoli;
- contatti;
- corsi;
- contenuti social.

#alert[Molte piattaforme digitali vivono di raccomandazioni.]

---

== Come ragiona una raccomandazione?

Idea semplice:

- persone simili hanno gusti simili;
- prodotti comprati insieme possono essere collegati;
- ciò che hai visto influenza ciò che ti verrà mostrato;
- feedback come click, like e acquisti diventano dati.

---

== Ranking

Ranking significa ordinare risultati per importanza.

Esempi:

- risultati di un motore di ricerca;
- candidati più adatti a una posizione;
- ticket più urgenti;
- prodotti più rilevanti;
- documenti più vicini alla richiesta.

#alert[Non basta trovare risultati: bisogna ordinarli bene.]

---

== Previsione temporale

Le serie temporali sono dati ordinati nel tempo.

Esempi:

- vendite giornaliere;
- temperatura macchina;
- accessi a un sito;
- consumi energetici;
- traffico;
- domanda di prodotti.

Obiettivo: capire andamento e prevedere il futuro.

---

== Estrazione di informazioni

Da un testo possiamo estrarre:

- nomi;
- date;
- importi;
- indirizzi;
- codici;
- scadenze;
- responsabilità;
- azioni da fare.

Esempio: estrarre dati da fatture o email.

---

== Parte 12 — Machine Learning classico

Prima del Deep Learning, molti sistemi usavano modelli più semplici.

Esempi:

- regressione lineare;
- alberi decisionali;
- random forest;
- k-nearest neighbors;
- support vector machines;
- naive Bayes.

Non serve ricordare i nomi, ma capire il concetto.

---

== Perché i modelli semplici sono importanti

I modelli semplici spesso sono:

- più veloci;
- più economici;
- più spiegabili;
- più facili da controllare;
- sufficienti per molti problemi aziendali.

#alert[Non sempre serve il modello più grande.]

---

== Esempio: albero vs rete neurale

Per classificare ticket in 5 categorie:

Un albero decisionale può bastare se:

- i dati sono pochi;
- le categorie sono chiare;
- serve spiegabilità;
- il rischio è basso.

Una rete neurale può servire se:

- il linguaggio è molto vario;
- i dati sono tanti;
- servono prestazioni più alte.

---

== Spiegabilità

Spiegabilità significa poter capire perché il modello ha dato una certa risposta.

È importante quando:

- c'è responsabilità legale;
- ci sono decisioni su persone;
- serve fiducia;
- serve correggere errori;
- il dominio è delicato.

#alert[Un modello molto potente ma incomprensibile può essere un problema.]

---

== Modelli interpretabili

Alcuni modelli sono più facili da spiegare.

Esempi:

- regole;
- alberi decisionali;
- modelli lineari semplici.

Esempio:

“Il ticket è urgente perché contiene parole di blocco, arriva da cliente premium e riguarda un servizio critico.”

---

== Black box

Alcuni modelli sono difficili da interpretare.

Vediamo input e output, ma non è semplice capire il processo interno.

Esempi:

- grandi reti neurali;
- modelli molto complessi;
- sistemi con milioni o miliardi di parametri.

#alert[Più potenza può significare meno trasparenza.]

---

== Parte 13 — Perché passiamo al Deep Learning?

Il Machine Learning classico funziona molto bene in tanti casi.

Ma incontra difficoltà con dati molto complessi:

- immagini;
- audio;
- video;
- testo libero;
- linguaggio naturale;
- dati multimodali.

---

== Il problema delle feature manuali

Nel Machine Learning classico spesso dobbiamo scegliere noi le feature.

Esempio immagine:

- quali bordi?
- quali forme?
- quali colori?
- quali parti dell'oggetto?

Per problemi complessi, progettare feature a mano diventa difficile.

---

== Deep Learning: idea semplice

Il Deep Learning usa reti neurali con molti strati.

Gli strati imparano rappresentazioni via via più complesse.

Esempio immagine:

- primi strati: bordi e colori;
- strati intermedi: forme e parti;
- strati finali: oggetti interi.

#alert[Il modello impara molte feature automaticamente.]

---

== Analogia: riconoscere un volto

Quando riconosciamo una persona non guardiamo un solo dettaglio.

Combiniamo:

- occhi;
- naso;
- bocca;
- forma del viso;
- capelli;
- espressione;
- contesto.

Una rete profonda combina molti livelli di segnali.

---

== Rete neurale, spiegata semplice

Una rete neurale è composta da tanti piccoli elementi collegati.

Ogni elemento fa un calcolo semplice.

Mettendone tantissimi insieme, il sistema può imparare funzioni complesse.

#alert[Il singolo neurone è semplice; la rete nel complesso può essere potente.]

---

== Strati

Schema intuitivo:

#raw(block: true, lang: "txt", "Input → Strato 1 → Strato 2 → Strato 3 → Output")

Ogni strato trasforma un po' l'informazione.

Più strati permettono trasformazioni più sofisticate.

---

== Perché “deep”?

“Deep” significa profondo.

Non perché il modello capisca profondamente.

Ma perché ha molti strati di elaborazione.

#alert[Deep Learning = reti neurali con molti livelli.]

---

== Perché è esploso negli ultimi anni?

Il Deep Learning è cresciuto grazie a:

- molti più dati;
- GPU più potenti;
- cloud computing;
- dataset pubblici;
- ricerca scientifica;
- software open source;
- aziende con grandi infrastrutture.

---

== GPU

Le GPU sono processori molto adatti a fare tanti calcoli in parallelo.

Sono nate per la grafica.

Poi si sono rivelate molto utili per addestrare reti neurali.

#alert[Più calcolo disponibile = modelli più grandi e addestramenti più veloci.]

---

== Deep Learning per immagini

Applicazioni:

- riconoscere oggetti;
- diagnosi da immagini mediche;
- controllo qualità in produzione;
- guida assistita;
- sorveglianza;
- riconoscimento documenti.

---

== Deep Learning per audio

Applicazioni:

- riconoscimento vocale;
- trascrizione;
- comandi vocali;
- analisi di suoni industriali;
- rilevamento anomalie acustiche;
- sintesi vocale.

---

== Deep Learning per testo

Applicazioni:

- classificazione testi;
- traduzione;
- riassunto;
- ricerca semantica;
- chatbot;
- estrazione informazioni;
- analisi del sentiment.

#alert[Questa strada porterà poi agli LLM.]

---

== Dal Deep Learning agli LLM

Gli LLM sono modelli di Deep Learning specializzati nel linguaggio.

Ma prima di arrivare lì è importante capire:

- dati;
- esempi;
- modelli;
- addestramento;
- errore;
- generalizzazione;
- valutazione.

#alert[Gli LLM sono una continuazione, non magia separata.]

---

== Parte 14 — Problemi e limiti

Il Machine Learning è potente, ma ha limiti importanti.

Vediamo i principali:

- dati insufficienti;
- bias;
- correlazione non causalità;
- cambiamento nel tempo;
- errori difficili da spiegare;
- uso improprio.

---

== Dati insufficienti

Se abbiamo pochi esempi, il modello può non imparare bene.

Esempio:

- voglio riconoscere difetti rari;
- ho solo 5 esempi di difetto;
- il modello non vede abbastanza variabilità.

#alert[Alcuni problemi richiedono molti dati.]

---

== Bias

Il bias può entrare nei dati e nei modelli.

Esempi:

- dati storici discriminatori;
- gruppi sottorappresentati;
- misurazioni incomplete;
- categorie scelte male;
- obiettivi aziendali distorti.

#alert[Il modello può imparare ingiustizie presenti nel passato.]

---

== Correlazione non significa causa

Il modello può trovare relazioni statistiche.

Ma non sempre sono cause reali.

Esempio scherzoso:

- quando si vendono più gelati, aumentano anche gli incidenti in piscina;
- non significa che i gelati causino incidenti;
- forse entrambi aumentano perché è estate.

---

== Esempio aziendale: correlazione ingannevole

Un modello scopre che clienti che chiamano spesso l'assistenza comprano meno.

Possibili interpretazioni:

- l'assistenza causa insoddisfazione;
- i clienti chiamano perché sono già insoddisfatti;
- il prodotto è difficile da usare;
- i clienti più esigenti chiamano di più.

#alert[Il modello segnala pattern; l'umano deve interpretarli.]

---

== Data drift

Data drift significa che i dati cambiano nel tempo.

Esempi:

- cambiano abitudini dei clienti;
- cambia il mercato;
- cambia il linguaggio;
- cambia la normativa;
- cambia il prodotto.

Un modello addestrato ieri può peggiorare domani.

---

== Concept drift

Concept drift significa che cambia il significato del fenomeno.

Esempio:

Prima della pandemia, certi comportamenti d'acquisto avevano un significato.

Durante la pandemia, gli stessi segnali potevano indicare altro.

#alert[Il mondo cambia, quindi anche i modelli vanno aggiornati.]

---

== Automazione cieca

Un rischio è usare il modello senza controllo.

Problemi:

- fidarsi troppo;
- non verificare;
- delegare decisioni importanti;
- non capire gli errori;
- non sapere chi è responsabile.

#alert[Il modello deve supportare la decisione, non sostituire sempre la persona.]

---

== Human in the loop

Human in the loop significa mantenere una persona nel processo.

Esempi:

- l'AI propone, l'operatore approva;
- l'AI segnala anomalie, il tecnico verifica;
- l'AI prepara una bozza, l'umano corregge;
- l'AI classifica ticket, l'operatore può cambiare categoria.

---

== Parte 15 — Casi pratici completi

Ora mettiamo insieme i concetti con casi concreti.

Vedremo:

- classificare email;
- prevedere ritardi;
- raggruppare clienti;
- manutenzione predittiva;
- raccomandazioni;
- controllo qualità.

---

== Caso 1 — Classificare email

Obiettivo:

- classificare email in categorie.

Categorie:

- reclamo;
- richiesta informazioni;
- amministrazione;
- tecnico;
- commerciale.

Utilità:

- smistamento automatico;
- priorità;
- risparmio di tempo;
- meno errori di inoltro.

---

== Caso 1 — Dati necessari

Servono:

- storico email;
- categoria corretta;
- eventuale priorità;
- reparto che ha risposto;
- tempi di risposta;
- esito finale.

Attenzione:

- privacy;
- dati personali;
- informazioni riservate.

---

== Caso 1 — Possibile workflow

#raw(block: true, lang: "txt", "Email storiche\n→ pulizia e anonimizzazione\n→ etichette corrette\n→ addestramento modello\n→ valutazione errori\n→ uso su nuove email\n→ controllo umano")

---

== Caso 2 — Prevedere ritardi di consegna

Obiettivo:

- stimare se una consegna arriverà in ritardo.

Feature possibili:

- distanza;
- corriere;
- zona;
- giorno della settimana;
- periodo dell'anno;
- tipo prodotto;
- storico ritardi;
- traffico o meteo, se disponibili.

---

== Caso 2 — Valore aziendale

Se prevedo un ritardo, posso:

- avvisare prima il cliente;
- cambiare corriere;
- dare priorità alla spedizione;
- organizzare meglio il magazzino;
- ridurre reclami;
- migliorare la fiducia.

#alert[La previsione diventa utile solo se porta a un'azione.]

---

== Caso 3 — Raggruppare clienti

Obiettivo:

- scoprire gruppi di clienti simili.

Dati:

- frequenza acquisti;
- spesa media;
- categorie acquistate;
- canale preferito;
- reclami;
- risposta alle promozioni.

Task:

- clustering.

---

== Caso 3 — Possibili gruppi

Il sistema potrebbe trovare:

- clienti fedeli ad alto valore;
- clienti occasionali;
- clienti sensibili al prezzo;
- clienti insoddisfatti;
- clienti tecnici;
- clienti che comprano solo certi prodotti.

#alert[Il nome dei gruppi lo dà l'umano interpretando i risultati.]

---

== Caso 4 — Manutenzione predittiva

Obiettivo:

- prevedere guasti prima che accadano.

Dati:

- sensori;
- log macchina;
- temperature;
- vibrazioni;
- consumi;
- storico guasti;
- interventi manutenzione.

---

== Caso 4 — Perché è utile

Benefici:

- meno fermi macchina;
- meno costi imprevisti;
- migliore pianificazione;
- più sicurezza;
- maggiore durata degli impianti.

Rischio:

- falsi allarmi;
- guasti non previsti;
- dati sensore sbagliati.

---

== Caso 5 — Raccomandazioni

Obiettivo:

- suggerire prodotti o contenuti.

Dati:

- acquisti passati;
- prodotti visualizzati;
- carrelli abbandonati;
- recensioni;
- clienti simili;
- prodotti comprati insieme.

---

== Caso 5 — Effetto collaterale

Le raccomandazioni possono essere utili, ma anche creare:

- bolle informative;
- dipendenza da piattaforme;
- promozione di contenuti estremi;
- riduzione della varietà;
- manipolazione dell'attenzione.

#alert[Un algoritmo di ranking influenza ciò che vediamo.]

---

== Caso 6 — Controllo qualità

Obiettivo:

- riconoscere prodotti difettosi da immagini o misurazioni.

Esempi:

- graffi;
- crepe;
- parti mancanti;
- misure fuori tolleranza;
- confezioni danneggiate.

Task:

- classificazione o anomaly detection.

---

== Parte 16 — Attività in aula

Le prossime slide sono esercizi discussi insieme.

Non serve programmare.

Serve ragionare come se dovessimo progettare un sistema ML.

---

== Esercizio 1 — Che tipo di task è?

Classificate questi problemi:

- prevedere il fatturato del mese prossimo;
- riconoscere email spam;
- raggruppare reclami simili;
- suggerire prodotti;
- stimare giorni di ritardo;
- trovare transazioni anomale;
- insegnare a un robot a muoversi.

---

== Esercizio 2 — Quali dati servono?

Problema:

Vogliamo prevedere se un cliente abbandonerà il servizio.

Domande:

- quali dati usereste?
- quali potrebbero essere inutili?
- quali potrebbero essere rischiosi per la privacy?
- quale sarebbe l'etichetta corretta?

---

== Esercizio 3 — Feature per ritardi

Problema:

Prevedere se una consegna arriverà in ritardo.

Trovate almeno 10 feature possibili.

Poi discutiamo:

- quali sono facili da ottenere?
- quali sono affidabili?
- quali sono troppo costose?
- quali potrebbero essere fuorvianti?

---

== Esercizio 4 — Errori accettabili

Per ogni caso, quale errore è peggiore?

- spam filter;
- diagnosi medica;
- frode bancaria;
- ticket urgente;
- manutenzione predittiva;
- raccomandazione film.

#alert[Non tutti gli errori hanno lo stesso costo.]

---

== Esercizio 5 — Overfitting

Scenario:

Un modello riconosce perfettamente 100 immagini di addestramento.

Ma sbaglia moltissimo su immagini nuove.

Domande:

- cosa potrebbe essere successo?
- cosa possiamo fare?
- perché il risultato iniziale era ingannevole?

---

== Esercizio 6 — Bias

Scenario:

Un modello di selezione CV è addestrato su assunzioni passate.

In passato l'azienda ha assunto soprattutto uomini in ruoli tecnici.

Domande:

- cosa può imparare il modello?
- perché è un problema?
- come possiamo controllarlo?

---

== Esercizio 7 — Modello utile o no?

Un'azienda vuole usare AI per decidere automaticamente licenziamenti.

Discutiamo:

- è un buon caso d'uso?
- quali rischi ci sono?
- quali dati servirebbero?
- chi sarebbe responsabile?
- è accettabile automatizzare completamente?

---

== Esercizio 8 — Disegnare il workflow

Scegliete un problema:

- classificare ticket;
- prevedere vendite;
- suggerire prodotti;
- trovare guasti;
- raggruppare clienti.

Disegnate:

- dati di input;
- modello;
- output;
- controllo umano;
- azione finale.

---

== Parte 17 — Cosa ricordare

Se dovete ricordare solo una cosa:

#alert[Il Machine Learning impara pattern dai dati per fare previsioni o decisioni su casi nuovi.]

Non è magia.

Non è certezza.

Non è automaticamente corretto.

---

== Messaggio chiave 1

Il codice tradizionale usa regole scritte a mano.

Il Machine Learning usa esempi per imparare regole implicite.

Entrambi sono utili.

La scelta dipende dal problema.

---

== Messaggio chiave 2

Un modello è una semplificazione della realtà.

Serve a fare un compito.

Può essere utile, ma può sbagliare.

#alert[Il modello non è la realtà.]

---

== Messaggio chiave 3

Il workflow conta quanto l'algoritmo.

Dati raccolti male, puliti male o scelti male producono modelli cattivi.

#alert[La qualità dei dati è fondamentale.]

---

== Messaggio chiave 4

Valutare un modello significa capire:

- quanto sbaglia;
- dove sbaglia;
- che tipo di errore fa;
- quanto costa quell'errore;
- se è accettabile nel contesto reale.

---

== Messaggio chiave 5

Il Deep Learning nasce perché alcuni dati sono troppo complessi per feature manuali.

Immagini, audio, testo e video richiedono modelli capaci di imparare rappresentazioni più ricche.

---

== Messaggio chiave 6

Un modello messo in uso va monitorato.

Il mondo cambia.

I dati cambiano.

Gli utenti cambiano.

#alert[Anche i modelli devono essere mantenuti.]

---

== Collegamento alla prossima parte

Dopo aver capito come le macchine imparano dai dati, possiamo capire meglio:

- Natural Language Processing;
- modelli linguistici;
- embeddings;
- attenzione;
- Large Language Models;
- AI generativa.

#alert[Gli LLM sono modelli addestrati su enormi quantità di testo.]

---

== Slide backup — Domande per ripassare

Domande rapide:

- cos'è una feature?
- cos'è un'etichetta?
- cos'è un modello?
- cosa significa addestrare?
- perché dividiamo training e test?
- cos'è overfitting?
- classificazione e regressione sono diverse come?
- perché il Deep Learning è utile?

---

== Slide backup — Mini glossario

- Dataset: raccolta di esempi.
- Feature: caratteristica usata dal modello.
- Label: risposta corretta.
- Training: fase di apprendimento.
- Model: sistema che produce output da input.
- Prediction: risposta del modello.
- Error: differenza tra previsione e realtà.
- Overfitting: memorizzare invece di generalizzare.

---

== Fine

#alert[Fine della lezione 3]

Domande?
