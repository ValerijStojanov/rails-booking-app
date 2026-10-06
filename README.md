# README

# Parking Reservation

Prototyp jednoduchého rezervačního systému parkovacích míst, zaměřeného spíše na backoffice použití.

Aplikace umožňuje vytvářet parkovací plochy s určitou kapacitou a následně pro ně vytvářet rezervace. U každé rezervace se zadává jméno osoby a čas začátku a konce rezervace. Jedna parkovací plocha může mít více míst, takže ve stejném čase může existovat několik rezervací, dokud není překročena její kapacita.

Téma jsem si vybral na základě situace, kterou jsem v minulosti řešil se známým. Vlastnil několik garáží v centru města a dostupnost jednotlivých časů a parkovacích míst evidoval pomocí Excelu. Rezervační systém pro parkování mi proto přišel jako zajímavý a zároveň praktický příklad pro toto zadání.

## Decisions

### Návrh modelů

Základní návrh modelů do velké míry vychází z technického zadání. Zvolil jsem dva hlavní modely, `ParkingArea` a `Reservation`. `ParkingArea` reprezentuje parkovací plochu s určitou kapacitou a `Reservation` konkrétní rezervaci v časovém intervalu.

Pro prototyp mi tato struktura přišla dostatečně jednoduchá a zároveň rozšiřitelná. Nezaváděl jsem samostatný model pro jednotlivá parkovací místa, protože pro splnění zadání stačí pracovat s celkovou kapacitou parkovací plochy. Pokud by aplikace v budoucnu potřebovala rezervovat konkrétní místo, bylo by možné model dále rozšířit.

### Umístění validační logiky

Kontrolu kapacity jsem umístil do modelu `Reservation`, protože mi dává smysl mít pravidla určující platnost rezervace na jednom místě. Společně s kontrolou povinných polí a časového intervalu tak model hlídá i to, zda nová nebo upravená rezervace nepřekročí kapacitu parkovací plochy.

Pokud by v budoucnu přibyla další validační pravidla, zůstávají soustředěná u modelu, kterého se týkají.

### Časové intervaly

Rezervace beru jako časový interval, ve kterém je místo obsazené. Pokud jedna rezervace končí například v 11:00 a druhá v 11:00 začíná, nepovažuji je za překrývající se, v modelovém případě první auto v 11:00 odjíždí a místo je okamžitě dostupné pro další.

Pro prototyp je toto chování dostačující. V reálném provozu bych zvážil přidání krátkého časového rozestupu mezi rezervacemi, protože nelze předpokládat, že každé auto odjede přesně v plánovaný čas.

## Kontrola kapacity

Při vytváření nebo úpravě rezervace nejprve vyberu rezervace stejné parkovací plochy, které se s daným časovým intervalem překrývají. Jejich začátky počítám jako `+1` a konce jako `-1`, takže po seřazení podle času průběžný součet představuje počet současně probíhajících rezervací. Pokud tento počet v kterémkoliv okamžiku překročí kapacitu parkovací plochy, rezervace není platná a nelze ji uložit.

## Co bych udělal jinak s více časem

S více časem bych se více zaměřil na reálné použití systému, například pro parkoviště u obchodních center nebo letišť. Zajímalo by mě, jak návrh upravit tak, aby dokázal pracovat se situacemi, kdy vozidlo přijede nebo odjede později, než bylo plánováno, a jak rozlišovat mezi rezervovanou a skutečnou obsazeností parkoviště.

Dále bych zvážil autentizaci uživatelů a evidenci změn, aby bylo možné dohledat, kdo konkrétní rezervaci nebo parkovací plochu vytvořil či upravil.

U produkční verze bych také řešil souběžné vytváření rezervací, aby dvě rezervace vytvořené ve stejný okamžik nemohly nezávisle projít kontrolou kapacity.