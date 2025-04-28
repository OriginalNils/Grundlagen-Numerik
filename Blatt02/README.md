
# README – Blatt 02 Numerik

## Aufgabe 01

Zu iv): Bei kleinen Gittergrößen (N ≤ 5) stimmen analytische und numerische Determinanten nahezu exakt überein. Ab etwa N = 6 wächst der Fehler jedoch schnell an. Dieses Verhalten erklärt sich durch die schlechte Konditionierung der Vandermonde-Matrix, die bei zunehmender Gitterpunktanzahl numerische Instabilitäten verursacht. Besonders bei großen N entstehen erhebliche Abweichungen, die den praktischen Einsatz der Vandermonde-Matrix für hohe Dimensionen problematisch machen.

Zu v): Die Ergebnisse der Interpolation von f(x)=sin⁡(exp⁡(x)) bmit Hilfe der Vandermonde-Matrix zeigen eine moderate Zunahme der Berechnungszeit mit steigender Anzahl an Gitterpunkten N, wobei die durchschnittliche Zeit in den Mikrosekundenbereich wächst. Besonders auffällig ist jedoch die exponentielle Zunahme der Konditionszahl κ, die für kleine Gittergrößen noch moderat bleibt, aber ab N=4 deutlich ansteigt. Für N=10 erreicht die Konditionszahl bereits Werte im Bereich von 10^11, was auf eine zunehmende numerische Instabilität hinweist. Eine hohe Konditionszahl deutet darauf hin, dass die Matrix schlecht konditioniert ist, was zu fehlerhaften Berechnungen führen kann. Insgesamt lässt sich feststellen, dass für größere Gitterpunktzahlen die numerische Genauigkeit leidet, was die praktische Anwendung der Vandermonde-Interpolation einschränkt. Um diese Instabilität zu vermeiden, könnten kleinere Gittergrößen verwendet oder alternative Interpolationsmethoden wie Splines oder Lagrange-Interpolation in Betracht gezogen werden.

---

## Aufgabe 02

Keine Variablen müssen beim Ausführen übergeben werden. Eine Tabelle mit den Supremumsnormen wird ausgegeben.

---

## Aufgabe 03

Zu ii):Beweis, dass das Polynom als $p(x_0) = b_0$ geschrieben werden kann

Gegeben ist das Polynom $p(x)$ der Form: $p(x) = \sum_{i=0}^{n} a_i x^i$

Das **Horner-Schema** berechnet den Funktionswert eines Polynoms an einem Punkt $x_0$ rekursiv. Die rekursive Berechnung erfolgt wie folgt:

1. Setze den letzten Wert $ b_n = a_n $.
2. Für $i = n-1, n-2, \dots, 0$ berechne: $b_i = a_i + b_{i+1} \cdot x_0$

Das Horner-Schema entwickelt sich also zu einer verschachtelten Form des Polynoms:

$p(x_0) = a_0 + x_0 \left( a_1 + x_0 \left( a_2 + \dots + x_0 \left( a_{n-1} + x_0 a_n \right) \dots \right) \right)$

Die rekursive Berechnung endet mit dem Wert $b_0$, der gleich dem Wert des Polynoms $p(x_0)$ ist. Daher gilt:

$p(x_0) = b_0$

---

Zu ii) Warum ist das Horner-Schema numerisch weniger anfällig für Fehler?

Das **Horner-Schema** ist numerisch stabiler als die direkte Berechnung des Polynoms aus der allgemeinen Form $ p(x) = \sum_{i=0}^{n} a_i x^i $. Dies ist aus folgenden Gründen der Fall:

1. **Weniger Operationen:** Beim direkten Berechnen des Polynoms müssen alle Terme $ a_i x^i $ separat berechnet werden, was zu großen oder kleinen Zwischenergebnissen führen kann, insbesondere bei großen Exponenten. Diese großen Zahlen können zu **numerischen Instabilitäten** und **Präzisionsverlust** führen. Das Horner-Schema führt die Berechnungen schrittweise durch und verwendet dabei weniger multiplikative Operationen, wodurch der Fehler reduziert wird.

2. **Kontrollierte Exponenten:** Bei der direkten Berechnung des Polynoms kann es zu exponentiellen Fehlern kommen, insbesondere bei großen Exponenten. Im Horner-Schema wird das Polynom schrittweise berechnet, wobei die Exponenten kontrolliert und nacheinander erhöht werden. Dies verhindert große numerische Fehler.

3. **Vermeidung von Zwischenwerten:** Das Horner-Schema minimiert die Anzahl der Zwischenberechnungen, die zu sehr großen oder sehr kleinen Zahlen führen könnten. Da die Berechnungen aufeinanderfolgend und in kleineren Schritten erfolgen, ist das Risiko von Überläufen oder **Präzisionsverlusten** geringer.

Durch diese Eigenschaften ist das Horner-Schema besonders für die numerische Auswertung von Polynomen geeignet und bietet **mehr Präzision** und **weniger Fehler** bei der Berechnung.

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