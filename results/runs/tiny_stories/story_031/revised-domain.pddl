(define (domain gifted-girl)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (has-skin ?character - character)
    (kneel ?character - character)
    (rewarded ?character - character)
    (tried ?character - character)
    (voice-happy ?character - character)
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

  ;; A character kneels.
  (:action kneel
    :parameters
      (?character - character)
    :precondition
      (at ?character old-house)
    :effect
      (kneel ?character)
    :agents
      (?character)
  )

  ;; A character tries to do something special.
  (:action try
    :parameters
      (?character - character)
    :precondition
      (kneel ?character)
    :effect
      (tried ?character)
    :agents
      (?character)
  )

  ;; The voice evaluates the character's attempt.
  (:action evaluate
    :parameters
      (?character - character)
    :precondition
      (tried ?character)
    :effect
      (voice-happy ?character)
    :agents
      (?character)
  )

  ;; The voice rewards the character.
  (:action reward
    :parameters
      (?character - character)
    :precondition
      (voice-happy ?character)
    :effect
      (rewarded ?character)
    :agents
      (?character)
  )

  ;; The voice takes away the character's skin.
  (:action take-skin
    :parameters
      (?character - character)
    :precondition
      (and (not (voice-happy ?character))
      (has-skin ?character))
    :effect
      (not (has-skin ?character))
    :agents
      (?character)
  )
)