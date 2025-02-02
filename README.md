# TEST TECNICO QUADRONICA FANTACALCIO 

## Dettagli Tecnici dell'App

• SwiftUI

• SwiftData 

• AppStorage


L'App usa **SwiftUI** come framework UI, e **Swiftdata** come framework per **persistere** dati localmente.

Utilizza **AppStorage** per salvare l'indice degli sponsor da mostrare, in modo tale che il ciclo riprenda dall'ultimo sponsor visto.
Questo si puó notare nelle View principali nelle funzioni `updateSponsor()`.

## Architettura

• MVVM

• Suddivisione del codice in cartelle

• Estensioni & Helpers

• ViewModifiers


Ho utilizzato il design pattern: **MVVM** (Model View ViewModel).

La struttura dell'app é suddivisa in **molteplici cartelle** e **files** per distinguere e rendere il tutto piú chiaro.

Ho creato una cartella API con "custom" **enum APIError** in comune e le varie chiamate per i giocatori e sponsor.

Ho deciso di utilizzare per la maggior parte `.hAlign()` e `.vAlign()` per non abusare di "Spacer()".

Ho usato gli `static let` nella `struct Endpoints` per avere tutto sotto controllo e in maniera piú ordinata e chiara possibile.
Ho usato `fileprivate struct` per non raggruppare troppo codice insieme e distinguere il tutto.

I `ViewModifiers` li ho creati per non riscrivere piú volte lo stesso codice style.

## Dipendende Esterne

• Kingfisher

Ho utilizzato **Kingfisher**, che secondo la mia opinione é piú ottimale della built-in function AsyncImage
Nel codice si vedrá anche un articolo che ho condiviso che spiega la differenza tra i due
[Kingfisher License](https://github.com/onevcat/Kingfisher/blob/master/LICENSE)

## Leggere e vedere i commenti nel codice per capire e comprendere al meglio tutto il processo.

