(define (problem peter-in-neverland)
  (:domain neverland)
  (:objects
    peter wendy hook - character
    tinkerbell - fairy
    beach ship - place)
  (:init
    (alive peter)
    (at peter beach)
    (intends peter (alive peter))
    (intends peter (believe-in-fairies peter))
    (has peter tinkerbell)
    (alive tinkerbell)
    (has wendy tinkerbell)
    (alive wendy)
    (has wendy hook)
    (alive hook)