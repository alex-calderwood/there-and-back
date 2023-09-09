(define (domain tim-and-bird)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?item - item)
    (near ?item1 - item ?item2 - item)
    (in-nest ?bird - character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (alive ?character)
      (at ?character ?from)
      (not (at ?character ?to)))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character plays with an item.
  (:action play
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (and)
    :agents
      (?character)
  )

  ;; A character picks up an item.
  (:action pick-up
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (near ?character ?item))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character helps a bird back to its nest.
  (:action help-bird
    :parameters
      (?character - character ?bird - character)
    :precondition
      (and (alive ?character)
      (alive ?bird)
      (not (in-nest ?bird)))
    :effect
      (in-nest ?bird)
    :agents
      (?character)
  )

  ;; A bird falls from its nest.
  (:action bird-falls
    :parameters
      (?bird - character)
    :precondition
      (and (alive ?bird)
      (in-nest ?bird))
    :effect
      (not (in-nest ?bird))
  )
)