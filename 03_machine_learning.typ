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

---

== Mappa mentale

#raw(block: true, lang: "txt", "Dati → esempi → modello → errore → correzione → modello migliore → uso su casi nuovi")

Questa è l’idea di quasi tutto il Machine Learning.

---


== Workflow di Machine Learning
#align(center)[
#image("assets/image-3.png")]

---

== La domanda chiave

Come può una macchina passare da esempi del passato a decisioni su casi nuovi?

Esempio:

- ho visto tante email già classificate;
- arriva una nuova email;
- voglio capire se è spam, reclamo, urgente, normale.

#alert[Il Machine Learning è il ponte tra esempi passati e casi nuovi.]

---

== Il Machine Learning in una frase

Il Machine Learning fornisce metodi per estrarre modelli di conoscenza da insiemi di dati.

Esempi:

- classificare clienti fedeli o a rischio;
- riconoscere immagini mediche;
- prevedere consumi energetici;
- stimare prezzi;
- suggerire prodotti;
- rilevare frodi.

---

== Quando ha senso usare ML?

- abbiamo dati sufficienti;
- il problema ha pattern ricorrenti;
- non è facile scrivere regole a mano;
- possiamo misurare se il modello sbaglia;
- l’errore è gestibile;
- una persona può supervisionare il risultato.

#alert[Il ML non è sempre la soluzione migliore.]

---

== Quando NON serve ML?

- calcolare l’IVA;
- ordinare una lista alfabetica;
- applicare una regola aziendale chiara;
- inviare una email automatica a una data fissa;
- controllare se un campo obbligatorio è vuoto.

Qui basta software tradizionale.

---

== Un esempio semplice: il meteo in ufficio

Vogliamo prevedere quanta elettricità consumerà un ufficio.

Dati disponibili:

- temperatura esterna;
- giorno della settimana;
- numero di persone presenti;
- consumo elettrico misurato.

Domanda:

#alert[Possiamo imparare una relazione tra questi dati e il consumo?]

---

== Che cos’è un modello?

Un modello è una rappresentazione semplificata della realtà.

Non è la realtà.

È uno strumento che ci permette di fare una previsione, una classificazione o una decisione.

Esempio:

#alert[Temperatura alta → più aria condizionata → più consumo.]

---

== Modello: analogia della mappa

Una mappa non è il territorio.

Però è utile per orientarsi.

Un modello ML è simile:

- semplifica la realtà;
- ignora dettagli inutili;
- conserva ciò che serve al compito;
- può essere sbagliato o incompleto.

---

== Modello: esempio non informatico

Un medico usa modelli mentali.

Sintomi osservati:

- febbre;
- tosse;
- stanchezza.

Ipotesi:

- influenza;
- covid;
- allergia;
- altra infezione.

#alert[Anche gli esseri umani usano modelli semplificati.]

---

== Modello ML: input e output

#raw(block: true, lang: "txt", "Input → modello → output")

Esempi:

- email → modello → spam/non spam;
- temperatura → modello → consumo previsto;
- foto → modello → cane/gatto;
- storico cliente → modello → rischio abbandono.

---

== Feature: cosa guarda il modello?

Le feature sono le caratteristiche usate dal modello.

Esempio email:

- lunghezza del testo;
- parole presenti;
- numero di link;
- mittente sconosciuto;
- presenza di allegati;
- tono del messaggio.

#alert[Il modello non vede “il mondo”: vede le feature che gli diamo.]

---

== Target: cosa vogliamo prevedere?

Il target è la risposta che vogliamo imparare.

Esempi:

- spam / non spam;
- consumo elettrico;
- prezzo di una casa;
- cliente a rischio / non a rischio;
- immagine benigna / maligna;
- ritardo previsto in giorni.

---

== Dataset: tabella degli esempi

Un dataset è una raccolta di esempi.

Ogni riga è un caso.

Ogni colonna è una caratteristica o una risposta.

#alert[Il dataset è il materiale da cui il modello impara.]

---

== Dataset: esempio email

#raw(block: true, lang: "txt", "testo_email | n_link | mittente_noto | categoria\n--------------------------------------------------\n\"Hai vinto un premio\" | 3 | no | spam\n\"Riunione domani\"    | 0 | si | normale\n\"Pagamento urgente\"  | 1 | no | sospetta")

---

== Dataset: esempio consumi

#raw(block: true, lang: "txt", "giorno | temperatura | persone | consumo_kwh\n--------------------------------------------\nlunedi | 24°C | 35 | 180\nmartedi | 29°C | 42 | 230\nmercoledi | 31°C | 40 | 250")

---

== Parametri: le manopole del modello

I parametri sono valori interni che il modello modifica durante l’apprendimento.

Metafora:

- il modello è una radio;
- i parametri sono le manopole;
- l’addestramento cerca la sintonia migliore.

#alert[Imparare = trovare parametri che funzionano bene.]

---

== Iperparametri: scelte prima dell’addestramento

Gli iperparametri sono scelte fatte da chi costruisce il modello.

Esempi:

- quanto deve essere profondo un albero decisionale;
- quanti vicini usare nel KNN;
- quanti cluster cercare in k-means;
- quanto velocemente aggiornare i parametri;
- quante epoche di addestramento fare.

#alert[Parametri: li impara il modello. Iperparametri: li scegliamo noi.]

