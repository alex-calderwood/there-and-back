(define (domain rolling-on-couch)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (bored ?character - character)
    (dizzy ?character - character)
    (happy ?character - character)
    (rolling ?character - character)
    (lying-down ?character - character)
  )

  ;; A character starts rolling.
  (:action start-rolling
    :parameters
      (?character - character)
    :precondition
      (and (bored ?character)
      (not (rolling ?character)))
    :effect
      (and (not (bored ?character))
      (rolling ?character))
    :agents
      (?character)
  )

  ;; A character stops rolling.
  (:action stop-rolling
    :parameters
      (?character - character)
    :precondition
      (rolling ?character)
    :effect
      (and (not (rolling ?character))
      (dizzy ?character))
    :agents
      (?character)
  )

  ;; A character lies down.
  (:action lie-down
    :parameters
      (?character - character)
    :precondition
      (and (dizzy ?character)
      (not (lying-down ?character)))
    :effect
      (and (not (dizzy ?character))
      (lying-down ?character))
    :agents
      (?character)
  )

  ;; A character gets up.
  (:action get-up
    :parameters
      (?character - character)
    :precondition
      (lying-down ?character)
    :effect
      (and (not (lying-down ?character))
      (happy ?character))
    :agents
      (?character)
  )
)