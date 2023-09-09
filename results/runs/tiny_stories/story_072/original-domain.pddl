(define (domain magic-party)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at-party ?character - character)
    (has ?character - character ?object - object)
    (fast ?character - character)
    (cake-transformed)
  )

  ;; A character goes to the party.
  (:action go-to-party
    :parameters
      (?character - character)
    :precondition
      (not (at-party ?character))
    :effect
      (at-party ?character)
    :agents
      (?character)
  )

  ;; The magician performs the magic trick.
  (:action magic-trick
    :parameters
      (?magician - character)
    :precondition
      (and (at-party ?magician)
      (not (cake-transformed)))
    :effect
      (cake-transformed)
    :agents
      (?magician)
  )

  ;; A character eats the cake.
  (:action eat-cake
    :parameters
      (?character - character)
    :precondition
      (and (at-party ?character)
      (cake-transformed))
    :effect
      (fast ?character)
    :agents
      (?character)
  )

  ;; A character plays at the party.
  (:action play
    :parameters
      (?character - character)
    :precondition
      (and (at-party ?character)
      (fast ?character))
    :effect
      (and)
    :agents
      (?character)
  )
)