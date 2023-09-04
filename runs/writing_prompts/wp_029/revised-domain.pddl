(define (domain dragon-guard)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character gang - object place - object)
  (:predicates
    (asleep ?character - character)
    (awake ?character - character)
    (at ?character - character ?place - place)
    (has-hoard ?character - character)
    (robbed ?gang - gang)
    (soundproof-door ?place - place)
    (attacked ?character - character)
  )

  ;; A character goes to sleep.
  (:action sleep
    :parameters
      (?character - character)
    :precondition
      (awake ?character)
    :effect
      (and (not (awake ?character))
      (asleep ?character))
    :agents  (?character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (asleep ?character)
    :effect
      (and (not (asleep ?character))
      (awake ?character))
    :agents  (?character)
  )

  ;; A gang installs a soundproof door.
  (:action install-soundproof-door
    :parameters
      (?gang - character ?place - place)
    :precondition
      (and (awake ?gang)
      (at ?gang ?place)
      (not (soundproof-door ?place)))
    :effect
      (soundproof-door ?place)
    :agents  (?gang)
  )

  ;; A gang robs thieves.
  (:action rob
    :parameters
      (?gang - character)
    :precondition
      (awake ?gang)
    :effect
      (robbed ?gang)
    :agents  (?gang)
  )

  ;; A character attacks another character.
  (:action attack
    :parameters
      (?attacker - character ?victim - character)
    :precondition
      (and (awake ?attacker)
      (awake ?victim))
    :effect
      (attacked ?victim)
    :agents  (?attacker)
  )

  ;; A character clears the passage.
  (:action clear-passage
    :parameters
      (?character - character)
    :precondition
      (awake ?character)
    :effect
      (and (not (attacked ?character))
      (has-hoard ?character))
    :agents  (?character)
  )
)