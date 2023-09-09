(define (problem tim-loses-wagon)
  (:domain
    tim-and-wagon)
  (:objects
    tim - character
    red-wagon - object
    yard tree - object)
  (:init
    (alive tim)
    (at tim yard)
    (has tim red-wagon)
    (intends tim (alive tim))
    (intends tim (has tim red-wagon))
    (at tree yard))
  (:goal
    (and (not (has tim red-wagon))
    (not (wind-blows))))
)