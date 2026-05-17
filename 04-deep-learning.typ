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
    title: [04 - Apprendimento profondo],
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

- perché nasce il Deep Learning;
- cosa sono le reti neurali artificiali;
- cosa succede dentro un neurone artificiale;
- come una rete trasforma input in output;
- perché servono molti livelli;
- come funzionano CNN, RNN, LSTM e Autoencoder;
- perché tutto questo prepara il terreno ai modelli generativi moderni.

---

== Cosa NON rifacciamo oggi

Abbiamo già visto:

- train, validation e test set;
- overfitting e underfitting;
- metriche di valutazione;
- regressione, classificazione e clustering;
- discesa del gradiente in generale.

Oggi useremo questi concetti, ma non li rispiegheremo da zero.

---

== Ripasso lampo: Machine Learning

Nel Machine Learning non scriviamo tutte le regole a mano.

Diamo al sistema:

- dati;
- esempi;
- risultati attesi;
- un algoritmo di apprendimento.

Il sistema costruisce un modello.

#alert[Il modello è una macchina che trasforma input in output.]

---

== Ripasso lampo: esempio spam

Input:

#raw(block: true, lang: "txt", "Oggetto: vinci subito un premio\nTesto: clicca qui per ricevere denaro gratis")

Output desiderato:

#raw(block: true, lang: "txt", "spam")

Dopo molti esempi, il modello impara schemi utili per classificare email nuove.

---

== Perché non basta il Machine Learning classico?

Molti modelli classici funzionano bene quando i dati sono:

- tabellari;
- puliti;
- con poche variabili;
- facili da descrivere con feature esplicite.

Ma diventano più fragili con:

- immagini;
- audio;
- testo;
- video;
- segnali complessi;
- dati grezzi ad alta dimensionalità.

---

== Il problema delle feature

Nei modelli classici spesso dobbiamo decidere noi quali caratteristiche usare.

Esempio per classificare case:

- metri quadrati;
- zona;
- numero di stanze;
- piano;
- anno di costruzione.

Esempio per classificare immagini:

- bordi?
- colori?
- forme?
- texture?
- proporzioni?

#alert[Con dati complessi scegliere le feature a mano diventa difficilissimo.]

---

== Deep Learning: idea centrale

Il Deep Learning prova a imparare direttamente dai dati grezzi.

Invece di dire noi:

#raw(block: true, lang: "txt", "Guarda queste feature")

lasciamo che la rete impari rappresentazioni utili.

#raw(block: true, lang: "txt", "Dati grezzi → livelli della rete → rappresentazioni → output")

---

== Definizione semplice

Il Deep Learning è una parte del Machine Learning basata su reti neurali con molti livelli.

Questi livelli imparano trasformazioni successive dei dati.

Esempio immagine:

#raw(block: true, lang: "txt", "pixel → bordi → forme → parti di oggetto → oggetto")

#alert[Deep = molti passaggi di trasformazione.]

---

== AI, ML, DL

#align(center)[
#image("assets/image-27.png")]

---

== ML classico vs Deep Learning

=== ML classico

- spesso richiede feature progettate a mano;
- funziona molto bene su dati tabellari;
- modelli spesso più interpretabili;
- meno costoso da addestrare.

=== Deep Learning

- impara feature automaticamente;
- funziona molto bene su immagini, audio, testo;
- richiede molti dati e calcolo;
- spesso è meno interpretabile.

---

== Perché il Deep Learning è esploso?

Tre ingredienti:

1. molti più dati disponibili;
2. molta più potenza di calcolo;
3. algoritmi e architetture migliori.

#alert[Senza dati e calcolo, le reti profonde restano teoria interessante ma poco pratica.]

---


== Perché immagini, audio e testo sono difficili?

=== Perché sono dati molto ricchi.

#components.side-by-side(columns: (1fr, 1fr), gutter: 2em)[
Una piccola immagine può contenere:

- migliaia o milioni di pixel;
- forme;
- colori;
- oggetti;
- prospettiva;
- illuminazione;
- rumore;
- contesto.
][
Un testo contiene:

- parole;
- significato;
- contesto;
- tono;
- ambiguità.
]
---

== Esempio: riconoscere un gatto

Per una persona è facile.

Per un computer, un’immagine è solo una griglia di numeri.

#raw(block: true, lang: "txt", "pixel 1 = 124\npixel 2 = 88\npixel 3 = 201\n...")

La domanda è:

#alert[Come passiamo da milioni di numeri all’idea “questo è un gatto”?]

---

== Esempio: audio

Un file audio è una sequenza di valori nel tempo.

Il sistema deve capire:

- suoni;
- fonemi;
- parole;
- frasi;
- pause;
- rumore di fondo;
- accento;
- contesto.

#alert[Anche qui: dati grezzi molto complessi.]

---

== Esempio: testo

La frase:

#raw(block: true, lang: "txt", "Non è male.")

può significare:

- è abbastanza buono;
- è mediocre;
- è una critica mascherata;
- è un complimento timido.

Il significato dipende dal contesto.

---

== Perché le reti neurali?

Le reti neurali sono utili perché possono costruire trasformazioni complesse combinando tante unità semplici.

