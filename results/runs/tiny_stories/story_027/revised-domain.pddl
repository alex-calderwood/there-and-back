(define (domain hide-and-seek-toys)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character toy - object place - location)
  (:predicates
    (hidden ?toy - toy ?place - place)
    (found ?toy - toy)
    (at ?character - character ?place - place)
    (searched ?character - character ?place - place)
  )

  ;; A character hides a toy in a place.
  (:action hide
    :parameters
      (?character - character ?toy - toy ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (hidden ?toy ?place)
    :agents
      (?character)
  )

  ;; A character searches for a toy in a place.
  (:action search
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (searched ?character ?place)))
    :effect
      (searched ?character ?place)
    :agents
      (?character)
  )

  ;; A character finds a toy in a place.
  (:action find
    :parameters
      (?character - character ?toy - toy ?place - place)
    :precondition
      (and (at ?character ?place)
      (hidden ?toy ?place)
      (searched ?character ?place))
    :effect
      (found ?toy)
    :agents
      (?character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )
)