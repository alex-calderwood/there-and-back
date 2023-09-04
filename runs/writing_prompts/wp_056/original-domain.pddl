(define (domain robot-soldier)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object weapon - item)
  (:predicates
    (alive ?character - character)
    (armed ?character - character)
    (has ?character - character ?item - item)
    (fights-for ?character - character ?side - character)
    (in-formation ?character - character)
    (eyes-glow-red ?character - character)
    (damaged ?character - character)
    (aware ?character - character)
  )

  ;; A character fires at another character.
  (:action fire
    :parameters
      (?shooter - character ?target - character ?weapon - weapon)
    :precondition
      (and (not (= ?shooter ?target))
      (alive ?shooter)
      (armed ?shooter)
      (has ?shooter ?weapon)
      (alive ?target))
    :effect
      (and (not (alive ?target))
      (intends ?shooter (not (alive ?target))))
    :agents
      (?shooter)
  )

  ;; A character gets damaged.
  (:action damage
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (damaged ?character)))
    :effect
      (damaged ?character)
    :agents
      (?character)
  )

  ;; A character becomes aware.
  (:action become-aware
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (aware ?character)))
    :effect
      (aware ?character)
    :agents
      (?character)
  )

  ;; A character commits suicide.
  (:action suicide
    :parameters
      (?character - character ?weapon - weapon)
    :precondition
      (and (alive ?character)
      (armed ?character)
      (has ?character ?weapon)
      (aware ?character))
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )

  ;; When a character has a weapon, they are armed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (armed ?character))
      (exists (?w - weapon)
      (has ?character ?w)))
    :implies
      (armed ?character)
  )

  ;; When a character does not have a weapon, they are unarmed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (armed ?character)
      (forall (?w - weapon)
      (not (has ?character ?w))))
    :implies
      (not (armed ?character))
  )
)