Un singolo neurone artificiale è molto semplice.

Una rete con molti neuroni può rappresentare comportamenti molto complessi.

#alert[La potenza nasce dalla composizione di tanti pezzi semplici.]

---

== Neurone biologico: analogia

Un neurone biologico riceve segnali da altri neuroni.

Poi:

- raccoglie input;
- li combina;
- se il segnale è abbastanza forte, si attiva;
- invia un segnale ad altri neuroni.

#alert[Attenzione: è solo un’ispirazione, non una copia fedele del cervello.]

---

== Placeholder immagine

#align(center)[
#image("assets/image-28.png")]

---

== Neurone artificiale: idea

Un neurone artificiale fa una cosa molto semplice:

1. riceve numeri in input;
2. dà più o meno importanza a ogni input tramite pesi;
3. somma tutto;
4. applica una funzione di attivazione;
5. produce un output.

#align(center)[
#image("assets/image-25.png")]

---

== Formula senza paura

Un neurone può essere visto così:

#raw(block: true, lang: "txt", "output = funzione(\n  input1 × peso1 +\n  input2 × peso2 +\n  input3 × peso3 +\n  bias\n)")

Non serve fare calcoli a mano.

Serve capire il senso.

---

== Cosa sono i pesi?

I pesi dicono quanto conta un input.

Esempio valutazione cliente:

- numero reclami: peso alto;
- data ultimo acquisto: peso medio;
- colore preferito: peso basso.

Durante l’addestramento la rete modifica i pesi.

#alert[Imparare significa trovare pesi migliori.]

---

== Cos’è il bias del neurone?

Il bias è un valore aggiunto alla somma.

Serve a spostare la soglia di attivazione.

Analogia:

#raw(block: true, lang: "txt", "Una persona può essere più o meno facile da convincere.\nIl bias modifica questa predisposizione di base.")

---

== Funzione di attivazione

La funzione di attivazione decide come trasformare il segnale.

Senza funzioni di attivazione, la rete sarebbe solo una grande combinazione lineare.

Con le attivazioni, la rete può imparare forme molto più complesse.

#alert[Le attivazioni introducono non linearità.]

---

== Perché serve la non linearità?

Alcuni problemi si separano con una linea retta.

Altri no.

Esempio:

#raw(block: true, lang: "txt", "Problema semplice: separo due gruppi con una linea.\nProblema complesso: serve una curva, una forma, una regione irregolare.")

Le reti neurali servono soprattutto quando le relazioni sono complesse.

---

== Funzione a scalino

Idea molto semplice:

#raw(block: true, lang: "txt", "Se il segnale supera una soglia → neurone acceso\nSe non la supera → neurone spento")

È intuitiva, ma troppo rigida per molti casi reali.

---

== Sigmoide

La sigmoide è una versione più morbida dello scalino.

Invece di passare bruscamente da 0 a 1, cresce gradualmente.

È utile per interpretare l’output come una probabilità.

Esempio:

#raw(block: true, lang: "txt", "probabilità che l’email sia spam = 0.87")

---

== ReLU

ReLU è una funzione molto usata nelle reti moderne.

Idea:

#raw(block: true, lang: "txt", "se il valore è negativo → 0\nse il valore è positivo → lo lascio passare")

È semplice, veloce e funziona bene in molte reti profonde.

---

== Tante funzioni di attivazione

#align(center)[
#image("assets/image-29.png")]

---

== Dal neurone alla rete

Un neurone da solo è limitato.

Tanti neuroni collegati formano una rete.

La rete è organizzata in livelli:

- livello di input;
- livelli nascosti;
- livello di output.

---

== Livello di input

Il livello di input riceve i dati.

Esempio tabellare:

- età;
- reddito;
- numero acquisti;
- reclami;
- tempo dall’ultimo ordine.

Ogni feature può entrare come numero nella rete.

---

== Input immagine

Per un’immagine, l’input può essere una griglia di pixel.

Esempio:

#raw(block: true, lang: "txt", "immagine 28×28 in bianco e nero = 784 numeri")

Per immagini a colori:

#raw(block: true, lang: "txt", "altezza × larghezza × 3 canali RGB")

---

== Livelli nascosti

I livelli nascosti trasformano progressivamente i dati.

Ogni livello costruisce una nuova rappresentazione.

Esempio immagine:

#raw(block: true, lang: "txt", "pixel → bordi → forme → parti → oggetto")

---

== Livello di output

Il livello di output produce il risultato finale.

Esempi:

- regressione: un numero;
- classificazione binaria: una probabilità;
- classificazione multiclasse: una probabilità per classe;
- generazione: una sequenza, immagine o altro.

---

== Output: esempi

#raw(block: true, lang: "txt", "Regressione:\nprezzo previsto = 230.000 euro\n\nClassificazione binaria:\nspam = 0.94\n\nClassificazione multiclasse:\ngatto = 0.80\ncane = 0.15\nvolpe = 0.05")

---

== Multi-Layer Perceptron

Una MLP è una rete neurale feed-forward classica.

Feed-forward significa:

#raw(block: true, lang: "txt", "input → hidden layer → hidden layer → output")

Il segnale va in avanti.

Non ci sono cicli.

#image("assets/image-30.png")

