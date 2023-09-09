(define (problem chloe-tomato-adventure)
  (:domain
    chloe-tomato)
  (:objects
    chloe colin - character
    garden distant-land - place
    tomato - object)
  (:init
    (alive chloe)
    (at chloe garden)
    (intends chloe (alive chloe))
    (intends chloe (trusts chloe colin))
    (alive colin)
    (at colin garden)
    (intends colin (alive colin))
    (intends colin (has-seen colin tomato))
    (at tomato distant-land))
  (:goal
    (and (trusts chloe colin)
    (not (has-seen chloe tomato))))
  )
)