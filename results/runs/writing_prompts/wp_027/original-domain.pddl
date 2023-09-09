(define (domain glitch-in-matrix)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (clothed ?character - character)
    (alive ?character - character)
    (stuck ?character - character)
    (falling ?character - character)
    (aware-glitch ?character - character)
  )

  ;; A character becomes aware of the glitch in the Matrix.
  (:action become-aware
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (aware-glitch ?character)
    :agents
      (?character)
  )

  ;; A character tries to help another character who is stuck.
  (:action help-stuck
    :parameters
      (?helper - character ?stuck-character - character)
    :precondition
      (and (alive ?helper)
      (stuck ?stuck-character)
      (at ?helper ?stuck-character))
    :effect
      (and (not (stuck ?stuck-character))
      (aware-glitch ?helper))
    :agents
      (?helper)
  )

  ;; A character falls from the sky.
  (:action fall
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (falling ?character))
    :effect
      (and (not (falling ?character))
      (at ?character ?place))
    :agents
      (?character)
  )

  ;; A character loses their clothes.
  (:action lose-clothes
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (clothed ?character))
    :effect
      (not (clothed ?character))
    :agents
      (?character)
  )
)