---

== Rete totalmente connessa

In una MLP tipica, ogni neurone di un livello è collegato a tutti i neuroni del livello successivo.

Questo la rende flessibile.

Ma può diventare molto costosa quando gli input sono grandi.

#alert[Qui nasce uno dei limiti delle MLP.]

---

== Sotto il cofano: forward pass

Il forward pass è il viaggio dei dati nella rete.

#raw(block: true, lang: "txt", "Input\n→ calcoli nel primo livello\n→ attivazioni\n→ calcoli nel secondo livello\n→ ...\n→ output")

Alla fine confrontiamo output previsto e risposta corretta.

---

== Sotto il cofano: loss

La loss misura quanto il modello ha sbagliato.

Esempio:

#raw(block: true, lang: "txt", "Risposta corretta: gatto\nRisposta modello: cane\nLoss alta")

Altro esempio:

#raw(block: true, lang: "txt", "Risposta corretta: gatto\nRisposta modello: gatto con probabilità 0.97\nLoss bassa")

---

== Sotto il cofano: backward pass

Dopo aver misurato l’errore, la rete aggiorna i pesi.

Idea:

#raw(block: true, lang: "txt", "Quali pesi hanno contribuito all’errore?\nCome li modifico un po’ per sbagliare meno la prossima volta?")

Questo processo si chiama backpropagation.

---

== Backpropagation senza formule

Immagina una catena di montaggio.

Se il prodotto finale è difettoso, vogliamo capire:

- dove è nato il problema;
- quale passaggio ha contribuito;
- quanto correggere ogni passaggio.

Backpropagation fa qualcosa di simile nella rete.

---

== Addestramento: ciclo intuitivo

#raw(block: true, lang: "txt", "1. Prendo un batch di esempi\n2. Faccio passare i dati nella rete\n3. Calcolo la loss\n4. Torno indietro e aggiorno i pesi\n5. Ripeto molte volte")

Ogni giro dovrebbe rendere la rete leggermente migliore.

---

== Batch

In pratica non sempre usiamo tutti i dati insieme.

Usiamo piccoli gruppi chiamati batch.

Analogia:

#raw(block: true, lang: "txt", "Invece di correggere tutti i compiti della scuola insieme,\nne correggo un pacchetto alla volta e aggiorno il metodo.")

---

== Epoca

Un’epoca è un giro completo su tutto il training set.

Esempio:

#raw(block: true, lang: "txt", "Dataset: 10.000 immagini\nBatch: 100 immagini\n1 epoca = 100 batch")

---

== Learning rate

Il learning rate dice quanto grandi sono gli aggiornamenti dei pesi.

Analogia della montagna:

- passo troppo piccolo: ci metto una vita;
- passo troppo grande: rischio di saltare il punto buono;
- passo giusto: scendo bene verso la valle.

---

== Discesa del gradiente

#align(center)[
#image("assets/image-31.png")]

---

== Perché “deep”?

Una rete è deep quando ha molti livelli.

Più livelli permettono trasformazioni più articolate.

Esempio:

#raw(block: true, lang: "txt", "Layer 1: segnali semplici\nLayer 2: combinazioni di segnali\nLayer 3: pattern più complessi\nLayer 4: concetti più astratti")

---

== Gerarchia delle rappresentazioni

Le reti profonde sono forti perché costruiscono rappresentazioni gerarchiche.

Immagine:

#raw(block: true, lang: "txt", "pixel → linee → angoli → forme → oggetti")

Testo:

#raw(block: true, lang: "txt", "caratteri → parole → frasi → significato → intenzione")

Audio:

#raw(block: true, lang: "txt", "onda sonora → fonemi → parole → frase")

---

== Deep Learning come fabbrica di rappresentazioni

Possiamo vedere una rete profonda come una fabbrica.

Ogni livello prende una materia prima e la trasforma.

Alla fine, l’output è una rappresentazione utile per il task.

#alert[La vera magia non è la predizione finale: è la rappresentazione interna che la rete costruisce.]

---

== Rappresentazioni latenti

Una rappresentazione latente è una descrizione interna, compressa e utile dei dati.

Non sempre è leggibile per noi.

Ma può contenere informazioni utili.

Esempio:

#raw(block: true, lang: "txt", "Immagine originale → rete → vettore numerico che cattura contenuto, forma, stile, oggetti")

---

== Perché è difficile interpretarle?

Perché la rete non usa parole umane.

Usa numeri distribuiti tra tanti neuroni.

Un concetto non sta necessariamente in un solo neurone.

Può essere rappresentato da un pattern di attivazioni.

---

== Black box

Molte reti profonde sono difficili da interpretare.

Sappiamo:

- che input entrano;
- che output escono;
- come sono fatti i calcoli;
- ma non sempre capiamo facilmente perché una specifica decisione è stata presa.

#alert[Questo è importante per responsabilità, fiducia e sicurezza.]

---

== Perché non usare sempre Deep Learning?

Perché non è sempre la scelta migliore.

Svantaggi:

- richiede molti dati;
- richiede calcolo;
- può essere difficile da spiegare;
- può essere costoso;
- può essere eccessivo per problemi semplici.

#alert[Se un modello semplice funziona bene, spesso è meglio usarlo.]

