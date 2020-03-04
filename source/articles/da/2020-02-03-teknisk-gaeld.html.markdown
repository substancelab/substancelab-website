---
title: "Teknisk gæld"
description: "Hvad er det lige teknisk gæld egentligt er, og hvordan undgår du at have for meget af det"
tags: kvalitet, prioritering, software, udvikling
photo:
  cloudinary: "v1583221510/substancelab-website/ocean_horizon_from_jetty"
  credits:
    name: "Joshua Earle"
    url: "https://unsplash.com/@isaiahiz?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText"
---

Vi kender alle til gæld. Du mangler penge, så derfor låner du fra nogen der har dem og betaler for det senere eller over noget tid. Det tilsvarende fænomen findes indenfor teknologi. Her dækker det over de genveje en programmør tager for at komme hurtigere i mål med en opgave.

READMORE

## Gæld er ikke nødvendigvis dårligt

Det kan give god mening. Er der en ufravigelig deadline foran dig (næppe) kan det give mening at levere en løsning med enkelte uhåndterede edge-cases. Er du usikker på om kunderne vil kunne bruge den feature du laver, er det måske fornuftigt at [få den releaset nu](/articles/udgiv-din-feature-idag/) i stedet for at finpudse noget, der risikerer at blive skrottet igen.

Her kan det give mening at vælge at påtage sig noget teknisk gæld. Der er tale om et bevidst valg foretaget for at opnå et bestemt resultat.

## Det skal betales tilbage

Humlen ved gæld er, at det skal betales tilbage. Tilbagebetalingen af teknisk gæld betyder at man skal lave de tilføjelser og ændringer, som man sprang over. De edge-cases, man ignorerede, skal håndteres. De fejl, man har valgt at leve med, skal rettes. Den slags tager tid.

Og det er her, analogien med finansiel gæld passer ind; for lige som med normal gæld, løber der også renter på teknisk gæld. Det tager længere tid at rette ting til bagefter, end hvis man havde klaret dem til at starte med. Du er væk fra konteksten, koden er måske blevet tilrettet yderligere, andre systemer er afhængige af den, eller noget fjerde. Det bliver dyrere på sigt.

## Skjult teknisk gæld

Der er også en anden form for teknisk gæld, en mere problematisk form. Den tekniske gæld, der sniger sig ind på en. Som man ikke har taget et bevidst valg om. Hvis man har valgt at bruge et software-bibliotek, som efterhånden er blevet gammelt, og hvor resten af verden er rykket videre. Måske kommer der ikke længere sikkerhedsopdateringer til det, eller også blev det bare aldrig særlig populært og er blevet droppet.

Den skjulte gæld er svær at håndtere. Typisk ved du ikke, hvor den ligger. Måske ved du ikke engang, at du har den indtil det en dag viser det sig, at den ændring du vil lave, ikke kan lade sig gøre, fordi det gamle software bibliotek ligger og blokerer.


## Sådan håndterer du teknisk gæld

Begge typer teknisk gæld bør håndteres hurtigst muligt for ikke at lade "renterne" overtage. Worst case er at dit system efterhånden bliver så tynget af gæld, at ændringer tager ugevis og at det ender med at være smartest at starte helt forfra.

### Undgå teknisk gæld

Der er ingen, der synes det er sjovt at betale af på teknisk gæld. Det er dyrt, besværligt, og giver ingen umiddelbar gevinst for brugerne. Det bedste er helt at undgå det.

Det er dog sjældent praktisk muligt helt at undgå teknisk gæld. Som nævnt ovenfor kan der være situationer, hvor det er nødvendigt at påtage sig gælden. Der vil også være situationer, hvor man bare ikke ved nok om, hvordan noget vil udvikle sig eller vil blive brugt, så det giver mening ikke at bruge for meget indledende tid på det.

Løbende code reviews, par-programmering, automatiserede tests og kodestil-kontrol er alle metoder, der kan hjælpe til at forhindre teknisk gæld i at snige sig ind i dit projekt.

### Gør det synligt

Da teknisk gæld nok ikke helt kan undgås giver det god mening til gengæld at gøre det synligt. På den måde bliver det ikke en skjult bombe under dit system.

Hver gang du foretager et bevidst valg om teknisk gæld oprettes en sag i projektstyringsværktøjet med detaljer om de oprydninger, der stadig mangler at blive lavet.

Hver gang en udvikler opdager et område af løsningen, hvor der skjuler sig noget teknisk gæld, skal det oprettes i projektstyringsværktøjet.

### Reducer-teknisk-gæld-projekt

En mulighed for at reducere sin tekniske gæld er at afsætte et helt projekt til oprydning og opdatering. Det kunne fx være hele udviklingsteamet i marts måned eller noget i den stil.

Det er en upopulær måde at håndtere det på, da det betyder ingen bruger-synlige ændringer bliver implementeret i den periode. Samtidigt er der ingen garanti for at den måned er nok.

Det er typisk for stor en pille at sluge på én gang for de fleste organisationer.


### Betal af løbende

Det er mere tiltalende at betale af på den tekniske gæld løbende under udviklingen. Der findes forskellige strategier til løbende at betale af på sin tekniske gæld.

- Nogle teams følger "boy-scout-rule"; altså altid efterlade kodebasen i en bedre tilstand end du fandt den. Konkret betyder det, at man starter hver opgave med at lave en enkelt lille oprydning.
- Ping-pong-strategien: Udviklerne veksler her mellem at lave features og at rette teknisk gæld. Når man har lavet en sag og den ligger til godkendelse, kan man jo passende tage et kig på teknisk gæld.
- Du kan også dedikere tid til at håndtere teknisk gæld. Det kan fx være hver fredag eller den første time hver dag. Hvad end der passer ind i jeres planer. Det er typisk muligt at passe ind i en presset hverdag.
- Dedikeret udvikler. Nogle teams har afsat en dedikeret udvikler (eller flere) til at håndtere den slags, hvor man fx tager sig af forefaldende opgaver i forbindelse med support og ellers betaler af på den tekniske gæld. Rollen kan eventuelt gå på omgang fx hver måned eller man kan [hyre et eksternt team](/services/maintenance/) til det.

På den måde kan man holde et nogenlunde momentum og fortsætte udviklingen af sin løsning mens man samtidigt sikrer at den bliver stadig bedre og gælden reduceret.
