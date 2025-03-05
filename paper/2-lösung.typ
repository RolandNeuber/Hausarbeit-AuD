#import "4-literaturverzeichnis.typ": bib_state
#context bib_state.get()

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

Um das Laufzeitverhalten von Algorithmen zu verbessern können oft schnellere Algorithmen zur Nährung verwendet werden. Der Randomized MinCut Algorithmus @kargers_algorithm ist ein entsprechender heuristischer Ansatz für das Problem des minimalen Schnittes. Der Algorithmus ist, wie der Name impliziert, randomisiert und konvergiert stochastisch gegen die optimale Lösung.
Die Idee des Algorithmus ist folgende:
Zunächst wird die kleinste gefundene Kapazität mit $oo$ initialisiert. 

$c_min = oo$

Alle Knoten werden (außer Quelle und Senke) zufällig mit Wahrscheinlichkeit $1/2$ auf zwei Partitionen (Q und S) aufgeteilt, wovon eine die Quelle und die andere die Senke beinhaltet.
Im nächsten Schritt wird die Kapazität zwischen beiden Partitionen bestimmt. Diese entspricht der Summe aller einzelenen Kapazitäten von jedem Knoten in Q zu jedem Knoten in S. 

$c_a = sum c_"ij" | i in Q, j in S$

Ist die gefundene Kapazität kleiner als die zuvor gefundenen Kapazitäten, wird die kleinste gefundenene Kapazität auf den neuen Wert aktualisiert. 

$c_min = min(c_min, c_a)$

Die Mengen Q und S werden ebenfalls in einer Variablen gespeichert. 

($Q_"fin" = Q, S_"fin" = S$)

Die Schritte ab der Partitionierung werden so oft wiederholt bis eine "ausreichend gute" Nährung für den minimalen Schnitt gefunden wurde.
Dabei ist zu beachten, dass die gefundene Lösung in jeder Iteration den minimalen Schnitt/maximalen Fluss von oben annähert, also größer gleich dem tatsächlichen Wert ist.

Der ursprüngliche Algorithmus arbeitet mit einer "Kontraktion" von Kanten. Dabei werden zwei Knoten zu einem zusammengefasst (die Quelle und Senke dürfen nicht zusammengefasst werden), solange bis nur noch zwei Knoten übrig sind. Die Knoten in dem Knoten, in dem auch Quelle zusammengefasst wurde, zusammengefasst sind, entsprechen logisch der Menge Q. Der Rest der Knoten ist Teil der Menge S. 

== Deserialisierung des Flussnetzwerkes
// Explizite Erwähnung von den Dateien dataFNW4.txt oder FNWNodePos.txt. Darlegung, wie die Daten aus diesen Dateien ins Programm integriert wurden.
Die Dateien "dataFNW4.txt" und "FNWNodePos.txt" werden mit Hilfe folgender Python-Funktionen ausgelesen:

```Python
def read_capacity_file() -> tuple[int, list[Connection], int]:
```

Das Auslesen der Datei "dataFNW4.txt" liefert ein Tupel aus dem Index der Quelle, einer Liste der Kanten mit zugehörigem Gewicht und dem Index der Senke.


```Python
def read_position_file() -> list[Node]:
```

Das Auslesen der Datei "FNWNodePos.txt" liefert eine Liste der Knoten mit Koordinaten.
Die Daten werden dabei in den Datenklassen `Node` (dt. Knoten) und `Connection` (dt. Verbindung) gehalten, um später einfach darauf zugreifen zu können.

== Implementierung
Der eigentliche MinCut-Algorithmus ist in der Pythonfunktion `randomized_min_cut` implementiert. Die Funktion nimmt die Liste der Knoten, deren gerichtete Verbindungen, den Index bzw. die Nummer der Quelle und Senke und die Anzahl der Iterationen entgegen. 
Die Funktion gibt den berechneten Wert für den minimalen Schnitt, sowie die Mengen Q und S als Tupel zurück.

```python
def randomized_min_cut(
        nodes: list[Node], 
        connections: list[Connection], 
        source_index: int, 
        drain_index: int, 
        iterations: int
    ) -> tuple[int, set[int], set[int]]:
    ...    
    return (min_capacity, final_source_set, final_drain_set)
```

Die Implementierung in Python entspricht im Wesentlichem dem Pseudocode.
Die Kapazität wird mit $oo$ initialisiert.

```python
min_capacity = math.inf
```

Danach wird eine feste Anzahl an Iterationen durchgeführt.

```python
for _ in range(iterations):
```

Darin werden alle Knoten bis auf Quelle und Senke zufällig auf die Mengen Q und S aufgeteilt.

```python
for node in nodes:
    if random.randint(0, 1) == 0:
        source_set.add(node.index)
    else:
        drain_set.add(node.index)
```

