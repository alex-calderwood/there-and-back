(define (problem survival)
  (:domain survivalist)
  (:objects
    protagonist - character
    grocery-store gas-pump - item
    broken-window - item
    real-books - item)
  (:init
    (alive protagonist)
    (intends protagonist (alive protagonist))
    (intends protagonist (knows protagonist building))
    (intends protagonist (knows protagonist spring-house))
    (intends protagonist (knows protagonist running-water))
    (intends protagonist (knows protagonist solar-panels))
    (intends protagonist (knows protagonist batteries))
    (intends protagonist (knows protagonist candles))
    (intends protagonist (knows protagonist toilet-paper))
    (intends protagonist (knows protagonist garden))
    (intends protagonist (knows protagonist canning))
    (intends protagonist (teaches protagonist child building))
    (intends protagonist (teaches protagonist child running-water))
    (intends protagonist (teaches protagonist child solar-panels))
    (intends protagonist (teaches protagonist child gardening))
    (intends protagonist (teaches protagonist child canning))
    (intends protagonist (teaches protagonist adult building))
    (intends protagonist (teaches protagonist adult running-water))
    (intends protagonist (teaches protagonist adult solar-panels))
    (intends protagonist (teaches protagonist adult gardening))
    (intends protagonist (teaches protagonist adult canning))
    (intends protagonist (teaches protagonist self-sufficiency))
    (intends