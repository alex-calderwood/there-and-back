(define (problem tims-birthday)
  (:domain tim-birthday)
  (:objects
    tim - human)
  (:init
    (alive tim))
  (:goal
    (and (has-surprise)
    (not (spoiled-cake))))
)