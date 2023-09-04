(define (domain letting-go)
  (:requirements :strips :negative-preconditions :typing)
  (:types emotion - object)
  (:predicates
    (feeling ?emotion - emotion)
    (let-go ?emotion - emotion)
  )

  ;; A person feels a certain emotion.
  (:action feel
    :parameters
      (?person - emotion ?emotion - emotion)
    :precondition
      (not (feeling ?emotion))
    :effect
      (feeling ?emotion)
    :agents
      (?person)
  )

  ;; A person lets go of a certain emotion.
  (:action let-go
    :parameters
      (?person - emotion ?emotion - emotion)
    :precondition
      (and (feeling ?emotion)
      (not (let-go ?emotion)))
    :effect
      (and (not (feeling ?emotion))
      (let-go ?emotion))
    :agents
      (?person)
  )
)