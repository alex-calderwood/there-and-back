(define (domain secret-flower-place)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (knows-secret ?character - character)
    (picked-flowers ?character - character)
    (gave-flowers ?giver - character ?receiver - character)
    (happy ?character - character)
    (patient ?character - character)
    (kind ?character - character)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (at ?character ?place))
      (knows-secret ?character))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character picks flowers.
  (:action pick-flowers
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (knows-secret ?character))
    :effect
      (picked-flowers ?character)
    :agents
      (?character)
  )

  ;; A character gives flowers to another character.
  (:action give-flowers
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (picked-flowers ?giver))
    :effect
      (and (gave-flowers ?giver ?receiver)
      (happy ?receiver))
    :agents
      (?giver)
  )

  ;; A character shares a secret with another character.
  (:action share-secret
    :parameters
      (?sharer - character ?receiver - character)
    :precondition
      (and (not (= ?sharer ?receiver))
      (knows-secret ?sharer)
      (patient ?sharer))
    :effect
      (knows-secret ?receiver)
    :agents
      (?sharer)
  )

  ;; A character promises to be patient and kind.
  (:action promise
    :parameters
      (?character - character)
    :effect
      (and (patient ?character)
      (kind ?character))
    :agents
      (?character)
  )
)