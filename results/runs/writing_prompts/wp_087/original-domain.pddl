(define (domain cecil-and-the-crone)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (injured ?character - character)
    (messy ?character - character)
    (cooking ?character - character)
    (burning ?character - character)
    (summoned ?character - character)
    (knows-cooking ?character - character)
  )

  ;; A character injures themselves.
  (:action injure
    :parameters
      (?character - character)
    :precondition
      (not (injured ?character))
    :effect
      (injured ?character)
    :agents
      (?character)
  )

  ;; A character makes a mess.
  (:action make-mess
    :parameters
      (?character - character)
    :precondition
      (not (messy ?character))
    :effect
      (messy ?character)
    :agents
      (?character)
  )

  ;; A character starts cooking.
  (:action start-cooking
    :parameters
      (?character - character)
    :precondition
      (not (cooking ?character))
    :effect
      (cooking ?character)
    :agents
      (?character)
  )

  ;; A character sets something on fire.
  (:action set-fire
    :parameters
      (?character - character)
    :precondition
      (not (burning ?character))
    :effect
      (burning ?character)
    :agents
      (?character)
  )

  ;; A character summons another character.
  (:action summon
    :parameters
      (?summoner - character ?summoned - character)
    :precondition
      (and (not (summoned ?summoned))
      (messy ?summoner))
    :effect
      (summoned ?summoned)
    :agents
      (?summoner)
  )

  ;; A character learns cooking from another character.
  (:action learn-cooking
    :parameters
      (?learner - character ?teacher - character)
    :precondition
      (and (not (knows-cooking ?learner))
      (knows-cooking ?teacher))
    :effect
      (knows-cooking ?learner)
    :agents
      (?learner ?teacher)
  )
)