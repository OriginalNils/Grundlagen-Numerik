
# README – Blatt 02 Numerik

## Aufgabe 01

Zu iv): Bei kleinen Gittergrößen (N ≤ 5) stimmen analytische und numerische Determinanten nahezu exakt überein. Ab etwa N = 6 wächst der Fehler jedoch schnell an. Dieses Verhalten erklärt sich durch die schlechte Konditionierung der Vandermonde-Matrix, die bei zunehmender Gitterpunktanzahl numerische Instabilitäten verursacht. Besonders bei großen N entstehen erhebliche Abweichungen, die den praktischen Einsatz der Vandermonde-Matrix für hohe Dimensionen problematisch machen.

Zu v): Die Ergebnisse der Interpolation von f(x)=sin⁡(exp⁡(x)) bmit Hilfe der Vandermonde-Matrix zeigen eine moderate Zunahme der Berechnungszeit mit steigender Anzahl an Gitterpunkten N, wobei die durchschnittliche Zeit in den Mikrosekundenbereich wächst. Besonders auffällig ist jedoch die exponentielle Zunahme der Konditionszahl κ, die für kleine Gittergrößen noch moderat bleibt, aber ab N=4 deutlich ansteigt. Für N=10 erreicht die Konditionszahl bereits Werte im Bereich von 10^11, was auf eine zunehmende numerische Instabilität hinweist. Eine hohe Konditionszahl deutet darauf hin, dass die Matrix schlecht konditioniert ist, was zu fehlerhaften Berechnungen führen kann. Insgesamt lässt sich feststellen, dass für größere Gitterpunktzahlen die numerische Genauigkeit leidet, was die praktische Anwendung der Vandermonde-Interpolation einschränkt. Um diese Instabilität zu vermeiden, könnten kleinere Gittergrößen verwendet oder alternative Interpolationsmethoden wie Splines oder Lagrange-Interpolation in Betracht gezogen werden.

---

## Aufgabe 02

Keine Variablen müssen beim Ausführen übergeben werden. Eine Tabelle mit den Supremumsnormen wird ausgegeben.

---

## Aufgabe 03



---

## Voraussetzungen

- Julia Version **1.11.5**
- Standard-Bibliotheken:
  - `Printf` (für formatierte Ausgaben)
  - `Plots` (für Diagramme)
  - `PrettyTables` (für Tabellen)
  - `LinearAlgebra` (für Determinanten)

---

## Ausführung

1. Öffnen Sie ein **Julia-REPL** mit Version **1.11.5**.

2. Führen Sie folgenden Befehl aus, um den Code zu laden:

```
include("blatt02.jl")
```
3. Der Code der jeweiligen Aufgaben kann jeweils mit folgenden Befehl ausgeführt werden, wobei für x die jeweilige Aufgaben Nummer genutzt werden muss.
```
aufg0x()
```