---

== Parametri vs iperparametri

#raw(block: true, lang: "txt", "Parametri\n- appresi dai dati\n- cambiano durante training\n- esempio: pendenza di una retta\n\nIperparametri\n- scelti prima\n- controllano il processo\n- esempio: numero di cluster K")

---

== Il ciclo base di apprendimento

#raw(block: true, lang: "txt", "1. il modello fa una previsione\n2. confrontiamo la previsione con la risposta corretta\n3. misuriamo l’errore\n4. correggiamo i parametri\n5. ripetiamo tante volte")

---

== Il concetto di errore

Il modello sbaglia quando la sua risposta è diversa dalla risposta attesa.

Esempi:

- consumo reale: 250 kWh, consumo previsto: 230 kWh;
- email reale: spam, modello: non spam;
- cliente reale: abbandona, modello: non abbandona.

#alert[L’errore è il segnale che guida l’apprendimento.]

---

== Loss function, detta semplice

La loss è un numero che misura quanto il modello sta sbagliando.

Loss alta:

- il modello sta sbagliando molto.

Loss bassa:

- il modello sta sbagliando poco.

#alert[L’addestramento prova a ridurre la loss.]

---

== Allenare un modello è come regolare una ricetta

Immaginiamo di voler fare una torta.

Ogni tentativo modifica:

- farina;
- zucchero;
- temperatura;
- tempo di cottura.

Assaggiamo, valutiamo l’errore, correggiamo.

#alert[Il ML fa qualcosa di simile, ma con numeri e dati.]

---

== Workflow completo

#raw(block: true, lang: "txt", "Problema → raccolta dati → analisi dati → feature → split\n→ scelta modello → training → validazione\n→ test finale → rilascio → monitoraggio")

---

== Workflow: 1. definire il problema

Prima domanda:

#alert[Che cosa vogliamo ottenere?]

Esempi:

- ridurre email spam;
- prevedere consumi;
- trovare clienti a rischio;
- raggruppare reclami;
- stimare tempi di consegna.

Senza problema chiaro, il modello non serve.

---

== Workflow: 2. raccogliere i dati

Fonti possibili:

- database aziendali;
- Excel;
- email;
- ticket assistenza;
- sensori;
- log;
- CRM;
- ERP;
- dataset pubblici.

#alert[La raccolta dati è spesso più difficile del modello.]

---

== Workflow: 3. capire la qualità dei dati

Domande utili:

- mancano valori?
- ci sono errori?
- ci sono duplicati?
- i dati sono aggiornati?
- rappresentano davvero il problema?
- ci sono bias?
- abbiamo abbastanza esempi?

---

== Workflow: 4. preparare le feature

Preparare feature significa trasformare i dati in qualcosa che il modello può usare.

Esempi:

- data → giorno della settimana;
- email → numero di link;
- testo → parole importanti;
- immagine → pixel;
- cliente → numero acquisti ultimi 6 mesi.

---

== Workflow: 5. dividere i dati

In genere dividiamo il dataset in tre parti:

- training set;
- validation set;
- test set.

#alert[Serve per capire se il modello funziona davvero su dati nuovi.]

---

== Training set

È la parte usata per addestrare il modello.

Il modello vede questi esempi e modifica i propri parametri.

Metafora:

#alert[È il materiale su cui lo studente studia.]

---

== Validation set

È usato durante lo sviluppo per controllare come sta andando.

Serve a:

- scegliere tra modelli diversi;
- regolare iperparametri;
- accorgersi di overfitting;
- evitare di fidarsi troppo del training set.

Metafora:

#alert[È una simulazione d’esame.]

---

== Test set

È usato solo alla fine.

Serve a valutare il modello su dati che non ha mai usato per imparare.

Metafora:

#alert[È l’esame vero.]

---

== Quanti dati per ogni set?

#align(center)[
#image("assets/image-4.png")]

---

== Perché non testare sugli stessi dati?

Se studente e professore usano sempre le stesse domande, il voto non misura davvero la comprensione.

Il modello potrebbe semplicemente aver imparato a memoria.

#alert[Ci interessa la capacità di generalizzare.]

---

== Generalizzazione

Generalizzare significa funzionare bene su casi nuovi.

Esempio:

- il modello ha visto email vecchie;
- arriva una nuova email mai vista;
- deve classificarla correttamente.

#alert[La generalizzazione è lo scopo vero del ML.]

---

== Underfitting

Underfitting significa che il modello è troppo semplice o ha imparato troppo poco.

Sintomi:

- sbaglia molto sul training;
- sbaglia molto anche su validation/test;
- non coglie la struttura dei dati.

Metafora:

#alert[Studente che non ha studiato abbastanza.]

---

== Overfitting

Overfitting significa che il modello impara troppo bene il training set, compresi rumore ed errori.

Sintomi:

- ottimo sul training;
- scarso su dati nuovi.

Metafora:

#alert[Studente che ha memorizzato le risposte, ma non ha capito.]

---

== Il punto giusto

#raw(block: true, lang: "txt", "Modello troppo semplice → underfitting\nModello troppo complesso → overfitting\nModello giusto → generalizza bene")

#alert[La bravura sta nel trovare il giusto equilibrio.]

---

== Underfitting e overfitting: esempio visivo

#align(center)[
#image("assets/image-5.png")]

