
# README – Blatt 07 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Für x0 = 1 und x0 = 0 ist immer der nächste Wert entweder 0 oder 1, also schwingt zwischen diesen beiden Werten hin und her und kann damit gar nicht die Nullstelle erreichen. 

---

## Aufgabe 02

v) Das Newton-Verfahren ist in der Praxis effizient, wenn gute Startwerte bekannt sind und das Polynom einfache Nullstellen besitzt. Es konvergiert schnell (quadratisch), ist aber empfindlich gegenüber mehrfachen Nullstellen oder schlechten Startwerten, was zu numerischen Problemen wie Division durch Null führen kann. Die Methode der Begleitmatrix hingegen benötigt keine Startwerte und liefert alle Nullstellen (auch komplexe) auf einmal durch Eigenwertberechnung.

vi) Die Methode der Begleitmatrix setzt voraus, dass das Polynom in der Monombasis gegeben ist. Orthogonale Polynome wie Legendre-, Chebyshev- oder Hermite-Polynome sind jedoch meist rekursiv definiert oder in einer speziellen Basis dargestellt, wodurch eine Umrechnung in die Monombasis numerisch instabil oder unpraktisch wird. Zudem geht bei der Anwendung der Begleitmatrix die spezielle Struktur der orthogonalen Polynome verloren.

---

## Aufgabe 03


---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Plots` (für Plots)
  - `LinearAlgebra`
  - `PrettyTables` (Tabellen)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden und auszuführen. Wobei jeweils `x` mit der jeweiligen Aufgaben Nummer ersetzt werden muss:

```
include("aufg0x.jl")
```