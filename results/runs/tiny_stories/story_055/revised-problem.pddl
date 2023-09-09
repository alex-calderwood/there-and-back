(define (problem tim-overcomes-fear)
  (:domain
    tim-and-grandma)
  (:objects
    tim grandma - character
    vase bug - object
    house - object)
  (:init
    (at tim house)
    (alive tim)
    (at grandma house)
    (alive grandma)
    (at vase house)
    (at bug house)
    (bug bug)
    (scary bug)
    (intends tim (not (scared tim)))
    (intends grandma (not (scared tim))))
  (:goal
    (and (not (scared tim))
    (outside bug)))
  )