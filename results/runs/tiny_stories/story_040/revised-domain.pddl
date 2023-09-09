(define (domain tim-and-the-mountain)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object toy - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?toy - toy)
    (on-top ?toy - toy ?place - place)
    (friends ?character1 - character ?character2 - character)
    (scared ?character - character)
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

  ;; A character retrieves a toy from a place.
  (:action retrieve-toy
    :parameters
      (?character - character ?toy - toy ?place - place)
    :precondition
      (and (at ?character ?place)
      (on-top ?toy ?place))
    :effect
      (and (not (on-top ?toy ?place))
      (has ?character ?toy))
    :agents
      (?character)
  )

  ;; A character becomes friends with another character.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character overcomes their fear.
  (:action overcome-fear
    :parameters
      (?character - character)
    :precondition
      (scared ?character)
    :effect
      (not (scared ?character))
    :agents
      (?character)
  )
)