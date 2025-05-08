
# README – Blatt 03 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)


## Aufgabe 01

Die Aufgabe kann aufgerufen werden mit `aufg01(N,M,m)`, wobei $N$ die Anzahl an Punkten ist, in der das Intervall diskretisiert wird, $M$ die Anzahl an Subintervallen und $m§ der Grad der Lagrangepolynome auf den Subintervallen ist.

Die stückweise Lagrange-Interpolation der Runge-Funktion $𝑓(𝑥) = \frac{1}{1+25𝑥^2}$ zeigt, dass durch die lokale Anwendung niedriggradiger Polynome (z. B. Grad 3) in mehreren Teilintervallen (z. B. $𝑀=5$) das klassische Runge-Phänomen deutlich reduziert werden kann. Im Gegensatz zur globalen Interpolation mit äquidistanten Punkten, die zu starken Schwingungen an den Rändern führt, liefert die stückweise Methode eine stabilere und genauere Approximation. Die Interpolation folgt dem Verlauf der Runge-Funktion gut, insbesondere im Intervallinneren. Insgesamt ist die stückweise Lagrange-Interpolation eine effektive Methode zur Interpolation schwieriger Funktionen.

---

## Aufgabe 02

Wenn man die Plots mit unterschiedlichen Werten für N (Anzahl der Stützpunkte) und M (Verhältnis von Gitterpunkten) betrachtet, zeigt sich ein interessantes Verhalten. Zunächst, bei kleinerem N, ist die lineare Spline-Interpolation weniger präzise und der Fehler zwischen der Approximation und der tatsächlichen Runge-Funktion ist größer, besonders in den Randbereichen des Intervalls. Mit zunehmendem N werden mehr Gitterpunkte eingeführt, was zu einer genaueren Annäherung an die Funktion führt und den Fehler insgesamt verringert. Allerdings zeigt sich bei sehr hohen Werten von N möglicherweise das "Runge-Phänomen", bei dem die Fehler in den Randbereichen wieder steigen, da die linearen Splines nicht in der Lage sind, die schnell wechselnden Funktionswerte genau zu approximieren. Das Verhältnis M beeinflusst die Dichte der Gitterpunkte und hat direkten Einfluss auf die Qualität der Approximation: Ein kleineres M führt zu feineren Gitterpunkten und einer besseren Approximation, während ein größeres M zu einer weniger präzisen Interpolation führen kann. Die Fehleranalyse bei verschiedenen N- und M-Werten macht deutlich, dass eine feinere Gitterung die Genauigkeit verbessert, jedoch die Wahl der Interpolationsmethode für die besten Ergebnisse entscheidend ist.

---

## Aufgabe 03

Das aktuelle Vorgehen im Code, insbesondere die Verwendung der polynomialen Interpolation mittels Vandermonde-Matrix, ist aufgrund der numerischen Instabilität bei höheren Gitterpunkten und der schlechten Fehlerentwicklung für Funktionen wie $sin(πx)$ und $∣x∣$ nicht optimal. Die Methode führt zu Verzerrungen in den Berechnungen und steigert den Fehler bei höheren N-Werten, was als "Runge'sches Phänomen" bekannt ist. 

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