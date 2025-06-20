
# README – Blatt 08 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)

## Aufgabe 01



---

## Aufgabe 02

Die Ergebnisse zeigen, dass bei allen getesteten Matrizen- und Vektorgrößen der Fehler der Vorwärtssubstitution mit Zeilen- und Spaltenorientierung praktisch null ist, was darauf hindeutet, dass beide Implementierungen numerisch korrekt arbeiten und die exakte Lösung des Gleichungssystems liefern. Hinsichtlich der Laufzeit ist die Version mit spaltenorientierter Substitution durchweg schneller als die zeilenorientierte Variante, und dieser Unterschied wird mit wachsendem Problemumfang immer deutlicher. Insgesamt bestätigen die Resultate die numerische Stabilität beider Methoden, während die spaltenorientierte Implementierung vor allem für größere Dimensionen aus Performance-Sicht zu bevorzugen ist.

---

## Aufgabe 03

Die Ergebnisse zeigen, dass die Fehler bei der Lösung des Gleichungssystems mit zunehmender Matrixgröße stark anwachsen – sowohl ohne Pivotisierung als auch mit vollständiger Pivotisierung. Überraschenderweise ist der Fehler bei vollständiger Pivotisierung deutlich größer als ohne Pivotisierung, obwohl man normalerweise erwartet, dass Pivotstrategien die numerische Stabilität verbessern. Dies liegt wahrscheinlich an der speziellen Struktur der Matrix, bei der die vollständige Pivotisierung dazu führt, dass sehr kleine Pivot-Elemente gewählt werden, was die Fehleranfälligkeit erhöht. Insgesamt verdeutlichen die Resultate, dass eine Pivotstrategie nicht immer vorteilhaft ist und vom konkreten Problem abhängt.

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Plots` (für Plots)
  - `LinearAlgebra`
  - `PrettyTables` (Tabellen)
  - `BenchmarkTools` (Zeitmessung)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```