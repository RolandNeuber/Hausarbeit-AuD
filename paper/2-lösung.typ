= Randomized MinCut Algorithmus
== Theoretischer Algorithmus
// Das Finden eines minimalen Schnittes gehörtzu den NP-vollständigen Problemen. Für größere Probleme sind deshalb heuristische Ansätze sinnvoll.
// Eine Variante ist der Randomized MinCut Ansatz.
// • cmin = ∞
// • Iteriere k-mal
// – Q = {q}, S = {s}
// – Die restlichen Vertizes qi werden gleichm¨aßig mit einer Wk p = 1
// 2
// auf Q oder S aufgeteilt
// – Berechne die Summe der Kapazit¨aten ca = ∑ cij mit i ∈ Q und
// j ∈ S
// – Wenn ca < cmin dann setze
// cmin = ca und Qf in = Q, Sf in = S
// F¨ur das obige Beispiel findet der Algorithmus folgende L¨osung. Die Ver-
// tices aus Q werden mit rot eingef¨arbt, die zu S geh¨origen sind ockerfarben.
// Der MinCut Wert (also der maximale Fluss) ist 9, also OK!

Da das Finden zu den NP-vollständigen Problemen gehört (Quelle!), bietet sich eine heuristische Lösung an. Der Randomized MinCut Algorithmus ist ein entsprechender heuristischer Ansatz. Der Algorithmus ist, wie der Name impliziert, randomisiert und konvergiert stochastisch gegen die optimale Lösung.
Die Idee des Algorithmus ist folgende:
Zunächst wird die kleinste gefundene Kapazität mit (Unendlich) initialisiert.
Alle Knoten werden (außer Quelle und Senke) zufällig mit Wahrscheinlichkeit 1/2 auf zwei Partitionen (Q und S) aufgeteilt, wovon eine die Quelle und die andere die Senke beinhaltet.
Im nächsten Schritt wird die Kapazität zwischen beiden Partitionen bestimmt. Diese entspricht der Summe aller einzelenen Kapazitäten von jedem Knoten in Q zu jedem Knoten in S (Formel angeben).
Ist die gefundene Kapazität kleiner als die zuvor gefundenen Kapazitäten, wird die kleinste gefundenene Kapazität auf den neuen Wert aktualisiert. Die Mengen Q und S werden ebenfalls in einer Variablen gespeichert.
Die Schritte ab der Partitionierung werden so oft wiederholt bis eine "ausreichend gute" Nährung für den minimalen Schnitt gefunden wurde.
Dabei ist zu beachten, dass die gefundene Lösung in jeder Iteration den minimalen Schnitt/maximalen Fluss von oben annähert, also größer gleich dem tatsächlichen Wert ist.

== Implementierung