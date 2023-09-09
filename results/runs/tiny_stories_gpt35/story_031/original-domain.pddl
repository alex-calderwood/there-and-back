(define (domain gifted-girl)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants voice - character)
  (:predicates
    (has-skin ?character - character)
    (kneeling ?character - character)
    (visited ?character - character)
    (rewarded ?character - character)
    (upset ?character - character)
  )

  ;; A character kneels before the voice.
  (:action kneel
    :parameters
      (?character - character)
    :precondition
      (and (not (kneeling ?character))
      (has-skin ?character))
    :effect
      (kneeling ?character)
    :agents
      (?character)
  )

  ;; The voice rewards a character.
  (:action reward
    :parameters
      (?character - character)
    :precondition
      (and (kneeling ?character)
      (not (rewarded ?character)))
    :effect
      (rewarded ?character)
    :agents
      (voice)
  )

  ;; The voice takes away a character's skin.
  (:action take-skin
    :parameters
      (?character - character)
    :precondition
      (and (kneeling ?character)
      (not (rewarded ?character))
      (has-skin ?character))
    :effect
      (and (not (has-skin ?character))
      (upset ?character))
    :agents
      (voice)
  )

  ;; A character visits the old house.
  (:action visit
    :parameters
      (?character - character)
    :precondition
      (not (visited ?character))
    :effect
      (visited ?character)
    :agents
      (?character)
  )

  ;; A character vows to never visit the old house again.
  (:action vow
    :parameters
      (?character - character)
    :precondition
      (and (visited ?character)
      (upset ?character))
    :effect
      (not (visited ?character))
    :agents
      (?character)
  )
)