---

== Quando il Deep Learning è forte

È particolarmente forte con:

- immagini;
- video;
- audio;
- testo;
- linguaggio naturale;
- dati multimodali;
- problemi con molte variabili;
- grandi dataset.

---

== Quando è forse troppo

Forse non serve Deep Learning per:

- calcolare IVA;
- ordinare una tabella;
- sommare vendite mensili;
- controllare una scadenza;
- applicare una regola aziendale semplice.

#alert[Non tutto deve diventare AI.]

---

#focus-slide("Reti Neurali Convoluzionali")

== Il problema delle immagini nelle MLP

Una MLP deve “appiattire” l’immagine.

#raw(block: true, lang: "txt", "immagine 600×400×3\n→ 720.000 numeri in fila")

Problemi:

- tantissimi pesi;
- perdita della struttura spaziale;
- pixel vicini non sono trattati come vicini;
- poca efficienza.

#align(center)[
#image("assets/image-33.png")]

---

== Perdita della struttura spaziale

In un’immagine, la posizione conta.

Pixel vicini formano:

- bordi;
- linee;
- texture;
- parti di oggetti.

Se appiattiamo tutto in una lista, perdiamo parte dell’informazione spaziale.

---

== Esempio intuitivo

Se vediamo due occhi, un naso e una bocca vicini, pensiamo a un volto.

Se gli stessi pixel sono sparsi a caso, non formano più un volto.

#alert[La vicinanza spaziale è informazione.]

---

== Problema della traslazione

Un gatto resta un gatto anche se è:

- un po’ a sinistra;
- un po’ a destra;
- più in alto;
- più in basso;
- leggermente ruotato.

Una rete per immagini dovrebbe essere robusta a questi cambiamenti.

---

== Problema della traslazione (2)

Con le MLP abbiamo:

#align(center)[
#image("assets/image-32.png")]

---

== Ispirazione dalla visione umana

La corteccia visiva costruisce rappresentazioni progressive.

Prima riconosce segnali semplici.

Poi combina segnali semplici in forme più complesse.

E alla fine riconosce oggetti.

#alert[Le CNN imitano questa idea a livello molto astratto.]


#image("assets/image-34.png")

---

== CNN: idea centrale

Una Convolutional Neural Network usa filtri che scorrono sull’immagine.

Ogni filtro cerca un pattern locale.


#components.side-by-side(columns: (1fr, 2fr), gutter: 2em)[
Esempi:

- bordo verticale;
- bordo orizzontale;
- angolo;
- texture;
- piccola forma.
][
#image("assets/image-35.png")
]
---

== Cos’è un filtro?

Un filtro è una piccola griglia di numeri.

Scorre sull’immagine e produce una nuova mappa.

Analogia:

#raw(block: true, lang: "txt", "È come passare una lente sull’immagine\nper evidenziare una certa caratteristica.")

---

== Convoluzione senza formule

La convoluzione è l’operazione in cui il filtro scorre sull’immagine.

Ad ogni posizione guarda una piccola zona.

Poi produce un valore che dice:

#raw(block: true, lang: "txt", "Quanto questa zona assomiglia al pattern cercato dal filtro?")

---

== Feature map

Il risultato di un filtro si chiama feature map.

Una feature map indica dove una certa caratteristica è presente nell’immagine.

Esempio:

#raw(block: true, lang: "txt", "Filtro bordo verticale → mappa dei bordi verticali")

---

== Filtri nelle CNN

#align(center)[
#image("assets/image-36.png")
]

#align(center)[
#image("assets/image-38.png")
]

---

== Filtri imparati automaticamente

Nei programmi tradizionali potremmo scrivere filtri a mano.

Nel Deep Learning, invece, la rete impara i filtri dai dati.

Durante il training, i pesi dei filtri vengono aggiornati.

#alert[La rete scopre da sola quali pattern sono utili.]

---

== Connessioni locali

In una CNN, un neurone non guarda tutta l’immagine.

Guarda solo una piccola zona.

Questo ha senso perché nelle immagini i pattern locali sono importanti.

Esempio:

- bordo di un occhio;
- curva di una ruota;
- angolo di un edificio.

---

== Pesi condivisi

Lo stesso filtro viene usato in tante posizioni dell’immagine.

Vantaggio:

- meno parametri;
- più efficienza;
- capacità di riconoscere lo stesso pattern in posizioni diverse.

#alert[Un bordo verticale è un bordo verticale ovunque si trovi nell’immagine.]

---

== Pooling

Il pooling riduce la dimensione delle feature map.

Idea:

#raw(block: true, lang: "txt", "Riassumo piccole zone mantenendo l’informazione più importante.")

Vantaggi:

- meno calcolo;
- più robustezza a piccoli spostamenti;
- rappresentazioni più compatte.

---

== Max pooling

Il max pooling prende il valore massimo in una piccola zona.

Interpretazione:

#raw(block: true, lang: "txt", "Mi interessa se una caratteristica è presente,\nnon esattamente il pixel preciso in cui compare.")

---

== Architettura CNN tipica

#raw(block: true, lang: "txt", "Immagine\n→ convoluzione\n→ attivazione\n→ pooling\n→ convoluzione\n→ attivazione\n→ pooling\n→ classificatore finale")

