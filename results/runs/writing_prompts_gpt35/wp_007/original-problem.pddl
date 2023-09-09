(define (problem bachelor-pad-problem)
  (:domain bachelor-pad)
  (:objects
    laptop wire1 wire2 wire3 - physical-object
    chair bed mattress cupboard loft suitcase1 suitcase2 - physical-object
    sleeping-bag laundry-basket rain-coat green-sweater - physical-object
    white-charger shower-gel-bottle - physical-object
    window1 window2 - place
    honda-shirt formal-trousers - physical-object
    mobile-phone - physical-object
  )
  (:init
    (in bed window2)
    (occupied bed)
    (clean bed)
    (in chair window1)
    (occupied chair)
    (clean chair)
    (in cupboard window1)
    (occupied cupboard)
    (clean cupboard)
    (in loft cupboard)
    (occupied loft)
    (clean loft)
    (in suitcase1 loft)
    (occupied suitcase1)
    (clean suitcase1)
    (in suitcase2 loft)
    (occupied suitcase2)
    (clean suitcase2)
    (in laptop window1)
    (occupied laptop)
    (clean laptop)
    (in wire1 window1)
    (occupied wire1)
    (clean wire1)
    (in wire2 window1)
    (occupied wire2)
    (clean wire2)
    (in wire3 window1)
    (occupied wire3)
    (clean wire3)
    (in sleeping-bag chair)
    (occupied chair)
    (clean sleeping-bag)
    (in laundry-basket window2)
    (occupied laundry-basket)
    (clean laundry-basket)
    (in rain-coat window1)
    (occupied rain-coat)
    (clean rain-coat)
    (in honda-shirt hanger1)
    (occupied hanger1)
    (clean honda-shirt)
    (in formal-trousers hanger2)
    (occupied hanger2)
    (clean formal-trousers)
    (in mobile-phone window1)
    (occupied mobile-phone)
    (clean mobile-phone)
    (in white-charger window1)
    (occupied white-charger)
    (clean white-charger)
    (in shower-gel-bottle window1)
    (occupied shower-gel-bottle)
    (clean shower-gel-bottle)
    (real rain-coat)
    (real honda-shirt)
    (real formal-trousers)
    (intends laptop (connected wire1))
    (intends laptop (connected wire2))
    (intends laptop (connected wire3))
    (intends wire3 (in window1))
    (intends white-charger (charged mobile-phone))
    (intends shower-gel-bottle (has shower-gel-bottle transparent))
    (intends rain-coat (has rain-coat honda-logo))
    (intends mobile-phone (has mobile-phone apple-logo))
    (intends laptop (has laptop apple-logo))
    (intends laptop (has laptop wires))
    (intends laptop (has laptop octopus