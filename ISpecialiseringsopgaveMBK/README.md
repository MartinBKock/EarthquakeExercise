Specialiseringsopgave Martin Bergmann Kock IOS forår 2023

Appen fungere på den måde at den til at starte med henter alle jordskælv ind for den seneste time
og det er det view man bliver mødt af.
Jeg har lavet et view som der så alt efter hvilket view der bliver trykket på i tabviewet bliver kørt
en funktion, som så henter det tilsvarende data fra apiet.
Jeg har valgt at alle interessante jordskælv altid skal vises i toppen, inden at man ser de jordskælv
som passer til det tidsinterval man har valgt.
Hvis et interessant jordskælv ligger inden for det valgte tidsinterval, så er det markeret med 
en stjerne. Det samme sker oppe i listen med interessante.
Når man swipet og trykket på fluebenet for at tilføje jordskælv til interessant bliver det puttet
ind i et array, som hedder favorites og det bliver persisteret ved at skrive til en json fil.
Der bliver skrevet til filen hver gang man tilføjer eller fjerner et element fra arrayet.

Når man kigger på kortet over jordskælv, så bliver der zoomet ind på det sted som det valgte
jordskælv skete og vist med en rød pin marker. Er det dog et interessant jordskælv, så bliver
det vist med en blå pin istedet for. Alle interessante jordskælv bliver altid vist på kortet.

Man kan trykke på et info mærke oppe i højre hjørne af skærmen og blive navigeret over
til en detalje side hvor der er lidt ekstra informationer om jordskælvet.
På denne side kan man også trykke på en knap for at markere et jordskælv som interessant
samt sige at det ikke længere er interessant. Man kan også trygge på go back to frontpage
og blive navigeret til listen af jordskælv
