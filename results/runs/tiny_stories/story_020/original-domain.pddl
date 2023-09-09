(define (domain gifted-giraffe)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (explored ?character - character ?place - place)
    (interacted ?character1 - character ?character2 - character)
  )

  ;; A character travels from one place to another.
  (:action travel
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

  ;; A character interacts with another character.
  (:action interact
    :parameters
      (?character1 - character ?character2 - character ?place - place)
    :precondition
      (and (not (= ?character1 ?character2))
      (at ?character1 ?place)
      (at ?character2 ?place))
    :effect
      (interacted ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character explores a place.
  (:action explore
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (explored ?character ?place)
    :agents
      (?character)
  )
)