- linea troppo rigida: non segue i dati;
- linea ragionevole: segue il trend;
- linea troppo contorta: segue anche il rumore.

---

== Da dove arrivano i dataset?

Fonti comuni:

- dati aziendali interni;
- dataset pubblici;
- università e ricerca;
- Kaggle;
- dati raccolti con sensori;
- annotazioni manuali;
- simulazioni.

#alert[Costruire un buon dataset può costare più del modello.]

---

== Costruire un dataset da zero

È costoso perché bisogna:

- acquisire i dati;
- salvarli correttamente;
- pulirli;
- etichettarli;
- controllare errori;
- gestire privacy;
- aggiornare nel tempo;
- documentare cosa significano.

#alert[Il dataset è un prodotto, non un mucchio di file.]

---

== Esempio: dataset per reclami

Vogliamo riconoscere reclami clienti.

Serve raccogliere email e annotarle:

- reclamo;
- richiesta informativa;
- sollecito;
- problema tecnico;
- richiesta commerciale.

Domanda difficile:

#alert[Chi decide l’etichetta corretta?]

---

== Etichette rumorose

Due persone possono classificare la stessa email in modo diverso.

Esempio:

- una persona vede un reclamo;
- un’altra vede una richiesta urgente;
- una terza vede un problema logistico.

#alert[Se le etichette sono confuse, anche il modello impara confusione.]

---

== Un solo tipo di apprendimento?

#image("assets/image-6.png")

---
== Un solo tipo di apprendimento? Pt.2

#image("assets/image-7.png")

--- 
== Un solo algoritmo per ogni tipo di apprendimento?

#align(center)[
#image("assets/image-8.png")
]

---

== Supervisionato, non supervisionato, rinforzo

Tre grandi famiglie:

- apprendimento supervisionato: esempi con risposta corretta;
- apprendimento non supervisionato: dati senza etichette;
- apprendimento per rinforzo: azioni, ambiente, ricompense.

Aggiungiamo anche:

- self-supervised learning.

---

== Apprendimento supervisionato

Il modello riceve esempi già etichettati.

Formato:

#raw(block: true, lang: "txt", "input + risposta corretta")

Esempi:

- email + spam/non spam;
- foto + cane/gatto;
- casa + prezzo;
- cliente + abbandona/non abbandona.

---

== Supervisionato: perché è comune

È molto usato perché è facile misurare l’errore.

Il modello risponde.

Noi confrontiamo con la risposta corretta.

Poi correggiamo.

#alert[È come avere esercizi con soluzioni.]

---

== Apprendimento non supervisionato

Il modello riceve dati senza etichette.

Obiettivo:

- trovare gruppi;
- trovare somiglianze;
- trovare anomalie;
- scoprire strutture nascoste.

Esempio:

#alert[Clienti che si comportano in modo simile.]

---

== Non supervisionato: esempio negozio

Un negozio online ha clienti molto diversi.

Il clustering può trovare gruppi come:

- clienti occasionali;
- clienti fedeli;
- clienti interessati agli sconti;
- clienti premium;
- clienti che abbandonano il carrello.

Nessuno aveva scritto prima queste etichette.

---

== Apprendimento per rinforzo

Il modello impara agendo in un ambiente.

Riceve:

- ricompense;
- penalità;
- feedback nel tempo.

Esempi:

- robot che cammina;
- gioco;
- gestione traffico;
- agenti in simulazione.

---

== RL: metafora del cane

Addestrare un cane:

- azione corretta → premio;
- azione sbagliata → nessun premio;
- nel tempo impara la strategia.

#alert[Il rinforzo non insegna una risposta singola, ma un comportamento.]

---

== Multi-agent reinforcement learning

A volte non c’è un solo agente.

Ci sono più agenti che interagiscono.

Possibili scenari:

- cooperativi: spegnere un incendio;
- competitivi: nascondino;
- misti: partita di calcio.

#alert[Qui il comportamento degli altri cambia il problema.]

---

== Self-supervised learning

Il modello crea da solo un compito a partire dai dati grezzi.

Esempi:

- maschero una parola e provo a predirla;
- nascondo un pezzo di immagine e provo a ricostruirlo;
- prendo due viste dello stesso oggetto e imparo che sono simili.

#alert[È importantissimo per i modelli moderni.]

---

== Perché il self-supervised è potente?

Perché permette di usare enormi quantità di dati non etichettati.

Etichettare costa.

I dati grezzi invece sono ovunque:

- testi;
- immagini;
- video;
- audio;
- log;
- codice.

#alert[È uno dei motivi per cui il Deep Learning è esploso.]

---

== Tipi di task

Oggi vediamo:

- regressione;
- classificazione;
- clustering;
- anomaly detection;
- recommendation;
- reinforcement learning.

#alert[Non sono algoritmi, sono tipi di problemi.]

---

== Regressione

La regressione serve per prevedere un valore numerico continuo.

Esempi:

- prezzo di una casa;
- consumo energetico;
- ritardo in minuti;
- fatturato previsto;
- temperatura;
- domanda di un prodotto.

---

== Regressione: esempio energia

Immaginiamo un quartiere.

Quando la temperatura aumenta, aumenta anche il consumo elettrico per l’aria condizionata.

Domanda:

#alert[Possiamo stimare il consumo partendo dalla temperatura?]

---

