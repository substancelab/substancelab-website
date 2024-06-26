---
title: Send ikke dine egne e-mails
description: Der er alt for mange faldgruber, når du sender e-mail fra din løsning. Du bør lade eksperterne om at sørge for, at dine emails bliver leveret til dine kunder.
tags: eksterne tjenester, produktstyring, software
photo:
  cloudinary: "v1571231365/substancelab-website/mailboxes"
  credits:
    name: Liz West
    url: https://www.flickr.com/photos/calliope/2314902551/
---

Jeg er - som den trofaste læser, nok har bemærket - stor fortaler for at lade eksterne tjenester håndtere så meget som muligt af din web applikation. Et af de områder, der er oplagt, er udsending af e-mail.

READMORE
Umiddelbart virker e-mail udsending ikke som et stort problem og enhver udvikler kan sende en e-mail så let som ingenting. Men vil du være sikker på, at de faktisk når frem, skal du kigge på baggrundskøer, throttling, graylists, SPF records, DKIM signatures og sikkert flere detaljer.

Derfor anbefaler jeg, at du lader en tredjepartstjeneste om at håndtere dine e-mails.

## Eksempel

Tidligere på ugen modtag en af mine kunder e-mail fra [Postmark](https://postmarkapp.com/) - den tjeneste vi bruger til udsending af e-mails - om at Google havde ændret deres krav til DKIM nøgler, så den vi havde brugt hidtil ikke længere var god nok - hvilket bl.a. øger risikoen for at blive opfattet som spam.

Mailen indeholdt [tydelige instrukser og forklaringer](https://postmarkapp.com/blog/upgrading-and-rotating-dkim-keys) og problemet var rettet på meget kort tid.

Det problem havde vi ikke selv opdaget endnu. Godt nok havde vi fået nogle rapporter om at e-mails fra Web applikationen var begyndt at havne i Gmail's spamfilter, men det var ikke noget, der virkede suspekt eller systematisk, så vi havde ikke bidt specielt mærke i det.

Og selv hvis vi havde opdaget det, ville vi nok først have fundet frem til DKIM problemet efter en lang og dyr fejlfindingsproces. Det er den slags viden, der kræver eksperter, som gør nøjagtigt det, de er gode til.

De eksperter får du nemmest og billigst ved at leje dem via en tredjepartstjeneste.
