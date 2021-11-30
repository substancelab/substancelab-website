---
title: "Udrulning af DMARC Reject"
description: "DMARC er vigtigt, men ikke noget, du skal implementere uovervejet. Her er vores proces, der bringer dig til DMARC Reject 100% med færrest mulige problemer."
tags: email, domæner, proces, dmarc
photo:
  cloudinary: "v1638274092/substancelab-website/no_entry_sign"
  credits:
    name: "Dim Hou"
    url: "https://unsplash.com/@dimhou?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText"

---
[Danske Medier](https://danskemedier.dk/) har i kølvandet af [et phishing-angreb på Jobindex og Jobnet](https://www.computerworld.dk/art/258649/jobindex-og-jobnet-ramt-af-kaempe-phishing-angreb-nul-hjaelp-at-hente-fra-danske-cyber-myndigheder) anbefalet at man får implementeret DMARC hurtigst muligt og med "Reject" policy.

Det kan vi kun være rygende enige i. Men lad nu være med at drøne ud og blindt ændre din [DMARC](https://www.emailsherpa.net/knows/dmarc) policy til reject. Det er ikke noget, man skal gøre i panik. Det skal gøres velovervejet og grundigt - og over tid.

READMORE

Hvis du ikke gør det rigtigt, risikerer du at du ikke kan sende emails til dine brugere, kunder, og nyhedsbrevsmodtagere. Det skulle jo gerne kun være de ondsindede phishere og scammere, som ikke kan sende.

## Det skal du have styr på

Før du ruller en 100% Reject DMARC politik ud er det vigtigt at du har styr på...

- Hvilke domæner sender du reelt emails fra?
- Hvor sender du reelt emails fra?
- Har du sat korrekte [SPF](https://www.emailsherpa.net/knows/spf) records op?
- Er [DKIM](https://www.emailsherpa.net/knows/dkim) konfigureret korrekt?

Heldigvis er det muligt at tage DMARC i små skridt, så du kan fange eventuelle problemer i opløbet uden at  afskære email kommunikationen med alle dine kunder.

## Processen

### 1. Overvågning

Start med en DMARC politik, der bare overvåger. Målet i starten er udelukkende at få et overblik over, hvilke emails bliver reelt sendt med dit domæne og hvilke af dem er reelt dine.

Når overvågningen har kørt i en måneds tid bør du have et godt overblik over, hvilke tjenester, der leverer emails for dig - og hvor mange illegale emails, der afsendes med dit domænenavn.

Har du styr på alle de tjenester, du sender emails fra, kan du springe det her trin over og gå direkte til trin 2. De fleste bliver dog overraskede og overser en enkelt afsender eller 2 - den der interne server, som sender status-rapporter hver uge fx?

### 2. Autorisér reelle afsender-tjenester

Nu skal du gennemgå de reelle tjenester og for hver af dem autorisere dem til at sende mails ved at sætte de SPF- og DKIM records op, som den konkrete tjeneste anbefaler dig.

### 3. Karantæne

Når det er gjort, er det tid at ændre din DMARC politik til Quarantine - det vil sige, at du fortæller email-servere ude i verden, at hvis de modtager en email fra dit domæne, som ikke stammer fra en af de tjenester, du har autoriseret, skal de behandle emailen varsomt. Det kan være at de smider den i Spam-mappen eller skriver en advarsel på mailen eller noget helt tredje.

Hvis du stadig er usikker på om du har autoriseret alle dine email udbydere kan du nøjes med at sætte en del af dine emails i karantæne, fx 10%. Efterhånden som tiden går og support ikke bliver overvældet af kunder som ikke modtager deres emails, kan du skrue procentsatsen op.

### 4. Afvisning

Når du er helt sikker på, at alle dine emails stadig når frem til deres modtagere er det tid at skifte til Reject policy. Forskellen mellem Quarantine og Reject er at ved Reject vil emailen blive afvist i stedet for at havne i spam e.l. - du kan altså ikke forvente at en rejected email kan findes nogle steder.

Også her kan du gradvis øge andelen af, hvilke emails der afvises, så du ikke fra den ene dag til den anden får alle dine emails blokeret. Igen, start med 10% og øg det op til 100% efterhånden som du bliver sikker på, at alle relle emails kommer frem.

## Målet er 100% reject

Tillykke! Når du er nået hertil er du med til at gøre internettet sikrere og rarere at færdes på. Nå ja, og så har du også sikret dig selv imod phishning og dit brand imod at blive brugt til at sælge viagra. Godt gået.
