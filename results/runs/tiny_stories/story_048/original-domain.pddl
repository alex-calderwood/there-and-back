(define (domain park-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (dry ?place - place)
    (wet ?place - place)
    (happy ?character - character)
    (sad ?character - character)
    (friends ?character1 - character ?character2 - character)
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

  ;; A character plays on a dry place.
  (:action play
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (dry ?place))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character dries a wet place.
  (:action dry-place
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (wet ?place))
    :effect
      (and (not (wet ?place))
      (dry ?place))
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action make-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (happy ?character1)
      (happy ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)