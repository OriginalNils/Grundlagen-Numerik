
# README – Blatt 01 Numerik

## Aufgabe 01

Die Operatornormen wurden jeweils mit den Funktionen `norm_1`, `norm_inf`, `norm_f` implementiert. Diese sind im blatt01.jl File zu finden unter der Funktion `aufg01`. Die Matrix H wird mit Hilfe der Funktion `matrix_h` implementiert und ist auch unter der Funktion `aufg01` zu finden. Durch ausführen der Funktion `aufg01` wird eine Tabelle in Julia geprintet, in der die Werte der 3 Normen der Matrix H zu finden ist. 

Die Berechnungen der Normen der Hilbert-Matrix zeigen, dass mit zunehmendem n alle Normen steigen. Dies ist ein erwartetes Verhalten, da die Hilbert-Matrix für größere n immer mehr nicht-null Einträge hat, die die Summen in den verschiedenen Normen erhöhen.
Die 1-Norm und ∞-Norm wachsen ähnlich, wobei die 1-Norm tendenziell etwas schneller ansteigt. Dies liegt daran, dass die Spaltensummen in der H-Matrix bei wachsendem 𝑛 schneller zunehmen als die Zeilensummen. Die F-Norm wächst hingegen langsamer, da sie die quadratischen Beiträge der Matrixeinträge berücksichtigt und somit weniger empfindlich auf einzelne große Werte reagiert.

---

## Aufgabe 02

---

## Aufgabe 03

Alle Teilaufgaben wurden in der Funktion `aufg03()` verankert und werden durch ausführen dieser Funktion ausgeführt. Die Plots werden alle in dem `output` Ordner gespeichert und können dort eingesehen werden.

Zu vii: Man kann die Ordnung des Fehlers im log-log-Plot ablesen, in dem man die Steigung betrachtet. In den Plots ist die Steigung in der Legende zu sehen. Man erkennt, dass wie in der Vorlesung und im Übungsblatt errechnet wurde, dass zentralen Differenzen eine Fehler von O(h^2) haben und Vorwärts und Rückwärts Differenzen eine Fehler von O(h) haben.

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Printf` (für formatierte Ausgaben)
  - `Plots` (für Diagramme)

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