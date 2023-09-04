(define (domain tim-and-secret-room)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:constants spade - item)
  (:predicates
    (has ?character - character ?item - item)
    (at ?character - character ?place - place)
    (digging ?character - character)
    (found ?character - character ?item - item)
    (opened ?character - character ?item - item)
    (playing ?character - character)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (at ?character ?place))
      (has ?character spade))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character digs a hole.
  (:action dig
    :parameters
      (?character - character)
    :precondition
      (and (has ?character spade)
      (not (digging ?character)))
    :effect
      (digging ?character)
    :agents
      (?character)
  )

  ;; A character finds an item.
  (:action find
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (digging ?character)
      (not (found ?character ?item)))
    :effect
      (and (found ?character ?item)
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character opens an item.
  (:action open
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (found ?character ?item)
      (not (opened ?character ?item)))
    :effect
      (opened ?character ?item)
    :agents
      (?character)
  )

  ;; A character plays in a secret room.
  (:action play
    :parameters
      (?character - character)
    :precondition
      (and (opened ?character small-box))
    :effect
      (playing ?character)
    :agents
      (?character)
  )
)