
# README – Blatt 08 Numerik Nils Döring (2783749) und Dominik Schwarzmeier (2784721)

## Aufgabe 01

Die Ergebnisse zeigen, dass die explizite Formel für die Inverse der Hilbertmatrix sehr präzise ist: Selbst bei n=30 bleibt der Fehler mit 10^-36 extrem klein. Der Fehler wächst mit n, bleibt aber in einem Bereich, der die hohe Genauigkeit der analytischen Inverse unterstreicht – trotz der schlechten Konditionierung der Hilbertmatrix.

Die Tabelle zeigt, dass alle Methoden für kleine n nahezu identische Konditionszahlen liefern. Ab n=20 jedoch weicht die Float64-Methode stark ab und unterschätzt die Konditionszahl deutlich. Dies verdeutlicht, dass einfache numerische Inversion bei schlecht konditionierten Matrizen wie der Hilbertmatrix schnell an Genauigkeitsgrenzen stößt. Nur mit BigFloat oder der exakten analytischen Inversen lassen sich verlässliche Konditionszahlen für größere n berechnen.


---

## Aufgabe 02

Das direkte Lösen des linearen Gleichungssystems Kx=b mittels Gauß-Algorithmus oder Rückwärtssubstitution ist numerisch stabiler und deutlich effizienter als die Berechnung von x=K^-1b über die Matrixinversion. Die Inversionsmethode ist zeitlich deutlich aufwändiger und anfälliger für numerische Fehler, da die Berechnung der Inversen selbst fehleranfällig und rechenintensiv ist. Deshalb sollte man in der Praxis immer das Gleichungssystem direkt lösen, anstatt die Inverse zu verwenden.

---

## Aufgabe 03

Zu v): Ich glaube 100 Iterationsschritte ist mehr als sinnfrei.

Das Gradientenverfahren zeigt eine langsame, lineare Konvergenz mit einem Konvergenzfaktor nahe 1, der von Anfang an stabil bleibt. Das Newton-Verfahren hingegen startet mit größeren Schwankungen, konvergiert aber sehr schnell ab etwa α=10^−7 und erreicht eine viel geringere Fehlerdifferenz. Ab diesem Punkt nähert sich der Konvergenzfaktor dem des Gradientenverfahrens an, da beide Methoden nahe am Optimum nur noch kleine Schritte machen. Insgesamt ist Newton deutlich effizienter, benötigt aber die Berechnung der Hesse-Matrix und eine gute Startlösung.

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