== Regressione: il grafico
#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
#align(center)[
#image("assets/image-9.png")]
][
Ogni punto rappresenta un giorno.

Asse orizzontale: temperatura.

Asse verticale: consumo elettrico.

Cerchiamo una relazione tra i due.
]
---

== Una retta come modello semplice

Possiamo usare un modello molto semplice:

#raw(block: true, lang: "txt", "consumo = α × temperatura + β")

Dove:

- α dice quanto cresce il consumo quando cresce la temperatura;
- β è il consumo base;
- α e β sono parametri del modello.

#align(center)[
#image("assets/image-10.png")]

---

== Che cosa significa α?

α è la pendenza della retta.

Se α è grande:

- il consumo cresce molto quando aumenta la temperatura.

Se α è piccolo:

- il consumo cresce poco.

#alert[È una manopola che controlla l’inclinazione della retta.]

---

== Che cosa significa β?

β è il punto di partenza della retta.

Può rappresentare un consumo base:

- luci;
- computer;
- frigoriferi;
- macchinari sempre accesi.

#alert[È la quota di consumo non spiegata solo dalla temperatura.]

---

== Previsione con la retta

#raw(block: true, lang: "txt", "temperatura = 30°C\nα = 8\nβ = 20\n\nconsumo previsto = 8 × 30 + 20 = 260")

Il modello prende un input e restituisce un valore previsto.

---

== Errore del modello

Se il consumo reale era 250 e il modello prevede 260, l’errore è 10.

#raw(block: true, lang: "txt", "errore = previsione - valore reale")

Oppure, in modo intuitivo:

#alert[Quanto siamo lontani dalla risposta corretta?]

---

== Tabella degli errori

#image("assets/image-11.png")
---

== Perché sommare gli errori non basta?

Se un errore è +10 e un altro è -10, la somma fa zero.

Ma il modello ha sbagliato due volte.

Per questo spesso consideriamo errori assoluti o errori al quadrato.

#alert[Non serve la formula: serve capire che vogliamo misurare la distanza totale dalle risposte vere.]

---

== Loss come montagna

Immaginiamo che ogni combinazione di parametri produca un certo errore.

Alcune combinazioni stanno in alto: errore grande.

Altre stanno in basso: errore piccolo.

#alert[Addestrare = cercare il punto più basso.]

---

== Discesa del gradiente: metafora della nebbia

Siamo su una montagna, c’è nebbia e vogliamo scendere a valle.

Non vediamo tutta la montagna.

Possiamo solo sentire dove il terreno scende vicino a noi.

Facciamo un passo nella direzione più in discesa.

Ripetiamo.

---

== Discesa del gradiente: sotto il cofano

Nel ML facciamo qualcosa di simile:

- partiamo da parametri casuali;
- calcoliamo l’errore;
- capiamo in che direzione modificare i parametri;
- facciamo un piccolo passo;
- ricalcoliamo l’errore;
- ripetiamo molte volte.

#align(center)[
#image("assets/image-12.png")]

---

== Learning rate

Il learning rate decide quanto grande è ogni passo.

Passo troppo piccolo:

- impariamo lentamente.

Passo troppo grande:

- rischiamo di saltare oltre il minimo.

#alert[È come scendere una montagna: né lumaca né salto nel burrone.]

---

== Iterazioni

Un’iterazione è un giro del processo:

#raw(block: true, lang: "txt", "previsione → errore → correzione")

Dopo molte iterazioni, la retta dovrebbe adattarsi meglio ai dati.

#alert[Training significa ripetere questa correzione tante volte.]

---

== Visualizzazione della regressione

#image("assets/image-13.png")
---

== Limiti della regressione lineare

Una retta è semplice e interpretabile.

Ma non va bene per tutto.

Se il fenomeno è curvo, a soglie, stagionale o complesso, una retta può essere troppo povera.

#alert[Modello semplice = facile da capire, ma non sempre abbastanza potente.]

---

== Esempi di regressione

- stimare prezzo di una casa da metri quadri e zona;
- prevedere incasso di un cinema dal giorno e dal film;
- stimare tempo di consegna da distanza e traffico;
- prevedere consumo elettrico da temperatura e presenze;
- stimare vendite di gelati dalla temperatura.

--- 

== Link utili

1. #link("https://mlu-explain.github.io/linear-regression/")
2. #link("https://colab.research.google.com/drive/1Zd-1GnyKrhj2ifBVMoyt4VKt7oZzZocw?usp=sharing")
---

== Classificazione

La classificazione serve per scegliere una categoria.

Esempi:

- spam / non spam;
- reclamo / richiesta normale;
- cane / gatto;
- benigno / maligno;
- cliente fedele / cliente a rischio;
- frode / transazione normale.

---

== Classificazione: non voglio un numero

Nella regressione voglio un valore numerico.

Nella classificazione voglio una classe.

#raw(block: true, lang: "txt", "Regressione: quanto consumerò domani?\nClassificazione: questa email è spam?")

---

== Classificazione: probabilità

Molti classificatori non danno solo una classe.

Danno una probabilità o un punteggio.

Esempio:

#raw(block: true, lang: "txt", "spam: 0.91\nnon spam: 0.09")

Poi scegliamo una soglia.


#image("assets/image-14.png")

---

== Soglia di decisione

Se diciamo:

