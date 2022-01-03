Config = {}

-- wartosci bazowe
-- deklaracja wszelkich umiejetnosci
Config.perks = { 
	dealer = 0,
    driver = 0,
    merchant = 0,
    thief = 0,
    healer = 0, -- do Uhealer, musisz odblokować Uhealer żeby działać na tej zmiennej
    Uhealer = 0, -- zmienna która odblokuje się tylko wtedy kiedy przejdziemy kurs medyczny
}
Config.perksexp = { 
    dealerexp = 0,
    driverexp = 0,
    merchantexp = 0,
    thiefexp = 0,
    healerexp = 0,
}

--[[
    dealer
    Twoja reputacja sięga już samego Cayo Perico, łatwiej Ci jest się dogadać z ludźmi i każdy wie, że jesteś zorganizowanym dilerem.
KORZYŚCI: 50% łatwiejszy sposób sprzedaży narkotyków, lokalsi nie są już tak wybredni w wyborze narkotyku.

    driver
    Twoje umiejętności dają Ci możliwość lepszego prowadzenia pojazdów, a konkretnie aut i motocykli, 
    potrafisz panować autem niczym James Bond podczas pościgów w Casino Royale. 
KORZYŚCI: Lepsze skręcanie oraz hamowanie - średnio o 25%, delikatny wzrost szybkości maxymalnej.

    merchant
    Stałeś się doskonałym handlarzem, targujesz się z lombardami uzyskując lepsze ceny sprzedaży błyskotek,
    salony samochodowe dostosowywują specjalnie konfigurację pod Twoje #widzimisię i sprzedają Ci taniej pojazdy.
KORZYŚCI: o 20% lepsze korzyści w sprzedaży biżuterii/fantów w lombardzie, o 5% zmniejszone ceny pojazdów

    thief
    Twoje doświadczenie związane z napadami na bankomaty i kasetki powoduje, że szybciej potrafisz dostać się do mamony, 
    szczęście powoduje, że jest Ci też łatwiej znaleźć więcej gotówki
KORZYŚCI: Szybsze napady (10-20% mniej czasu spędzonego nad napadami), 20% więcej gotówki w napadach na sklepy i bankomaty

    healer
    Pierwsza pomoc - wielokrotnie korzystałeś z usług medyków, podłapałeś po nich szybsze sposoby opatrywania ran, 
KORZYŚCI: Twój czas wykonywania zabiegów medycznych na Twojej postaci uległ zmniejszeniu o 50%.
WADY: Wymaga przejścia pierwszej pomocy u medyków

]]