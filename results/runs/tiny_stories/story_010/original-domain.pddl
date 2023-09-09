(define (domain skelly-cake)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (happy ?character - character)
    (full ?character - character)
    (cake-made)
    (playing-games ?character - character)
  )

  ;; A character makes a cake.
  (:action make-cake
    :parameters
      (?character - character)
    :precondition
      (happy ?character)
    :effect
      (cake-made)
    :agents
      (?character)
  )

  ;; A character eats the cake.
  (:action eat-cake
    :parameters
      (?character - character)
    :precondition
      (and (happy ?character)
      (cake-made))
    :effect
      (full ?character)
    :agents
      (?character)
  )

  ;; A character plays games.
  (:action play-games
    :parameters
      (?character - character)
    :precondition
      (and (happy ?character)
      (full ?character))
    :effect
      (playing-games ?character)
    :agents
      (?character)
  )

  ;; A character says thank you.
  (:action say-thank-you
    :parameters
      (?character - character)
    :precondition
      (and (happy ?character)
      (full ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )
)