#import "4-literaturverzeichnis.typ": bib_state
#context bib_state.get()

= Problemstellung
// 1. Charakterisieren Sie kurz das Problem des maximalen Flusses und des minimalen Schnittes.
Das Problem des maximalen und des minimalen Schnittes beschäftigt sich mit dem maximalen Fluss in Flussnetzwerken von einer Quelle zu einer Senke. Das Theorem besagt, dass die Kapazität des maximalen Flusses der Kapazität eines minimalen Schnittes entspricht.
Intuitiv kann man sich vorstellen, dass in einem Flussnetzwerk eine Engstelle den maximalen Fluss beschränkt. Die Engstelle, die den Fluss am stärksten einschränkt, bestimmt dessen Kapazität.
// Schreiben Sie ein Programm, welches den minimalen Cut des gegebenen FNW bestimmt. Verwenden Sie den Randomized MinCut Algorithmus aus der Vorlesung.
Aufgabe dieser Arbeit ist die Bestimmung des minimalen Schnittes mit Hilfe des Randomized MinCut Algorithmus. Der Algorithmus ist in der Programmiersprache Python implementiert. Zusätzlich werden die Programmbiblioteken NetworkX @networkx zur Verifizierung des minimalen Schnittes und Matplotlib @matplotlib zur Darstellung des Netzwerkes genutzt.

Der gerichtete Graph ist in zwei Dateien kodiert. 

Die Datei "dataFNW4.txt" enthält die Kanten in der Form $u_i" "u_j" "c(u_i, u_j)$ (Hinweis: $c(u_i, u_j) != c(u_j, u_i)$ im Allgemeinen). 

Die Datei "FNWNodePos.txt" beinhaltet die Koordinaten der Knoten in der Form $u" "x_u" "y_u$. Der Knoten mit Index 0 ist die Quelle, der Knoten mit dem höchsten Index ist die Senke.

// TODO
// Vorteile und Nachteile des Algorithmus im Vergleich zu deterministischen Methoden
// Mehr akademische Quellen oder weitere Vergleiche zu deterministischen Algorithmen eingebracht werden.