---

== Parte convoluzionale e parte finale

Una CNN ha spesso due blocchi:

=== Estrattore di feature

- convoluzioni;
- attivazioni;
- pooling.

=== Classificatore finale

- livelli fully connected;
- output finale.

#image("assets/image-37.png")

---

== Esempio: riconoscere cifre

Dataset classico: cifre scritte a mano.

Input:

- immagine 28×28;
- cifra da 0 a 9.

Output:

#raw(block: true, lang: "txt", "probabilità per ogni cifra\n0, 1, 2, 3, 4, 5, 6, 7, 8, 9")

---

== LeNet-5

LeNet-5 è una delle CNN storiche.

Era pensata per riconoscere cifre scritte a mano.

È importante perché mostra il principio:

#raw(block: true, lang: "txt", "immagine → feature locali → rappresentazioni più astratte → classe")

#image("assets/image-39.png")

---

== ImageNet

ImageNet è stato un dataset enorme per il riconoscimento di oggetti.

Ha avuto un ruolo fondamentale nella diffusione del Deep Learning per computer vision.

Ha permesso di confrontare architetture diverse su un compito comune.

---

== Perché ImageNet è stato importante?

Perché ha mostrato che:

- con molti dati;
- molta potenza di calcolo;
- reti profonde ben progettate;

le performance nel riconoscimento di immagini potevano migliorare tantissimo.

---

== VGG, ResNet e architetture moderne

Nel tempo sono nate molte architetture CNN.

Esempi:

- LeNet;
- AlexNet;
- VGG;
- ResNet;
- EfficientNet.

Non serve ricordarle tutte.

Serve capire che sono modi diversi di organizzare livelli e connessioni.

#image("assets/image-40.png")

---

== ResNet: idea intuitiva

Reti molto profonde possono diventare difficili da addestrare.

ResNet introduce scorciatoie tra livelli.

Analogia:

#raw(block: true, lang: "txt", "Invece di obbligare l’informazione a passare da tutti i corridoi,\napriamo passaggi diretti tra piani diversi.")

---

== Moltissime CNN diverse

#align(center)[
#image("assets/image-41.png")
]

---

== Applicazioni delle CNN

- riconoscimento oggetti;
- diagnostica per immagini;
- controllo qualità industriale;
- videosorveglianza;
- guida assistita;
- OCR;
- analisi satellitare;
- rilevamento difetti;
- ispezione documentale.

---

== Esempio aziendale: controllo qualità

Una telecamera fotografa prodotti sulla linea.

Una CNN può rilevare:

- graffi;
- difetti di forma;
- parti mancanti;
- errori di assemblaggio;
- etichette sbagliate.

#alert[Il valore sta nel rilevare difetti prima che diventino costosi.]

---

== Esempio medico

Una CNN può aiutare nell’analisi di immagini mediche.

Esempi:

- radiografie;
- TAC;
- risonanze;
- immagini dermatologiche.

#alert[Supporto alla decisione, non sostituzione automatica del medico.]

---

== Limiti delle CNN

Le CNN possono essere sensibili a:

- immagini diverse da quelle viste in training;
- rumore;
- cambi di luce;
- oggetti fuori contesto;
- dati sbilanciati;
- errori nelle etichette.

Non “vedono” come una persona.

---

== Link utili

1. #link("https://playground.tensorflow.org/")
2. #link("https://poloclub.github.io/cnn-explainer/")
3. #link("https://cnn-playground.live/imagenet")

---

#focus-slide("Reti Neurali Ricorrenti")

== Che cosa sono i dati sequenziali?

Dati in cui l’ordine conta.

Esempi:

- testo;
- audio;
- serie temporali;
- prezzi di borsa;
- sensori IoT;
- video;
- log di eventi;
- cronologia acquisti.

---

== Perché l’ordine conta?

Frase 1:

#raw(block: true, lang: "txt", "Il cane morde l’uomo.")

Frase 2:

#raw(block: true, lang: "txt", "L’uomo morde il cane.")

Stesse parole, significato diverso.

#alert[L’ordine cambia tutto.]

---

== Problema delle FFNN con sequenze

Una rete feed-forward classica prende input di dimensione fissa.

Ma le sequenze possono essere:

- corte;
- lunghe;
- variabili;
- dipendenti dal passato.

Serve un modello che tenga conto del contesto precedente.

---

== RNN: idea centrale

Una Recurrent Neural Network legge una sequenza un pezzo alla volta.

Mantiene una specie di memoria interna.

#components.side-by-side(columns: (2fr, 1fr), gutter: 2em)[
#raw(block: true, lang: "txt", "input corrente + memoria precedente → nuova memoria + output")
][
#image("assets/image-42.png")
]
---

== Memoria nelle RNN

La memoria non è una memoria umana.

È uno stato numerico che viene aggiornato passo dopo passo.

Serve a portare informazione dal passato al futuro.

Esempio:

#raw(block: true, lang: "txt", "Ho letto l’inizio della frase\n→ uso quel contesto per interpretare la parola successiva")

---

== Esempio: sentiment analysis

Input:

