(define (domain rabbit-race)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (scared ?character - character)
    (racing ?character - character)
    (fast ?character - character)
    (winner ?character - character)
    (celebrating ?character - character)
  )

  ;; A character starts racing.
  (:action start-racing
    :parameters
      (?character - character)
    :precondition
      (and (not (racing ?character))
           (scared ?character))
    :effect
      (racing ?character)
    :agents
      (?character)
  )

  ;; A character runs faster.
  (:action run-faster
    :parameters
      (?character - character)
    :precondition
      (and (racing ?character)
           (not (fast ?character)))
    :effect
      (fast ?character)
    :agents
      (?character)
  )

  ;; A character wins the race.
  (:action win
    :parameters
      (?character - character)
    :precondition
      (and (racing ?character)
           (fast ?character))
    :effect
      (winner ?character)
    :agents
      (?character)
  )

  ;; A character celebrates their win.
  (:action celebrate
    :parameters
      (?character - character)
    :precondition
      (winner ?character)
    :effect
      (celebrating ?character)
    :agents
      (?character)
  )
)