(define (problem alien-invasion)
  (:domain alien-liberation)
  (:objects
    human - character
    illuminati - character
    english - expression
    alienese - expression
    liberation - expression)
  (:init
    (alive human)
    (speaks human english)
    (alive illuminati)
    (oppressed human)
    (knows human (visible illuminati))
    (intends alien (liberate alien human))
    (knows alien (visible liberation))
    (speaks alien alienese)
    (intends human (believe (visible liberation)))
    (intends human (express (visible liberation)))
    (intends human (believe (not (oppressed human)))))
  (:goal
    (and (not (oppressed human))
    (believes human (not (oppressed human))))))