#raw(block: true, lang: "txt", "se probabilità spam > 0.5 → spam")

stiamo usando una soglia.

Ma la soglia può cambiare.

#alert[In alcuni casi vogliamo essere più prudenti.]

---

== Esempio soglia: medicina

Se un test medico segnala una malattia grave, preferiamo forse avere più falsi allarmi ma meno casi persi.

Esempio:

- falso positivo: persona sana segnalata come a rischio;
- falso negativo: persona malata segnalata come sana.

#alert[Non tutti gli errori hanno lo stesso costo.]

---

== Decision tree

Un decision tree funziona come una serie di domande.

Ogni nodo è una domanda.

Ogni ramo è una risposta.

Ogni foglia è una decisione.

#alert[È uno dei modelli più facili da spiegare.]

---

== Decision tree: frutta

#raw(block: true, lang: "txt", "È gialla?\n├─ sì → è lunga?\n│  ├─ sì → banana\n│  └─ no → limone\n└─ no → è rossa?\n   ├─ sì → mela\n   └─ no → altra frutta")

---

== Decision tree: giocare o no

#image("assets/image-15.png")

---

== Come si addestra un albero?

L’albero sceglie domande che separano bene i dati.

Esempio frutta:

- colore separa banane e mele?
- forma separa banane e limoni?
- peso aiuta?

#alert[Ogni domanda dovrebbe rendere i gruppi più ordinati.]

---

== Albero troppo profondo

Un albero può diventare troppo specifico.

Esempio:

- se colore = rosso;
- e peso = 173 grammi;
- e giorno = martedì;
- e produttore = X;
- allora mela.

#alert[Se l’albero impara dettagli inutili, rischia overfitting.]

---

== Random Forest

Una Random Forest usa tanti alberi.

Ogni albero vota.

La decisione finale è il voto aggregato.

Metafora:

#alert[Non chiedo a un solo esperto: chiedo a una commissione.]

#align(center)[
#image("assets/image-16.png")]

---

== Random Forest: perché funziona meglio?

Un singolo albero può sbagliare per caso.

Tanti alberi diversi, messi insieme, sono spesso più robusti.

Vantaggio:

- buone prestazioni;
- abbastanza robusta;
- spesso funziona bene su dati tabellari.

Svantaggio:

- meno interpretabile di un singolo albero.

---

== K-Nearest Neighbors

KNN classifica guardando gli esempi più vicini.

Idea:

- ho un nuovo punto;
- guardo i K punti più vicini;
- la classe più frequente vince.

#alert[È ragionamento per somiglianza.]

---

== KNN: esempio

Se un nuovo cliente assomiglia molto a clienti che in passato hanno abbandonato, potrebbe essere a rischio.

Se una nuova email assomiglia a email spam, potrebbe essere spam.

#alert[Il concetto di distanza è fondamentale.]

#image("assets/image-17.png")

---

== KNN: dettaglio importante

KNN non viene addestrato come altri modelli.

Memorizza il dataset.

Quando arriva un nuovo caso, lo confronta con gli esempi salvati.

Pro:

- semplice.

Contro:

- lento su dataset grandi.

---

== SVM

Support Vector Machine cerca un confine che separi bene le classi.

Idea intuitiva:

- non basta separare;
- vogliamo separare con il margine più ampio possibile.

#alert[Come disegnare una linea lasciando spazio di sicurezza da entrambe le parti.]

---

== SVM: support vectors

I punti più vicini al confine sono i più importanti.

Si chiamano support vectors.

Sono quelli che “sostengono” la decisione del modello.

#alert[Non tutti i punti contano allo stesso modo.]

#align(center)[
#image("assets/image-18.png")]

---

== Classificazione: come la valutiamo?

Prima idea: accuratezza.

#raw(block: true, lang: "txt", "accuratezza = esempi classificati bene / esempi totali")

Esempio:

- 100 immagini;
- 90 corrette;
- accuratezza = 90%.

---

== Il problema dell’accuratezza

Immaginiamo 1000 email:

- 990 normali;
- 10 spam.

Un modello stupido dice sempre “normale”.

Risultato:

#raw(block: true, lang: "txt", "990 corrette su 1000 = 99% accuratezza")

#alert[Sembra ottimo, ma non trova neanche uno spam.]

---

== Classi sbilanciate

Le classi sono sbilanciate quando una è molto più frequente dell’altra.

Esempi:

- frodi bancarie: poche rispetto alle transazioni normali;
- malattie rare: pochi casi positivi;
- guasti macchina: pochi eventi rispetto al funzionamento normale.

#alert[In questi casi l’accuratezza può ingannare.]

---

== Matrice di confusione

La matrice di confusione mostra cosa abbiamo previsto bene e male.

Per due classi:

- veri positivi;
- veri negativi;
- falsi positivi;
- falsi negativi.

#alert[Serve per capire il tipo di errore.]

---

== Matrice di confusione: esempio

#raw(block: true, lang: "txt", "                 previsto spam | previsto normale\nreale spam            8        |       2\nreale normale         5        |      985")

Domanda:

#alert[Quale errore è più grave nel nostro caso?]

---

== Precisione e richiamo, senza formule

Precisione:

- quando il modello segnala positivo, quanto spesso ha ragione?

Richiamo:

- tra tutti i positivi reali, quanti ne trova?

