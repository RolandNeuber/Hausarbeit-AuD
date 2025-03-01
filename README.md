# Flussnetzwerk und der MaxFlow - MinCut Zusammenhang
## Programmbedienung
Das Program wurde getestet in der Pythonversion 3.12.3, sollte aber auch in anderen Versionen >3.12 funktionieren.
Zur Ausführung kann folgender Shell-Befehl genutzt werden. Vorraussetzung ist, dass Python unter der Bezeichnung `python3` verfügbar ist. Alternativ ist Python häufig auch als `python` verfügbar.
```bash
python3 src/main.py
```
Außerdem kann das Programm auch mit Kommandozeilenargument aufgerufen werden:
```bash
python3 src/main.py 350
```
Das obige Beispiel führt den Randomized MinCut-Algorithmus mit `350` Iterationen aus. Wird das Argument weggelassen, wird ein Standardwert von `1000` gewählt.

## Programmausgabe
Das Programm gibt in der Konsole das Ergebnis des Algorithmus, bestehend aus dem minimalen Schnitt und den Mengen Q und S, zurück.
Zur Verifikation wird der minimale Schnitt zusätzlich mit der Bibliothek NetworkX berechnet.
Das Netzwerk zusammen mit den berechneten Mengen Q und S wird mit Hilfe von Matplotlib dargestellt.