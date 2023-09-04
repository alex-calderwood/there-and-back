(define (domain werewolf-runner)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (running ?character - character)
    (awake ?character - character)
    (strong ?character - character)
    (lean ?character - character)
    (werewolf ?character - character)
    (full-moon)
    (transformed ?character - character)
  )

  ;; A character starts running.
  (:action start-running
    :parameters
      (?character - character)
    :precondition
      (and (awake ?character)
      (not (running ?character)))
    :effect
      (running ?character)
    :agents
      (?character)
  )

  ;; A character stops running.
  (:action stop-running
    :parameters
      (?character - character)
    :precondition
      (running ?character)
    :effect
      (not (running ?character))
    :agents
      (?character)
  )

  ;; A character becomes strong and lean.
  (:action become-strong-lean
    :parameters
      (?character - character)
    :precondition
      (and (awake ?character)
      (not (strong ?character))
      (not (lean ?character)))
    :effect
      (and (strong ?character)
      (lean ?character))
    :agents
      (?character)
  )

  ;; A character transforms into a werewolf.
  (:action transform
    :parameters
      (?character - character)
    :precondition
      (and (werewolf ?character)
      (full-moon)
      (not (transformed ?character)))
    :effect
      (transformed ?character)
    :agents
      (?character)
  )

  ;; A character reverts from werewolf form.
  (:action revert
    :parameters
      (?character - character)
    :precondition
      (transformed ?character)
    :effect
      (not (transformed ?character))
    :agents
      (?character)
  )
)