#alert[Precisione = pochi falsi allarmi. Richiamo = pochi casi persi.]

---

== Esempio: filtro spam

Alta precisione:

- se metto una email nello spam, quasi sicuramente è spam.

Alto richiamo:

- riesco a catturare quasi tutto lo spam.

Trade-off:

#alert[Se sono troppo aggressivo rischio di buttare email importanti nello spam.]

---

== Gestire classi sbilanciate

Possibili strategie:

- raccogliere più dati della classe rara;
- togliere esempi dalla classe dominante;
- creare esempi sintetici;
- cambiare soglie;
- usare metriche più adatte;
- pesare di più gli errori importanti.

---

== Oversampling con immagini

Con immagini possiamo creare varianti:

- ruotare leggermente;
- specchiare;
- cambiare luminosità;
- ritagliare;
- aggiungere rumore.

#alert[Attenzione: creare dati non significa inventare verità.]

---

== Regressione vs classificazione

#raw(block: true, lang: "txt", "Regressione\n- output numerico\n- esempio: prezzo, consumo, ritardo\n\nClassificazione\n- output categoria\n- esempio: spam, cane/gatto, rischio alto/basso")

#align(center)[
#image("assets/image-19.png")]

---

== Link utili 

1. #link("https://colab.research.google.com/drive/1pRvH1DbcQDPLhfE_296ykI9vAqGg-Plw?usp=sharing")


---

== Clustering

Il clustering raggruppa oggetti simili.

Non abbiamo etichette corrette.

Il modello prova a trovare gruppi naturali.

Esempi:

- segmentazione clienti;
- gruppi di reclami;
- anomalie;
- documenti simili.

#image("assets/image-20.png")

---

== Clustering: esempio supermercato

Dati sugli acquisti:

- alcuni clienti comprano prodotti premium;
- altri cercano offerte;
- altri comprano solo online;
- altri comprano spesso pochi prodotti.

#alert[Il clustering può scoprire gruppi utili per marketing e servizio clienti.]

---

== K-means
K-means divide i dati in K gruppi.

#components.side-by-side(columns: (1fr, 3fr), gutter: 2em)[

Passi intuitivi:

1. scegli K;
2. scegli K centri iniziali;
3. assegna ogni punto al centro più vicino;
4. sposta i centri al cuore dei gruppi;
5. ripeti finché si stabilizza.
][
#image("assets/image-21.png")
]
---

== K-means: il centroide

Il centroide è il centro del gruppo.

Metafora:

- ogni gruppo ha un “baricentro”;
- i punti vanno con il baricentro più vicino;
- poi il baricentro si sposta.

#alert[K è un iperparametro: lo scegliamo noi.]

---

== Problema: scegliere K

Se K è troppo basso:

- gruppi troppo generici.

Se K è troppo alto:

- gruppi troppo frammentati.

Esempio:

#alert[Dividere tutti i clienti in 2 gruppi può essere poco utile; dividerli in 1000 gruppi può essere ingestibile.]

#align(center)[
#image("assets/image-22.png")]

---

== Anomaly detection

Anomaly detection cerca casi strani o insoliti.

Esempi:

- transazione bancaria sospetta;
- macchina con vibrazioni anomale;
- accesso informatico strano;
- ordine con quantità fuori scala;
- consumo energetico improvvisamente alto.

---

== Raccomandazioni

I sistemi di raccomandazione suggeriscono contenuti o prodotti.

Esempi:

- film su Netflix;
- prodotti su Amazon;
- video su YouTube;
- canzoni su Spotify;
- contatti su LinkedIn.

#alert[Spesso combinano somiglianze tra utenti, prodotti e comportamenti.]

---

== Raccomandazioni: idea semplice

Se utenti simili a te hanno apprezzato un film, forse piacerà anche a te.

Se hai comprato certi prodotti, potresti essere interessato a prodotti simili.

#alert[Il comportamento passato diventa suggerimento futuro.]

---

== Reinforcement learning: più sotto il cofano

#components.side-by-side(columns: (1fr, 1fr), gutter: 2em)[
Elementi principali:

