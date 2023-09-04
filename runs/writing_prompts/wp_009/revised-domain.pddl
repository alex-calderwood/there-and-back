(define (domain aging-spirit)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (spirits-present ?character - character)
    (spirits-gone ?character - character)
    (weak ?character - character)
    (love-driven-away ?character - character)
    (in-asylum ?character - character)
  )

  ;; A character becomes weak.
  (:action become-weak
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (spirits-present ?character))
    :effect
      (weak ?character)
    :agents
      (?character)
  )

  ;; A character drives away their love.
  (:action drive-away-love
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (spirits-present ?character))
    :effect
      (love-driven-away ?character)
    :agents
      (?character)
  )

  ;; A character ends up in an asylum.
  (:action end-up-in-asylum
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (spirits-present ?character))
    :effect
      (in-asylum ?character)
    :agents
      (?character)
  )

  ;; A character asks the spirits to leave.
  (:action ask-spirits-to-leave
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (spirits-present ?character))
    :effect
      (and (spirits-gone ?character)
      (not (spirits-present ?character)))
    :agents
      (?character)
  )

  ;; A character regrets asking the spirits to leave.
  (:action regret-asking-spirits-to-leave
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (spirits-gone ?character))
    :effect
      (spirits-present ?character)
    :agents
      (?character)
  )
)