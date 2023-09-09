(define (problem tim-box-surprise)
  (:domain
    tim-and-the-box)
  (:objects
    tim - character)
  (:init
    (box-closed)
    (cake-good)
    (intends tim (birthday tim))
    (intends tim (box-open))
  )
  (:goal
    (and (box-open)
    (or (cake-spoiled)
    (cake-good)))
  )
)