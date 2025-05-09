
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Plots zeigen, dass die kubische Spline-Interpolation bei der Funktion cos(exp(x)) auf dem Intervall [-1, 1] sehr gut funktioniert, da diese Funktion einfach monoton fällt, was eine relativ einfache Form für die Interpolation darstellt. Die Spline-Kurve wird die Funktion ohne große Probleme genau abbilden, da sie keine schnellen Oszillationen oder drastischen Änderungen im Verhalten aufweist. Bei der Funktion sin(2πx) jedoch, die auf dem Intervall [-1, 1] schnell oszilliert, wird die Spline-Interpolation Schwierigkeiten haben, die schnellen Schwankungen exakt zu treffen. Die Spline-Kurve wird zwar immer noch durch alle Stützstellen verlaufen, aber die schnelle Oszillation führt zu einer weniger genauen Annäherung im Vergleich zur cos(exp(x))-Funktion, da die Spline-Kurve zwischen den Stützstellen glatter ist und daher nicht die schnellen Schwankungen der Sinuswelle perfekt erfasst.

---

## Aufgabe 02



---

## Aufgabe 03



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