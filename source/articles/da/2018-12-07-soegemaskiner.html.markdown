---
title: "Søgemaskiner"
description: "Søgemaskiner ser simple ud udefra; det er jo bare et enkelt felt! Men kompleksiteten gemmer sig under overfladen..."
tags: software
photo:
  cloudinary: "v1571230259/substancelab-website/searching_folders"
  credits:
    name: "Annie Theby"
    url: https://unsplash.com/photos/EXCeGbyolPY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText
---

På et tidspunkt får din løsning så meget indhold, at du ikke længere kan overskue det på et par sider. Derfor melder ønsket sig om en søgemaskine sig - så kan vi jo bare indtaste det, vi leder efter og så finder maskinen det for os!

READMORE

## Sandhed med modifikationer

Og det er sandt nok, men søgemaskiner er i kategorien [isbjerg-features](https://substancelab.dk/articles/isbjerge/). Man kan kun se et helt enkelt søgefelt, så hvor svært kan det være at implementere ét enkelt felt?

Faktum er, at hvad der foregår bag kulisserne for at finde det indhold, du netop leder efter, og levere det til dig på brøkdelen af et sekund, er super komplekst. Heldigvis er der løsninger, der kan hjælpe dig.

## Søgemaskiner er ikke ens

Groft skåret findes der to slags søgemaskiner:

* Fri-tekst søgning, hvor du indtaster dine søgeord og så kommer der et resultat, typisk vist i rangeret orden efter hvad der var mest sandsynligt, at du vil finde. Her er Google nok det bedst kendte eksempel.
* Facet-søgning, hvor du udfylder en række kriterier, hvorefter systemet finder det indhold, der matcher dine ønsker. Det er typisk set på webshops, hvor facetterne kan være fx pris, størrelse, eller farve.

Og så kan de kombineres, så man kan lave fri-tekst søgning indenfor de valgte facetter.

### Fri tekst søgning

Og igen lidt groft skåret, er der 2 aspekter til en fri-tekst søgemaskine:

1. Hvilke resultater findes.
2. Hvilken rækkefølge vises resultater i.

Det, som for eksempel Google er drøngod til, er at vise resultaterne i en rækkefølge så de første resultater typisk er de mest relevante. Så betyder det ikke så meget, om de resultater, der findes frem er de korrekte, for de mindst korrekte vises på side 10 som ingen ser.

Derfor bliver fokus ved implementering af en søgemaskine reelt set noget med at definere, hvilke resultater der er mere relevante end andre givet et eller flere søgeord. Den del findes der ikke nogen standard-løsning til, da det er helt afhængigt af den enkelte applikation og det indhold, der ledes efter.

## Forskellige løsninger

Men der findes fremragende løsninger til at lave fri-tekst-søgning og lave relevans-sortering, også løsninger, der kan tage højde for forskellige stavemåder e.l.

* SQL forespørgsler: Understøttet af alle databaser, bedst til facet-søgning, dårligst til fri-tekst og relevans. Det er her vi er pt. ved søgning efter steder, arrangementer, klubtilbud.

* Udvidelse til eksisterende database: Der findes udvidelser til de fleste databaser, herunder MySQL som vi bruger, der kan tilbyde fri-tekst-søgning og relevans-sortering, som kan kombineres med ovenstående SQL forespørgsler. Det er her vi er pt ved søgning efter artikler.
* Separat søgetjeneste: Der findes en række løsninger, hvor man kan sende sit indhold ind i en dedikeret søgetjeneste og bagefter få dem ud igen. Typisk er de rigtigt gode til fri-tekst-søgning og relevans-sortering, men afhængigt af løsningen kan det være begrænset med tilpasningsmuligheder.

## Vores erfaringer

I sidstnævnte kategori har vi haft gode erfaringer med [Elastic Search](https://www.elastic.co/products/elasticsearch), der har vist sig at kunne tilpasses til guldmedalje og levere gode og hurtige resultater. Den findes både i en hosted version, så man slipper for at skulle holde en server kørende til det, og en, hvor man selv har den liggende. Det sagt, så betaler man for kvaliteten og det kan blive en dyrere løsning. 

Til gengæld det er lykkedes os at lave ganske gode søgemaskiner baseret på de udvidelser, der findes i eksisterende databaser. 

Vores generelle anbefaling er at starte med det, din database allerede kan tilbyde dig. Hvis det viser sig at ønsket om at kunne fin-tune relevansen bliver stor nok kan man overveje at gå videre til en "rigtig" søgemaskine, som fx Elastic Search.
