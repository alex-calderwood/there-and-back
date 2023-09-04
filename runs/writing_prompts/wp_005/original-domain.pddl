(define (domain jens-life)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character event - object)
  (:predicates
    (alive ?character - character)
    (has-card ?character - character ?event - event)
    (card-read ?character - character ?event - event)
    (experienced ?character - character ?event - event)
    (has-cancer ?character - character)
    (undergoing-treatment ?character - character)
  )

  ;; A character reads a card for an event.
  (:action read-card
    :parameters
      (?character - character ?event - event)
    :precondition
      (and (alive ?character)
      (has-card ?character ?event)
      (experienced ?character ?event)
      (not (card-read ?character ?event)))
    :effect
      (card-read ?character ?event)
    :agents
      (?character)
  )

  ;; A character experiences an event.
  (:action experience-event
    :parameters
      (?character - character ?event - event)
    :precondition
      (and (alive ?character)
      (not (experienced ?character ?event)))
    :effect
      (experienced ?character ?event)
    :agents
      (?character)
  )

  ;; A character is diagnosed with cancer.
  (:action diagnose-cancer
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (has-cancer ?character)))
    :effect
      (has-cancer ?character)
    :agents
      (?character)
  )

  ;; A character starts chemotherapy treatment.
  (:action start-chemotherapy
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has-cancer ?character)
      (not (undergoing-treatment ?character)))
    :effect
      (undergoing-treatment ?character)
    :agents
      (?character)
  )
)