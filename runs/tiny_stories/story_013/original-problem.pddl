(define (problem find-toy)
  (:domain
    sue-and-cat)
  (:objects
    sue cat - character
    park tree box - place
    toy1 toy2 toy3 - toy)
  (:init
    (at sue park)
    (dark park)
    (at cat park)
    (under cat tree)
    (sad cat)
    (lost cat toy1)
    (intends sue (found cat toy1))
    (intends sue (happy cat))
    (in toy1 box)
    (in toy2 box)
    (in toy3 box))
  (:goal
    (and (found cat toy1)
    (happy cat))
  )
)