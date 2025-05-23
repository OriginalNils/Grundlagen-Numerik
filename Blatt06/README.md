
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Ergebnisse zeigen, dass sowohl die Simpson- als auch die Boole-Quadraturregel bei glatten Funktionen wie f(x)=exp(x) und h(x)=cos(x) sehr gut konvergieren, wobei die Boole-Regel eine deutlich höhere Genauigkeit erreicht – bereits bei moderaten N liegen die Fehler im Bereich der Maschinengenauigkeit. Bei der nicht glatt differenzierbaren Funktion g(x)=∣x∣ hingegen schneidet die Simpson-Regel besser ab, da sie robuster gegenüber Unstetigkeiten im Differentialverhalten ist. Insgesamt lässt sich sagen, dass für glatte Funktionen die Boole-Regel durch ihre höhere Konvergenzordnung vorzuziehen ist, während bei nicht-glatten Funktionen die Simpson-Regel stabilere Ergebnisse liefert.

---

## Aufgabe 02


---

## Aufgabe 03


---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `LinearAlgebra` (für Determinanten)
  - `Plots` (für Plots)
  - `DelimitedFiles` (einlesen von Dateien)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```