#raw(block: true, lang: "txt", "Il prodotto è arrivato tardi ma l’assistenza è stata ottima.")

Output:

#raw(block: true, lang: "txt", "sentiment complessivo: positivo/neutro/negativo")

Il modello deve considerare tutta la frase.

---

== Tipi di input-output

Le sequenze possono avere forme diverse.

#raw(block: true, lang: "txt", "one-to-one: input singolo → output singolo\none-to-many: input singolo → sequenza\nmany-to-one: sequenza → output singolo\nmany-to-many: sequenza → sequenza")

---

== Many-to-one

Sequenza in input, una risposta in output.

#components.side-by-side(columns: (1fr, 1fr), gutter: 2em)[
Esempi:

- recensione → voto;
- frase → sentiment;
- video → attività riconosciuta;
- storico prezzi → previsione finale.
][
  #image("assets/image-43.png")
]
---

== One-to-many

Un input genera una sequenza.

#components.side-by-side(columns: (1fr, 1fr), gutter: 2em)[
Esempi:

- immagine → descrizione testuale;
- tema musicale → continuazione;
- prompt breve → testo più lungo.
][
#image("assets/image-44.png")
]
---

== Many-to-many

Sequenza in input e sequenza in output.
#components.side-by-side(columns: (1fr, 1fr), gutter: 2em)[
Esempi:

- traduzione;
- sottotitolazione;
- trascrizione audio;
- classificazione di ogni frame in un video.
][
#image("assets/image-45.png")
]
---

== Limite delle RNN semplici

Le RNN semplici fanno fatica a ricordare informazioni molto lontane.

Esempio:

#raw(block: true, lang: "txt", "All’inizio della frase c’è un’informazione importante,\nma la frase è lunghissima e alla fine il modello se la dimentica.")

---

== LSTM

Le LSTM sono RNN progettate per gestire meglio dipendenze a lungo termine.

Idea semplice:

- decidono cosa ricordare;
- cosa dimenticare;
- cosa aggiornare;
- cosa usare per produrre output.

#alert[Una memoria con cancelli di controllo.]

---

== I cancelli della LSTM

Non serve imparare le formule.

L’idea è:

#raw(block: true, lang: "txt", "Forget gate: cosa butto via?\nInput gate: cosa aggiungo?\nOutput gate: cosa mostro all’esterno?")

---

== Analogia LSTM

Immagina di prendere appunti durante una riunione.

Non scrivi tutto.

Decidi:

- cosa è importante;
- cosa è rumore;
- cosa serve dopo;
- cosa può essere dimenticato.

Una LSTM fa qualcosa di simile in forma numerica.

---

== Applicazioni RNN e LSTM

- riconoscimento vocale;
- traduzione automatica;
- serie temporali;
- sentiment analysis;
- generazione musicale;
- analisi di log;
- manutenzione predittiva;
- previsioni su sensori.

---

== Perché oggi si parla meno di RNN?

Le RNN sono state molto importanti.

Ma per molti task di testo sono state superate dai Transformer.

I Transformer gestiscono meglio sequenze lunghe e parallelizzazione.

#alert[Li vedremo quando parleremo di LLM e attenzione.]

---

#focus-slide("Autoencoder")

== Cos’è un autoencoder?

Un autoencoder è una rete che prova a ricostruire il proprio input.

#raw(block: true, lang: "txt", "input → encoder → spazio latente → decoder → ricostruzione")

Sembra inutile?

In realtà serve a imparare rappresentazioni compatte.

#image("assets/image-46.png")

---

== Encoder

L’encoder comprime il dato.

Esempio:

#raw(block: true, lang: "txt", "immagine originale molto grande\n→ vettore più piccolo nello spazio latente")

Deve conservare le informazioni più importanti.

---

== Spazio latente

Lo spazio latente è la rappresentazione compressa.

È una specie di riassunto numerico del dato.

Se funziona bene, conserva l’essenza dell’input.

#alert[È uno dei concetti chiave per capire molti modelli moderni.]

---

== Decoder

Il decoder prende la rappresentazione compressa e prova a ricostruire il dato originale.

#raw(block: true, lang: "txt", "spazio latente → decoder → immagine ricostruita")

L’obiettivo è ricostruire abbastanza bene, non necessariamente in modo perfetto.

---

== Perché comprimere?

Comprimere obbliga la rete a scegliere cosa è importante.

Analogia:

#raw(block: true, lang: "txt", "Se devo riassumere una pagina in una frase,\ndevo capire il contenuto principale.")

---

== Collo di bottiglia

Il livello centrale spesso è più piccolo dell’input.

Questo crea un collo di bottiglia.

La rete non può copiare tutto.

Deve imparare una rappresentazione utile.

#align(center)[
#image("assets/image-47.png")
]

---

== Rischio identità triviale

Se la rete può copiare l’input direttamente, non impara niente di interessante.

Per evitarlo possiamo:

- comprimere molto;
- aggiungere rumore;
- limitare l’uso dei neuroni;
- progettare bene l’architettura.

---

== Denoising autoencoder

Aggiungiamo rumore all’input.

La rete deve ricostruire la versione pulita.

Esempio:

#raw(block: true, lang: "txt", "foto disturbata → autoencoder → foto più pulita")

