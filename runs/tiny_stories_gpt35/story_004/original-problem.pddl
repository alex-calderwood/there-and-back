(define (problem chloe-tomato)
  (:domain chloe-garden)
  (:objects
    chloe colin - character
    garden distant-land - object)
  (:init
    (at chloe garden)
    (at colin garden)
    (intends chloe (trusts colin))
    (intends chloe (has-seen-tomato)))
  (:goal
    (and (at chloe garden)
    (trusts chloe colin)
    (has-seen-tomato))
  )
)