
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Aufgabe kann aufgerufen werden mit `aufg01(N,M,m)`, wobei $N$ die Anzahl an Punkten ist, in der das Intervall diskretisiert wird, $M$ die Anzahl an Subintervallen und $m§ der Grad der Lagrangepolynome auf den Subintervallen ist.

Die stückweise Lagrange-Interpolation der Runge-Funktion $𝑓(𝑥) = \frac{1}{1+25𝑥^2}$ zeigt, dass durch die lokale Anwendung niedriggradiger Polynome (z. B. Grad 3) in mehreren Teilintervallen (z. B. $𝑀=5$) das klassische Runge-Phänomen deutlich reduziert werden kann. Im Gegensatz zur globalen Interpolation mit äquidistanten Punkten, die zu starken Schwingungen an den Rändern führt, liefert die stückweise Methode eine stabilere und genauere Approximation. Die Interpolation folgt dem Verlauf der Runge-Funktion gut, insbesondere im Intervallinneren. Insgesamt ist die stückweise Lagrange-Interpolation eine effektive Methode zur Interpolation schwieriger Funktionen.

---

## Aufgabe 02

---

## Aufgabe 03

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Printf` (für formatierte Ausgaben)
  - `PrettyTables` (für Tabellen)
  - `LinearAlgebra` (für Determinanten)
  - `Statistics` (Durchschnitt berechnen)
  - `BenchmarkTools` (Zeitmessung)
  
---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden:

```
include("blatt03.jl")
```
3. Der Code der jeweiligen Aufgaben kann jeweils mit folgenden Befehl ausgeführt werden, wobei für x die jeweilige Aufgaben Nummer genutzt werden muss.
```
aufg0x()
```