#image("assets/image-48.png")

---

== Applicazioni autoencoder

- compressione;
- riduzione dimensionalità;
- rimozione rumore;
- anomaly detection;
- raccomandazioni;
- pretraining;
- generazione di dati;
- rappresentazioni latenti.

---

== Anomaly detection

Se un autoencoder è addestrato su dati normali, impara a ricostruire bene dati normali.

Quando arriva un dato anomalo, lo ricostruisce male.

#alert[Errore di ricostruzione alto = possibile anomalia.]

---

== Esempio anomaly detection

Macchinario industriale.

Training su vibrazioni normali.

Poi arriva un nuovo segnale.

Se l’autoencoder non riesce a ricostruirlo bene, forse il macchinario si sta comportando in modo anomalo.

---

== Autoencoder e generazione

Possiamo provare a generare nuovi dati campionando nello spazio latente.

Ma non sempre funziona bene.

Serve uno spazio latente regolare.

Due concetti importanti:

- continuità;
- completezza.

---

== Continuità

Punti vicini nello spazio latente dovrebbero produrre output simili.

Esempio:

#raw(block: true, lang: "txt", "punto A → volto con capelli castani\npunto vicino → volto simile, non un camion")

---

== Completezza

Ogni punto ragionevole dello spazio latente dovrebbe produrre un output sensato.

Se alcune zone producono rumore senza senso, generare diventa difficile.

#alert[Questa idea prepara il terreno ai modelli generativi.]

---

== Spazi latenti 

#image("assets/image-49.png")

---

#focus-slide("Dalla rete al mondo reale")

== Addestrare non basta

Un modello addestrato deve essere usato in un’applicazione reale.

Questo richiede:

- dati in ingresso affidabili;
- infrastruttura;
- monitoraggio;
- aggiornamenti;
- controllo umano;
- gestione errori;
- sicurezza.

---

== Inference

Inference significa usare il modello già addestrato per produrre risposte su nuovi dati.

#raw(block: true, lang: "txt", "nuova immagine → modello → predizione")

Training e inference sono due fasi diverse.

---

== Training vs inference

=== Training

- molti dati;
- molti calcoli;
- aggiornamento dei pesi;
- spesso costoso.

=== Inference

- nuovo input;
- pesi fissi;
- risposta del modello;
- deve essere veloce e affidabile.

---

== Dove gira una rete neurale?

Può girare:

- su un PC;
- su server aziendali;
- in cloud;
- su smartphone;
- su dispositivi embedded;
- in data center;
- su GPU specializzate.

---

== CPU, GPU, TPU

=== CPU

Versatile, adatta a molti compiti.

=== GPU

Molto forte su calcoli paralleli, utile per reti neurali.

=== TPU

Hardware specializzato per machine learning.

#alert[Il Deep Learning è cresciuto anche grazie all’hardware.]

---

== Perché le GPU aiutano?

Le reti neurali fanno tantissimi calcoli simili tra loro.

Le GPU sono brave a fare molti calcoli in parallelo.

Analogia:

#raw(block: true, lang: "txt", "CPU: pochi lavoratori molto flessibili\nGPU: tantissimi lavoratori che fanno operazioni simili insieme")

---

== Costi del Deep Learning

Il Deep Learning può essere costoso in termini di:

- energia;
- tempo di addestramento;
- hardware;
- dati;
- manutenzione;
- competenze;
- infrastruttura.

#alert[Non è gratis solo perché il software è disponibile.]

---

== Modelli grandi e piccoli

Non sempre serve il modello più grande.

A volte serve un modello:

- più veloce;
- più economico;
- più controllabile;
- più adatto al dispositivo;
- più facile da aggiornare.

---

== Edge AI

Edge AI significa eseguire AI vicino al dispositivo che produce i dati.

Esempi:

- smartphone;
- telecamera industriale;
- sensore;
- automobile;
- macchina in fabbrica.

Vantaggi:

- meno latenza;
- meno traffico dati;
- più privacy.

---

== Cloud AI

Cloud AI significa usare modelli su server remoti.

Vantaggi:

- più potenza;
- modelli aggiornati;
- scalabilità;
- meno hardware locale.

Svantaggi:

- dipendenza da connessione;
- costi ricorrenti;
- problemi di privacy e controllo;
- latenza.

---

== Esempio: riconoscimento difetti

Opzione 1: modello in cloud.

- invio immagini al server;
- ricevo risposta.

Opzione 2: modello locale sulla macchina.

- elaborazione immediata;
- dati restano in fabbrica.

La scelta dipende da costi, privacy, latenza e affidabilità.

---

#focus-slide("Transfer learning")

== Problema

Addestrare una grande rete da zero richiede:

- tanti dati;
- molto calcolo;
- tempo;
- competenze.

Ma spesso possiamo partire da una rete già addestrata.

---

== Transfer learning

Transfer learning significa riutilizzare conoscenza appresa su un problema e adattarla a un altro.

Esempio:

#raw(block: true, lang: "txt", "rete addestrata su milioni di immagini\n→ adattata a riconoscere difetti su pezzi industriali")

---

== Perché funziona?

I primi livelli di una rete visiva imparano feature generali.

