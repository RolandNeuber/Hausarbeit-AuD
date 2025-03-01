= Literaturverzeichnis
// http://people.csail.mit.edu/karger/Papers/mincut.ps (Originaler Algorithmus)
// https://networkx.org/documentation/stable/reference/algorithms/generated/networkx.algorithms.flow.minimum_cut.html (mincut preflow push)

#let bib_state = state("bib_state", bibliography("bibliography.yml", title: none))
#bibliography("bibliography.yml", title: none)