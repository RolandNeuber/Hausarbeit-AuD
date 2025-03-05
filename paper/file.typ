#set page(numbering: "1")
#set par(leading: 1.20em)
#set block(spacing: 1.20em)
#set text(size: 12pt, lang: "de")

#align(center)[
    #text(17pt)[
        *Roland Neuber*
    ]
    
    Duale Hochschule Sachsen \
    Staatliche Studienakademie Leipzig \
    Studiengang Informatik CS23-2 

    #v(10%)

    Hausarbeit im Fach Datenstrukturen und Algorithmen\

    #text(17pt)[
        *Flussnetzwerk und der MaxFlow – MinCut Zusammenhang*
    ]
]

// #grid(
//     columns: (1fr, 1fr),
//     [
//         Eingereicht von:
//     ],
//     [
//         Roland Neuber \
//         Georg-Schumann-Straße 373, 04159 Leipzig \
//         CS23-2 \
//         5002433 \
//     ]
// )

#let today = datetime.today()
#align(bottom + right)[Leipzig, den #today.display("[day].[month].[year]")]

#pagebreak()
#set heading(numbering: "1.1")

#outline(title: "Inhaltsverzeichnis")

#pagebreak()

#import "4-literaturverzeichnis.typ": bib_state
#bib_state.update(none)

#include "1-problemstellung.typ"
#include "2-lösung.typ"
// Randomized MinCut Algorithmus 
#include "3-programmbedienung.typ"

#pagebreak()

// Implementierung des Algorithmus/Lösung des Problems
#include "4-literaturverzeichnis.typ"

// #pagebreak()
// #counter(page).update(1)
// #set page(numbering: "I")

#pagebreak()

#include "5-selbstständigkeitserklärung.typ"