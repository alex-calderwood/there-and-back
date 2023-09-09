(define (problem rocket-playtime)
  (:domain
    unusual-rocket)
  (:objects
    tim sue - character
    yard park swing - place)
  (:init
    (at tim yard)
    (intends tim (happy tim))
    (intends tim (played-with tim rocket))
    (intends tim (played-with sue rocket))
    (at sue park)
    (intends sue (happy sue))
    (intends sue (played-with tim rocket))
    (intends sue (played-with sue rocket))
  )
  (:goal
    (and (happy tim)
    (happy sue)
    (played-with tim rocket)
    (played-with sue rocket))
  )
)