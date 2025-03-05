#import "4-literaturverzeichnis.typ": bib_state
#context bib_state.get()

// TODO
// Vorteile und Nachteile des Algorithmus im Vergleich zu deterministischen Methoden
// Explizite Erwähnung von den Dateien dataFNW4.txt oder FNWNodePos.txt. Darlegung, wie die Daten aus diesen Dateien ins Programm integriert wurden.
// Mehr akademische Quellen oder weitere Vergleiche zu deterministischen Algorithmen eingebracht werden.

= Problemstellung
// 1. Charakterisieren Sie kurz das Problem des maximalen Flusses und des minimalen Schnittes.
Das Problem des maximalen und des minimalen Schnittes beschäftigt sich mit dem maximalen Fluss in Flussnetzwerken von einer Quelle zu einer Senke. Das Theorem besagt, dass die Kapazität des maximalen Flusses der Kapazität eines minimalen Schnittes entspricht.
Intuitiv kann man sich vorstellen, dass in einem Flussnetzwerk eine Engstelle den maximalen Fluss beschränkt. Die Engstelle, die den Fluss am stärksten einschränkt, bestimmt dessen Kapazität.
// Schreiben Sie ein Programm, welches den minimalen Cut des gegebenen FNW bestimmt. Verwenden Sie den Randomized MinCut Algorithmus aus der Vorlesung.
Aufgabe dieser Arbeit ist die Bestimmung des minimalen Schnittes mit Hilfe des Randomized MinCut Algorithmus. Der Algorithmus ist in der Programmiersprache Python implementiert. Zusätzlich werden die Programmbiblioteken NetworkX @networkx zur Verifizierung des minimalen Schnittes und Matplotlib @matplotlib zur Darstellung des Netzwerkes genutzt.