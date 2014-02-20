---
title: Mindre kode er en god ting
tags: software, udvikling, produktstyring
---

Man skulle tro, at jeg er fortaler for endnu mere kode i projekter. Det er sådan set også, men kode kommer med en række risici, som er værd at være opmærksom på.
READMORE

## Store projekter er svære at overskue

Jo mere kode dit projekt indeholder, jo sværere er det for udviklerne at overskue. Dermed bliver det også sværere for dem at overskue konsekvenserne af deres ændringer, hvilket medfører øget risiko for fejl eller dobbelt arbejde.

Programmører er - selv om de gerne vil udstråle noget andet - mennesker, og der er begrænsninger for hvor meget vi mennesker kan rumme i vores hovede på én gang. Når en kodebase bliver for stor at have i hovedet på samme tid, går udviklingshastigheden ned:

* Programmøren bliver nødt til at slå op, hvordan det nu lige var en given funktion fungerer i stedet for bare at bruge den.
* Hvis det vil tage lang tid at finde en eksisterende funktion, skriver programmøren den muligvis bare igen. Det er dobbelt arbejde - ikke bare nu, men også i fremtiden, hvor begge funktioner skal vedligeholdes.
* Jo mere, der holdes i hovedet på én gang, jo større risiko er der også for at ting blandes sammen eller forveksles. Det betyder at funktioner bruges på en måde, hvor en anden havde været bedre, med fejl til følge.

## Løsningen

Løsningen er ret simpel: Skriv mindre kode.

Et godt eksempel er abonnementsbetalinger. I stedet for at skrive tonsvis af kode - og det ender du med - findes der adskillige tjenester, som håndterer betalingen for dig. Du behøver med andre ord ikke skrive den kode, men i stedet benytte dig af noget, som nogen allerede har skrevet.

## Man kan leje kode

Et væld af tredjeparts tjenester og open source biblioteker står klar til at håndtere næsten alt funktionalitet, du måtte have brug - måske lige på nær det, der udgør din kerneforretning.

Ikke nok med at du reducerer mængden af kode, du har ansvar for - og dermed ovennævnte risici - du kommer hurtigere ud over stepperne og til en lancering af dit projekt.
