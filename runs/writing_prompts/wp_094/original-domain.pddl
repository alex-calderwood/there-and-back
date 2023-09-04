(define (domain serial-killer)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (has-gun ?character - character)
    (tied-up ?character - character)
    (on-phone ?character - character)
    (monologuing ?character - character)
    (convinced ?character - character)
  )

  ;; A character ties up another character.
  (:action tie-up
    :parameters
      (?character - character ?victim - character)
    :precondition
      (and (not (= ?character ?victim))
      (alive ?character)
      (alive ?victim)
      (not (tied-up ?victim)))
    :effect
      (tied-up ?victim)
    :agents
      (?character)
  )

  ;; A character unties another character.
  (:action untie
    :parameters
      (?character - character ?victim - character)
    :precondition
      (and (not (= ?character ?victim))
      (alive ?character)
      (alive ?victim)
      (tied-up ?victim))
    :effect
      (not (tied-up ?victim))
    :agents
      (?character)
  )

  ;; A character talks on the phone.
  (:action talk-on-phone
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (on-phone ?character)))
    :effect
      (on-phone ?character)
    :agents
      (?character)
  )

  ;; A character ends a phone call.
  (:action end-phone-call
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (on-phone ?character))
    :effect
      (not (on-phone ?character))
    :agents
      (?character)
  )

  ;; A character starts a monologue.
  (:action start-monologue
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (monologuing ?character)))
    :effect
      (monologuing ?character)
    :agents
      (?character)
  )

  ;; A character ends a monologue.
  (:action end-monologue
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (monologuing ?character))
    :effect
      (not (monologuing ?character))
    :agents
      (?character)
  )

  ;; A character convinces another character.
  (:action convince
    :parameters
      (?character - character ?victim - character)
    :precondition
      (and (not (= ?character ?victim))
      (alive ?character)
      (alive ?victim)
      (not (convinced ?victim)))
    :effect
      (convinced ?victim)
    :agents
      (?character)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (not (= ?killer ?victim))
      (alive ?killer)
      (has-gun ?killer)
      (alive ?victim))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )
)