
# Blatt 01 Numerik - Nils Döring (2783749) und Dominik Schwarzmeier (2784721)

## Aufgabe 01

Die Operatornormen wurden jeweils mit den Funktionen `norm_1`, `norm_inf`, `norm_f` implementiert. Diese sind im blatt01.jl File zu finden unter der Funktion `aufg01`. Die Matrix H wird mit Hilfe der Funktion `matrix_h` implementiert und ist auch unter der Funktion `aufg01` zu finden. Durch ausführen der Funktion `aufg01` wird eine Tabelle in Julia geprintet, in der die Werte der 3 Normen der Matrix H zu finden ist. 

Die Berechnungen der Normen der Hilbert-Matrix zeigen, dass mit zunehmendem n alle Normen steigen. Dies ist ein erwartetes Verhalten, da die Hilbert-Matrix für größere n immer mehr nicht-null Einträge hat, die die Summen in den verschiedenen Normen erhöhen.
Die 1-Norm und ∞-Norm wachsen ähnlich, wobei die 1-Norm tendenziell etwas schneller ansteigt. Dies liegt daran, dass die Spaltensummen in der H-Matrix bei wachsendem 𝑛 schneller zunehmen als die Zeilensummen. Die F-Norm wächst hingegen langsamer, da sie die quadratischen Beiträge der Matrixeinträge berücksichtigt und somit weniger empfindlich auf einzelne große Werte reagiert.

---

## Aufgabe 02

Durch ausführen von `aufg02(S)` wird eine Tabelle zurückgegeben für gegebenes S. Man kann beobachten das die Folge recht schnell gegen Wurzel S konvergiert, denn bereits nach 5 Schritten sind alle Testwerte bereits im Bereich von 10^-2. Außerdem fällt auf, dass mit Startwerten nahe Wurzel S konvergieren offensichtlich schneller. Außerdem erkennt man eine Symmetrie zwischen 0.5 und 1 als Startwert. Nach 10 Schritten sind bereits alle Startwerte nahe Maschinengenauigkeit an Wurzel S heran, also 10^-16.

---

## Aufgabe 03

Alle Teilaufgaben wurden in der Funktion `aufg03(N)` verankert und werden durch ausführen dieser Funktion ausgeführt, wobei ein N gegeben werden muss, also die Anzahl an Unterteilung des Intervalls. Die Plots werden alle in dem `output` Ordner gespeichert und können dort eingesehen werden.

Zu vii: Man kann die Ordnung des Fehlers im log-log-Plot ablesen, in dem man die Steigung betrachtet. In den Plots ist die Steigung in der Legende zu sehen. Man erkennt, dass wie in der Vorlesung und im Übungsblatt errechnet wurde, dass zentralen Differenzen eine Fehler von O(h^2) haben und Vorwärts und Rückwärts Differenzen eine Fehler von O(h) haben.

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Printf` (für formatierte Ausgaben)
  - `Plots` (für Diagramme)
  - `PrettyTables` (für Tabellen)

---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden:

```
include("blatt01.jl")
```
3. Der Code der jeweiligen Aufgaben kann jeweils mit folgenden Befehl ausgeführt werden, wobei für x die jeweilige Aufgaben Nummer genutzt werden muss.
```
aufg0x()
```