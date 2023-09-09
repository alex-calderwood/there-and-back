(define (problem rainy-day)
  (:domain rolling-on-couch)
  (:objects
    lily ben mom couch - object)
  (:init
    (at lily couch)
    (at ben couch)
    (at mom living-room)
    (at couch living-room)
    (loves lily couch)
    (loves ben couch)
    (loves mom lily)
    (loves mom ben))
  (:goal
    (and (not (dizzy lily))
    (not (dizzy ben))))
)