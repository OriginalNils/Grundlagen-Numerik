
# README – Blatt 06 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Ergebnisse zeigen, dass sowohl die Simpson- als auch die Boole-Quadraturregel bei glatten Funktionen wie f(x)=exp(x) und h(x)=cos(x) sehr gut konvergieren, wobei die Boole-Regel eine deutlich höhere Genauigkeit erreicht – bereits bei moderaten N liegen die Fehler im Bereich der Maschinengenauigkeit. Bei der nicht glatt differenzierbaren Funktion g(x)=∣x∣ hingegen schneidet die Simpson-Regel besser ab, da sie robuster gegenüber Unstetigkeiten im Differentialverhalten ist. Insgesamt lässt sich sagen, dass für glatte Funktionen die Boole-Regel durch ihre höhere Konvergenzordnung vorzuziehen ist, während bei nicht-glatten Funktionen die Simpson-Regel stabilere Ergebnisse liefert.

---

## Aufgabe 02

Die Linearisierung ist sinnvoll verwendbar für Anfangsauslenkungen bis ungefährt +-22°.

Schon bei ungefährt 5 Iterationen des AGM ist der Fehler zwischen den Quadraturen und des AGM in nähe 10^-16, also sehr genau.

---

## Aufgabe 03

Das numerische Verfahren zeigt bei kleinen Gitterpunktzahlen (für N<10) deutliche Abweichungen von der exakten Lösung, konvergiert aber mit zunehmender Verfeinerung des Gitters sichtbar gegen die analytische Lösung. Eine mögliche Verbesserung wäre der Einsatz eines Newton-Verfahrens für die Iteration, was die Konvergenzgeschwindigkeit erhöhen könnte.

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Plots` (für Plots)
  - `PrettyTables` (für Tabellen)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```