Esempi:

- bordi;
- texture;
- forme;
- colori;
- pattern locali.

Queste feature possono essere utili in molti task.

---

== Fine-tuning

Fine-tuning significa prendere un modello pre-addestrato e continuare l’addestramento su un dataset specifico.

Analogia:

#raw(block: true, lang: "txt", "Una persona sa già guidare.\nOra deve imparare a guidare un mezzo specifico in un contesto specifico.")

---

== Foundation models

I foundation models sono modelli grandi addestrati su enormi quantità di dati.

Poi possono essere adattati a molti compiti.

Esempi concettuali:

- modelli linguistici;
- modelli visivi;
- modelli multimodali.

#alert[Questo è il ponte verso LLM e AI generativa moderna.]

---

#focus-slide("Modelli generativi profondi")

== Discriminativo vs generativo

Modello discriminativo:

#raw(block: true, lang: "txt", "Dato un input, predico una classe o un valore.")

Modello generativo:

#raw(block: true, lang: "txt", "Imparo come sono fatti i dati e provo a generarne di nuovi simili.")

---

== Esempio cani e gatti

Discriminativo:

#raw(block: true, lang: "txt", "Guardo l’immagine e decido: cane o gatto?")

Generativo:

#raw(block: true, lang: "txt", "Imparo che aspetto hanno cani e gatti\ne genero una nuova immagine plausibile.")

---

== Modelli generativi: idea

Un modello generativo prova a catturare la distribuzione dei dati.

In termini semplici:

#raw(block: true, lang: "txt", "Quali esempi sono plausibili?\nQuali esempi sono improbabili?\nCome posso produrre un nuovo esempio realistico?")

---

== Applicazioni generative

- generazione immagini;
- text-to-speech;
- ricostruzione immagini;
- super-resolution;
- rimozione rumore;
- generazione testo;
- completamento codice;
- sintesi video;
- data augmentation sintetica.

---

== GAN: idea semplice

Una GAN usa due reti:

- generatore;
- discriminatore.

Il generatore produce esempi falsi.

Il discriminatore prova a distinguere falsi e reali.

#alert[È un gioco competitivo.]

#align(center)[
#image("assets/image-53.png")
]
---

== Analogia GAN

Immagina:

- un falsario che produce banconote false;
- un investigatore che prova a riconoscerle.

Se l’investigatore migliora, il falsario deve migliorare.

Se il falsario migliora, l’investigatore deve migliorare.

#image("assets/image-50.png")

---

== GAN: ciclo

#raw(block: true, lang: "txt", "Rumore casuale → generatore → immagine fake\nImmagine vera + immagine fake → discriminatore\nDiscriminatore dà feedback\nGeneratore migliora")

---

== GAN

=== Inizio dell'apprendimento

#image("assets/image-51.png")

=== Dopo qualche epoca 

#image("assets/image-52.png")

---

== GAN: perché sono interessanti?

Perché hanno mostrato che una rete può imparare a produrre dati molto realistici.

Esempi:

- volti artificiali;
- immagini stilizzate;
- miglioramento immagini;
- traduzione immagine-immagine;
- dati sintetici.

---

== Limiti delle GAN

Le GAN possono essere:

- difficili da addestrare;
- instabili;
- sensibili ai dati;
- difficili da controllare;
- potenzialmente usate per deepfake.

#alert[Generare dati realistici è potente, ma anche rischioso.]

---

== Diffusion models: solo intuizione

I modelli di diffusione partono da rumore e imparano a rimuoverlo passo dopo passo.

#raw(block: true, lang: "txt", "rumore puro → meno rumore → forme → dettagli → immagine finale")

Sono alla base di molti sistemi moderni di generazione immagini.

---

== Perché parlarne qui?

Perché autoencoder, GAN e diffusion models mostrano una direzione comune:

#raw(block: true, lang: "txt", "imparare rappresentazioni profonde dei dati\ne usarle per creare nuovi contenuti")

Questo prepara il terreno alla lezione sui modelli generativi e sugli LLM.

---

== Mini attività 1

=== Rete o modello classico?

Per ogni problema, decidere se ha senso usare Deep Learning:

- calcolare IVA;
- riconoscere difetti in immagini industriali;
- classificare email in arrivo;
- prevedere vendite da tabella piccola;
- trascrivere audio;
- riconoscere oggetti in video.

---

== Mini attività 2

=== Quale architettura?

Scegliere tra MLP, CNN, RNN/LSTM, Autoencoder.

- immagini di difetti;
- storico temperature;
- dati tabellari clienti;
- riduzione rumore in immagini;
- sentiment di recensioni;
- anomalie in vibrazioni.

---

== Mini attività 3

=== Disegna il flusso

Caso:

#raw(block: true, lang: "txt", "azienda manifatturiera vuole rilevare difetti con una telecamera")

Disegnare:

- dati in input;
- tipo di modello;
- output;
- controllo umano;
- rischi;
- vantaggio economico.

---

== Mini attività 4

=== Spiega con metafora

Provare a spiegare a un collega non tecnico:

- cos’è un neurone artificiale;
- cos’è un peso;
- cos’è una CNN;
- cos’è una RNN;
- cos’è uno spazio latente.
