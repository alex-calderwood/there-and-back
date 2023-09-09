(define (domain kitty-and-dog)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (hungry ?character - character)
    (at ?character - character ?place - place)
    (has-food ?place - place)
    (hidden ?character - character)
    (deaf ?character - character)
    (scared ?character - character)
    (fed ?character - character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (at ?character ?place))
      (hungry ?character))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character hides.
  (:action hide
    :parameters
      (?character - character)
    :precondition
      (and (scared ?character)
      (not (hidden ?character)))
    :effect
      (hidden ?character)
    :agents
      (?character)
  )

  ;; A character eats.
  (:action eat
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (hungry ?character)
      (at ?character ?place)
      (has-food ?place))
    :effect
      (fed ?character)
    :agents
      (?character)
  )

  ;; A character scares another character.
  (:action scare
    :parameters
      (?scarer - character ?scaree - character)
    :precondition
      (and (not (scared ?scaree))
      (not (= ?scarer ?scaree)))
    :effect
      (scared ?scaree)
    :agents
      (?scarer)
  )

  ;; A character makes a loud noise.
  (:action make-noise
    :parameters
      (?character - character)
    :precondition
      (and (not (deaf ?character))
      (hidden ?character))
    :effect
      (not (scared ?character))
    :agents
      (?character)
  )
)