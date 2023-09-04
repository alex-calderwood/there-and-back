(define (domain office-life)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (hungry ?character - character)
    (has-supplies ?character - character)
    (knows ?character - character ?other - character)
    (wearing ?character - character ?outfit - object)
    (feels ?character - character ?emotion - object)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character gets supplies.
  (:action get-supplies
    :parameters
      (?character - character)
    :precondition
      (not (has-supplies ?character))
    :effect
      (has-supplies ?character)
    :agents
      (?character)
  )

  ;; A character meets another character.
  (:action meet
    :parameters
      (?character - character ?other - character)
    :precondition
      (not (knows ?character ?other))
    :effect
      (knows ?character ?other)
    :agents
      (?character)
  )

  ;; A character changes their outfit.
  (:action change-outfit
    :parameters
      (?character - character ?outfit - object)
    :precondition
      (not (wearing ?character ?outfit))
    :effect
      (wearing ?character ?outfit)
    :agents
      (?character)
  )

  ;; A character feels an emotion.
  (:action feel
    :parameters
      (?character - character ?emotion - object)
    :precondition
      (not (feels ?character ?emotion))
    :effect
      (feels ?character ?emotion)
    :agents
      (?character)
  )

  ;; A character eats to satisfy their hunger.
  (:action eat
    :parameters
      (?character - character)
    :precondition
      (hungry ?character)
    :effect
      (not (hungry ?character))
    :agents
      (?character)
  )
)