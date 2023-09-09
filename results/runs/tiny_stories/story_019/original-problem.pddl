(define (problem handprint-celebration)
  (:domain
    tim-handprint)
  (:objects
    tim mom dad - character
    box colors paper - object)
  (:init
    (intends tim (found tim box))
    (intends tim (made-handprint tim))
    (intends tim (celebrated mom))
    (intends tim (celebrated dad))
    (intends mom (celebrated tim))
    (intends dad (celebrated tim)))
  (:goal
    (and (found tim box)
    (made-handprint tim)
    (celebrated mom)
    (celebrated dad)
    (celebrated tim))
  )
)