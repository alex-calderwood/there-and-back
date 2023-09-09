(define (problem harry-feldman-adventure)
  (:domain
    harry-feldman-trucker)
  (:objects
    harry - character
    earth interspace-76 - place
    intergalactic-truck - vehicle)
  (:init
    (at harry earth)
    (intends harry (has harry intergalactic-truck))
    (intends harry (freedom interspace-76))
  )
  (:goal
    (and (at harry interspace-76)
    (has harry intergalactic-truck)
    (freedom interspace-76))
  )
)