- agente: chi decide;
- ambiente: il mondo in cui agisce;
- stato: situazione attuale;
- azione: scelta possibile;
- ricompensa: feedback;
- policy: strategia di comportamento.
][
#image("assets/image-23.png")]
---

== RL: esempio videogioco

Agente:

- il personaggio.

Ambiente:

- il livello di gioco.

Azioni:

- muoversi, saltare, sparare.

Ricompensa:

- punti, sopravvivenza, obiettivo raggiunto.

#alert[Il modello impara provando strategie.]

---

== RL: perché è difficile

Il problema è che una buona decisione oggi può dare ricompensa solo più avanti.

Esempio:

- nel calcio, un passaggio utile non è subito un goal;
- in robotica, un movimento sbagliato può far cadere il robot dopo qualche secondo.

#alert[Bisogna collegare azioni presenti a effetti futuri.]

---

== RL: cosa impariamo?

#align(center)[
#image("assets/image-24.png")]


---

== Modelli semplici: pro e contro

Pro:

- più facili da spiegare;
- richiedono meno dati;
- spesso sufficienti;
- più veloci.

Contro:

- non gestiscono bene immagini, audio, testo complesso;
- possono non cogliere pattern complicati;
- dipendono molto dalle feature scelte a mano.

---

== Feature engineering

Prima del Deep Learning, spesso serviva costruire manualmente le feature.

Esempio immagini:

- bordi;
- angoli;
- colori;
- forme.

Esempio testo:

- parole frequenti;
- lunghezza;
- punteggiatura;
- presenza di termini specifici.

#alert[Il lavoro umano stava molto nella scelta delle feature.]

---

== Perché passare al Deep Learning?

Perché alcuni dati sono troppo complessi per feature manuali semplici.

Esempi:

- immagini;
- audio;
- video;
- linguaggio naturale;
- dati multimodali.

#alert[Il Deep Learning prova a imparare anche le feature.]

---

== Rete neurale: idea intuitiva

Una rete neurale è composta da tanti piccoli elementi collegati.

Ogni elemento fa una trasformazione semplice.

Messi insieme, possono imparare trasformazioni complesse.

#alert[Molte operazioni semplici combinate producono comportamento complesso.]

---

== Neurone artificiale

Un neurone artificiale prende numeri in input, li pesa e produce un output.

Idea:

#raw(block: true, lang: "txt", "input → pesi → somma → attivazione → output")

I pesi sono parametri appresi durante il training.

#align(center)[
#image("assets/image-25.png")]

---

== Pesi

Un peso dice quanto conta un input.

Esempio email spam:

- presenza di molti link: peso alto;
- parola “riunione”: peso basso o negativo;
- mittente sconosciuto: peso medio.

#alert[Il modello impara quali segnali sono importanti.]

---

== Strati

Le reti neurali hanno strati.

- input layer: riceve i dati;
- hidden layers: trasformano l’informazione;
- output layer: produce la risposta.

#alert[Deep = molti strati.]
#align(center)[
#image("assets/image-26.png")]

---

== Deep Learning: rappresentazioni successive

In una rete per immagini:

- primi strati: bordi e colori;
- strati intermedi: forme;
- strati alti: parti di oggetti;
- output: categoria finale.

#alert[Il modello costruisce rappresentazioni sempre più astratte.]

---

== Esempio: riconoscere un gatto

Il modello non parte sapendo cos’è un gatto.

Impara pattern come:

- bordi;
- texture;
- occhi;
- orecchie;
- muso;
- combinazioni di parti.

#alert[Non gli diciamo noi ogni regola.]

---

== Deep Learning e dati

Le reti profonde spesso richiedono:

- molti dati;
- molta potenza di calcolo;
- tempo di addestramento;
- attenzione a overfitting e bias.

#alert[Più potenza non significa automaticamente migliore.]

---

== Deep Learning e GPU

Le GPU sono processori adatti a fare tante operazioni simili in parallelo.

Sono utili perché il Deep Learning richiede moltissimi calcoli numerici.

#alert[È uno dei motivi tecnici dell’esplosione recente dell’AI.]

---

== Perché proprio negli ultimi anni?

- più dati disponibili;
- più potenza di calcolo;
- GPU e cloud;
- algoritmi migliori;
- librerie software mature;
- investimenti enormi;
- applicazioni commerciali evidenti.

---

== Deep Learning non sostituisce tutto

Su dati tabellari aziendali, modelli più semplici possono ancora funzionare benissimo.

Esempi:

- Random Forest;
- Gradient Boosting;
- regressione;
- alberi decisionali.

#alert[Non sempre il modello più complesso è il migliore.]

---

== Interpretabilità

Un modello interpretabile permette di capire perché ha preso una decisione.

Più il modello è complesso, più può diventare una scatola nera.

Esempio:

- albero decisionale: abbastanza spiegabile;
- rete neurale profonda: più difficile da spiegare.

---

== Black box

Una black box è un sistema che produce output senza rendere facilmente comprensibile il processo interno.

Problema:

- può essere accurato;
- ma difficile da giustificare;
- difficile da controllare;
- delicato in ambiti ad alto rischio.

#alert[Accuratezza e spiegabilità sono entrambe importanti.]

---

== Trade-off pratico

#raw(block: true, lang: "txt", "Modello semplice\n+ interpretabile\n+ veloce\n- meno potente su dati complessi\n\nModello complesso\n+ potente\n+ adatto a immagini/testo/audio\n- più difficile da spiegare\n- richiede più dati e calcolo")

---

== Rilascio del modello

Addestrare non basta.

Bisogna integrarlo in un’applicazione o processo.

Esempi:

- filtro spam nella mail;
- modello antifrode nel pagamento;
- previsione consumo in dashboard;
- classificatore reclami in CRM.

---

== Monitoraggio

Un modello può peggiorare nel tempo.

Perché?

- cambiano i clienti;
- cambiano i prodotti;
- cambia il linguaggio;
- cambiano le frodi;
- cambiano le condizioni del mercato.

#alert[Un modello non è “finito per sempre”.]

---

== Data drift

Data drift significa che i dati nuovi sono diversi dai dati usati in addestramento.

Esempio:

- modello addestrato prima della pandemia;
- comportamento clienti cambia radicalmente;
- il modello continua a usare vecchi pattern.

#alert[Se il mondo cambia, il modello può diventare vecchio.]

---

== Concept drift

Concept drift significa che cambia la relazione tra input e output.

Esempio spam:

- gli spammer cambiano linguaggio;
- parole prima sospette diventano normali;
- nuovi trucchi aggirano il filtro.

#alert[Il concetto da imparare si sposta.]

---

== Human in the loop

In molti casi la persona resta nel ciclo.

Il modello suggerisce.

La persona controlla.

La decisione finale resta umana.

Esempi:

- sanità;
- credito;
- selezione personale;
- documenti ufficiali;
- sicurezza.

---

== Errore accettabile

Prima di usare ML bisogna chiedersi:

- quanto costa un falso positivo?
- quanto costa un falso negativo?
- chi controlla l’output?
- il modello può spiegarsi?
- cosa succede se sbaglia?

#alert[Non tutti gli errori sono uguali.]

---

== Bias: richiamo

Un modello può imparare distorsioni presenti nei dati.

Esempio:

- dati storici discriminatori;
- etichette prodotte da persone con pregiudizi;
- gruppi poco rappresentati;
- feature che nascondono informazioni sensibili.

#alert[Il ML può automatizzare ingiustizie.]

---

== Bias: esempio prestiti

Se uno storico prestiti penalizza alcune zone geografiche, il modello può imparare che quella zona è un segnale negativo.

Problema:

- magari non valuta davvero la solvibilità individuale;
- usa una scorciatoia statistica;
- produce decisioni ingiuste.

#alert[Correlazione non significa causalità.]

---

== Correlazione e causalità

Correlazione:

- due cose si muovono insieme.

Causalità:

- una cosa causa l’altra.

Esempio scherzoso:

- aumentano le vendite di gelati;
- aumentano gli incidenti in piscina.

La causa comune potrebbe essere il caldo.

---

== Leakage

Data leakage significa che durante l’addestramento il modello vede informazioni che non avrebbe nel mondo reale.

Esempio:

- voglio prevedere se un cliente abbandonerà;
- nel dataset includo una colonna “data cancellazione contratto”;
- il modello sembra bravissimo, ma sta barando.

#alert[Prestazioni troppo belle possono nascondere errori metodologici.]

---

== Feature inutili ma pericolose

Un modello può usare scorciatoie.

Esempio immagini:

- modello riconosce cani e lupi;
- ma impara che “neve” significa lupo;
- non ha davvero imparato il lupo.

#alert[Il modello può imparare il segnale sbagliato.]

---

== Demo mentale: spam

Domanda:

Se addestriamo un filtro spam solo su email vecchie, cosa succede quando gli spammer cambiano stile?

Possibili problemi:

- peggioramento;
- falsi negativi;
- nuove parole non viste;
- necessità di riaddestrare.

---

== Demo mentale: recensioni false

Un modello deve riconoscere recensioni false.

Feature possibili:

- lunghezza;
- ripetizione di parole;
- account nuovo;
- orario di pubblicazione;
- somiglianza con altre recensioni.

#alert[Ma chi scrive recensioni false può adattarsi.]

---

== Cosa significa “il modello ha imparato”?

Non significa che ha capito come una persona.

Significa che ha trovato parametri che riducono l’errore sui dati di addestramento e, speriamo, funzionano su dati nuovi.

#alert[Imparare, nel ML, è una definizione operativa.]

---

== Il modello non conosce il contesto aziendale

Il modello vede pattern.

Non conosce automaticamente:

- policy interne;
- eccezioni operative;
- relazioni personali;
- obiettivi strategici;
- responsabilità legali.

#alert[Serve sempre il contesto umano.]

---

== Checklist: buon problema ML

- esiste un obiettivo chiaro?
- abbiamo dati rilevanti?
- abbiamo esempi corretti?
- possiamo misurare l’errore?
- l’errore è accettabile?
- possiamo controllare il risultato?
- il modello crea valore?

---

== Checklist: red flag

- dati troppo pochi;
- dati non rappresentativi;
- obiettivo confuso;
- metriche sbagliate;
- classi sbilanciate ignorate;
- privacy non gestita;
- output non verificabile;
- responsabilità non chiara.

---

== Mini-attività 1

Per ciascun caso, dite se è regressione, classificazione, clustering o RL:

- prevedere il consumo elettrico;
- dividere clienti in gruppi;
- decidere se una email è spam;
- far imparare a un robot a camminare;
- stimare il prezzo di una casa;
- riconoscere transazioni sospette.

---

== Mini-attività 2

Pensate a un processo aziendale.

Domande:

- quali dati produce?
- quale output vorremmo prevedere?
- avremmo etichette?
- quale errore sarebbe grave?
- chi dovrebbe verificare il modello?

---

== Mini-attività 3

Caso: sistema per dare priorità ai ticket.

Decidiamo:

- feature possibili;
- target;
- training set;
- metrica;
- rischi;
- controllo umano.

---

== Mini-attività 4

Caso: prevedere clienti a rischio.

Domande:

- quali dati servono?
- cosa significa “a rischio”?
- dopo quanto tempo misuriamo se avevamo ragione?
- quali azioni facciamo sui clienti segnalati?

#alert[Un modello deve collegarsi a un’azione concreta.]

---

== Perché questa lezione serve prima degli LLM?

Gli LLM sembrano molto diversi, ma sotto hanno concetti comuni:

- dati;
- parametri;
- loss;
- training;
- generalizzazione;
- valutazione;
- bias;
- costo computazionale.

#alert[Capire il ML aiuta a capire anche l’AI generativa.]
