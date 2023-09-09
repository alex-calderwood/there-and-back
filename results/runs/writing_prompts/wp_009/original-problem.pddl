(define (problem aging-spirit-problem)
  (:domain
    aging-spirit)
  (:objects
    protagonist - character)
  (:init
    (alive protagonist)
    (spirits-present protagonist)
    (intends protagonist (alive protagonist))
    (intends protagonist (spirits-gone protagonist))
  )
  (:goal
    (and (alive protagonist)
    (spirits-gone protagonist)
    (weak protagonist)
    (love-driven-away protagonist)
    (in-asylum protagonist))
  )
)