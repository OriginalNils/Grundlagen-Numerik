
# README – Blatt 01 Numerik

## Aufgabe 01

Die Operatornormen wurden jeweils mit den Funktionen `norm_1`, `norm_inf`, `norm_f` implementiert. Diese sind im blatt01.jl File zu finden unter der Funktion `aufg01`. Die Matrix H wird mit Hilfe der Funktion `matrix_h` implementiert und ist auch unter der Funktion `aufg01` zu finden. Durch ausführen der Funktion `aufg01` wird eine Tabelle in Julia geprintet, in der die Werte der 3 Normen der Matrix H zu finden ist. 

Die Berechnungen der Normen der Hilbert-Matrix zeigen, dass mit zunehmendem n alle Normen steigen. Dies ist ein erwartetes Verhalten, da die Hilbert-Matrix für größere n immer mehr nicht-null Einträge hat, die die Summen in den verschiedenen Normen erhöhen.
Die 1-Norm und ∞-Norm wachsen ähnlich, wobei die 1-Norm tendenziell etwas schneller ansteigt. Dies liegt daran, dass die Spaltensummen in der H-Matrix bei wachsendem 𝑛 schneller zunehmen als die Zeilensummen. Die F-Norm wächst hingegen langsamer, da sie die quadratischen Beiträge der Matrixeinträge berücksichtigt und somit weniger empfindlich auf einzelne große Werte reagiert.

---

## Aufgabe 02

---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Printf` (für formatierte Ausgaben)

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