Zwischen den generierten Partitionen wird jeweils die Kapazität berechnet.

```python
capacity = calculate_capacity(source_set, drain_set, connections)
```

Wenn die berechnete Kapazität kleiner ist als alle vorherigen, wird die minimale Kapazität und die zugehörige Partitionierung aktualisiert.

```python
if capacity < min_capacity:
    min_capacity = capacity
    final_source_set = source_set
    final_drain_set = drain_set
```

Nachdem alle Iterationen durchlaufen sind, werden die berechnete Kapazität, Q und S zurückgegeben.

```python
return (min_capacity, final_source_set, final_drain_set)
```

== Berechnung der Kapazität zwischen Partitionen
Die Bestimmung der Kapazität zwischen den zwei zufällig gewählten Partionen Q und S wird in der Funktion `calculate_capacity` durchgeführt.
Diese nimmt die zwei Partionen und die Liste aller (!) Verbindungen des Netzwerkes entgegen. Streng genommen würden die Verbindungen mit Startknoten in Q und Endknoten in S genügen, die Filterung passiert zur Vereinfachung aber erst innerhalb der Funktion selbst.
Am Ende wird die Gesamtkapazität von Q nach S zurückgegeben.

```python
def calculate_capacity(
        source_partition: set[int], 
        drain_partition: set[int], 
        connections: list[Connection]
    ) -> int:
    """Berechnet die Kapazität zwischen zwei Partitionen anhand der gegebenen Verbindungen."""
    total_capacity = 0
    for connection in connections:
        if connection.start_node in source_partition \
        and connection.end_node in drain_partition:
            total_capacity += connection.capacity

    return total_capacity
```

Die Implementierung entspricht wieder im Wesentlichen dem Pseudocode.
Die Kapazität wird mit 0 initialisiert.

```python
total_capacity = 0
```

Danach wird über alle Verbindung des Netzwerkes iteriert.

```python
for connection in connections:
```

Dabei werden nur jene Verbindungen beachtet, die ihren Startknoten in Q und ihren Endknoten in S haben.

```python
if connection.start_node in source_partition \
        and connection.end_node in drain_partition:
```

Für all diese Verbindungen wird die Kapazität auf die Gesamtkapazität aufaddiert.

```python
total_capacity += connection.capacity
```

Und am Ende wird die Gesamtkapazität zurückgegeben.

```python
return total_capacity
```

== Ausgabe des Programms
Bei der Programmausführung kann es aufgrund der zufälligen Natur des _Randomized_ MinCut-Algorithmus zu unterschiedlichen Ergebnissen kommen. Während des Testens sind bspw. die folgenden zwei (optimalen) Partionierungen berechnet worden.

`
Randomized MinCut-Ergebnis (1000 Iterationen): 
MinCut-Wert: 34 
Menge Q: {0, 5} 
Menge S: {1, 2, 3, 4, 6, 7, 8, 9} 
`

#figure(
  image("/paper/Graph_0_5.png", width: 50%),
  caption: [
    Mögliche Partionierung mit Knoten 0 (Quelle) und 5 in Q.
  ],
)

`
Randomized MinCut-Ergebnis (1000 Iterationen): 
MinCut-Wert: 34
Menge Q: {0, 2, 5}
Menge S: {1, 3, 4, 6, 7, 8, 9}
`

#figure(
  image("/paper/Graph_0_2_5.png", width: 50%),
  caption: [
    Mögliche Partionierung mit Knoten 0, 2 und 5 in Q.
  ],
)

Welche der Partionierungen dabei zurückgegeben wird, ist vom Zufall abhängig. Es ist ebenfalls möglich, dass eine suboptimale Lösung zurückgegeben wird. Um die Wahrscheinlichkeit für suboptimale Lösungen zu verringern, kann die Anzahl der Iterationen erhöht werden. Allerdings kann nicht garantiert werden, dass eine optimale Lösung gefunden wird.

== Verifikation der Ergebnisse

Zur Verifikation der Ergebnisse wurde die Programmbibliotek `NetworkX` genutzt.
Diese stellt die Funktion `minimum_cut`, die den minimalen Schnitt deterministisch mit dem Algorithmus "preflow push" berechnet. @networkx_mincut_doc
`
Verifikation mit NetworkX: 
MinCut-Wert: 34
Menge Q: {0, 2, 5}
Menge S: {1, 3, 4, 6, 7, 8, 9}
`

Entsprechend liefert NetworkX auch nur eine der möglichen optimalen Lösungen zurück. Da der Wert des minimalen Schnittes von NetworkX mit dem der eigenen Implementierung übereinstimmt, kann diese nicht falsifiziert werden. Die Übereinstimmung legt zwar nahe, dass die Implementierung korrekt ist, ist aber kein Beweis.