
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Plots zeigen, dass die kubische Spline-Interpolation bei der Funktion cos(exp(x)) auf dem Intervall [-1, 1] sehr gut funktioniert, da diese Funktion einfach monoton fällt, was eine relativ einfache Form für die Interpolation darstellt. Die Spline-Kurve wird die Funktion ohne große Probleme genau abbilden, da sie keine schnellen Oszillationen oder drastischen Änderungen im Verhalten aufweist. Bei der Funktion sin(2πx) jedoch, die auf dem Intervall [-1, 1] schnell oszilliert, wird die Spline-Interpolation Schwierigkeiten haben, die schnellen Schwankungen exakt zu treffen. Die Spline-Kurve wird zwar immer noch durch alle Stützstellen verlaufen, aber die schnelle Oszillation führt zu einer weniger genauen Annäherung im Vergleich zur cos(exp(x))-Funktion, da die Spline-Kurve zwischen den Stützstellen glatter ist und daher nicht die schnellen Schwankungen der Sinuswelle perfekt erfasst.

---

## Aufgabe 02

Nichts zu übergeben.

---

## Aufgabe 03

Das entwickelte Verfahren zur Bestimmung der Nullstellen der Legendrepolynome mittels der Bisektionsmethode ist stabil und garantiert eine Nullstellenbestimmung, da es auf dem Zwischenwertsatz basiert. Es ist für kleinere Polynomgrade und moderate Genauigkeit effizient, aber aufgrund der linearen Konvergenz relativ langsam, insbesondere bei hohen Polynomgraden oder sehr kleinen Toleranzen. Die Methode benötigt viele Iterationen, was sie bei größeren n oder hohen Präzisionsanforderungen ineffizient macht. Insgesamt ist die Bisektionsmethode für einfache Aufgaben geeignet, aber für komplexere Anwendungen mit größeren Polynomgraden oder strengen Genauigkeitsanforderungen sind effizientere Methoden zu bevorzugen.

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `PrettyTables` (für Tabellen)
  - `LinearAlgebra` (für Determinanten)
  - `Plots` (Für Plots)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```