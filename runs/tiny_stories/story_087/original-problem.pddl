(define (problem emma-birthday)
  (:domain
    emma-birthday-party)
  (:objects
    emma mom dad - character)
  (:init
    (intends mom (happy emma))
    (intends dad (happy emma))
    (intends emma (happy emma)))
  (:goal
    (happy emma)
  )
)