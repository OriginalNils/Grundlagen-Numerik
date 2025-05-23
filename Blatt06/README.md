
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Ergebnisse zeigen, dass sowohl die Simpson- als auch die Boole-Quadraturregel bei glatten Funktionen wie f(x)=exp(x) und h(x)=cos(x) sehr gut konvergieren, wobei die Boole-Regel eine deutlich höhere Genauigkeit erreicht – bereits bei moderaten N liegen die Fehler im Bereich der Maschinengenauigkeit. Bei der nicht glatt differenzierbaren Funktion g(x)=∣x∣ hingegen schneidet die Simpson-Regel besser ab, da sie robuster gegenüber Unstetigkeiten im Differentialverhalten ist. Insgesamt lässt sich sagen, dass für glatte Funktionen die Boole-Regel durch ihre höhere Konvergenzordnung vorzuziehen ist, während bei nicht-glatten Funktionen die Simpson-Regel stabilere Ergebnisse liefert.

---

## Aufgabe 02

Die Linearisierung ist sinnvoll verwendbar für Anfangsauslenkungen bis ungefährt 22°.

Die Ergebnisse zeigen das Konvergenzverhalten der AGM-Methode im Vergleich zur numerischen Integration mittels Trapez- und Simpsonregel für verschiedene Anfangsauslenkungen φ_0. Bei kleinen Auslenkungen, etwa φ_0​=0,01, werden bereits mit wenigen Iterationen sehr geringe Fehler erreicht, was auf eine schnelle Annäherung an den Referenzwert hindeutet. Auch bei mittleren Auslenkungen, beispielsweise um φ_0 =0,9, nimmt der Fehler mit zunehmender Iterationszahl deutlich ab und erreicht ab etwa sechs Iterationen einen Wert im Bereich der numerischen Genauigkeit. Bei größeren Auslenkungen, insbesondere in der Nähe von π, steigt der Fehler zunächst an, verringert sich jedoch mit höheren Iterationszahlen ebenfalls deutlich. Auffällig ist, dass die Trapezregel bei großen Auslenkungen eine geringere Abweichung zur AGM-Methode zeigt als die Simpsonregel, bei der in einigen Fällen höhere Fehler auftreten. Insgesamt deuten die Ergebnisse darauf hin, dass die AGM-Methode mit einer geringen Anzahl an Iterationen eine hohe Genauigkeit liefert, wobei die Abweichung zwischen den Methoden bei großen Auslenkungen stärker ausgeprägt ist.

---

## Aufgabe 03


---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `LinearAlgebra` (für Determinanten)
  - `Plots` (für Plots)
  - `PrettyTables` (für Tabellen)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```