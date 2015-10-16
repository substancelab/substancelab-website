---
title: Om valideringer
tags: design, forms, usability
photo:
  credits:
    name: "Sten Dueland"
    url: https://www.flickr.com/photos/stendueland/12911356713
  filename: "padlock.jpg"

---

Vi kender det allesammen. Man har udfyldt en online formular, trykker "Gem" og venter nu spændt på, om serveren nu vil acceptere det vi har skrevet. Har vi lige ramt de mystiske formater, som udvikleren har valgt at ville acceptere i dag?

READMORE

Men hvorfor overhovedet validere brugerens indtastninger? Databasen er jo i sidste ende ret ligeglad med, om du har skrevet "STEVE" som telefonnummer eller "yeah, right" som e-mail adresse.

Alligevel bruger vi en del tid på at implementere stopklodser, der forhindrer data i at blive gemt med mindre de opfylder nogle meget specifikke krav til, hvad der er "valide data".

## Det handler om brugeroplevelsen

Lad os løbe gennem et tænkt eksempel på en tilmeldingsformular, hvor vi ikke validerer de indkommende data:

Erik er ved at tilmelde sig UberDating(tm) og bliver mødt med et e-mail felt. Han indtaster sin e-mail adresse, men uheldigvis rammer han forkert, så i stedet for "erik@gmail.com" får han indtastet "erik@gmail.cm" med et ‘o’ for lidt.

Serveren accepterer det indtastede og Erik fortsætter med at udfylde sin profil med alt for mange detaljer og læner sig tilbage og venter på at tilbuddene vælter ind.

Efter nogle ugers stilhed begynder Erik at undre sig over at kvinderne ikke har kastet sig i grams i hans indbakke. Han åbner dating-sitet i sin browser og forsøger at logge ind med sin email adresse. Det virker naturligvis ikke, for han indtaster den korrekt - med ‘o’. Af samme grund fungerer nulstilling af hans kodeord heller ikke.

Oplevelsen har været rigtigt ærgerlig for Erik, og jeg garanterer dig for at han giver sitet skylden.

## Vi kan gøre det bedre

Som udviklere kunne vi have gjort mere for at give Erik en god oplevelse. En validering af e-mail adressen kunne have forhindret den ærgerlige oplevelse.

Vi kunne helt simpelt have nægtet at gemme hans oplysninger med beskeden om at erik@gmail.cm ikke er en gyldig e-mail adresse.

Endnu bedre kunne vi have foreslået, om han monstro mente "erik@gmail.com".

Det er netop her valideringerne kommer i spil. Deres primære formål er at sikre, at vi hjælper brugerne til at fa den bedst mulige oplevelse, vi kan tilbyde dem.

De bør ikke bruges til at holde styr på interne regler, som brugeren alligevel ikke kan gøre noget for at ændre. Bevares, det ville gøre vores liv som udviklere nemmere, men det bør ikke ske på bekostning af brugerens oplevelse.
