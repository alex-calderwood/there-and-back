(define (domain dream-world)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (awake ?character - character)
    (dreaming ?character - character)
    (wearing ?character - character ?item - item)
    (disguised ?character - character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (dreaming ?character)
    :effect
      (and (not (dreaming ?character))
      (awake ?character))
    :agents
      (?character)
  )

  ;; A character falls asleep.
  (:action fall-asleep
    :parameters
      (?character - character)
    :precondition
      (awake ?character)
    :effect
      (and (not (awake ?character))
      (dreaming ?character))
    :agents
      (?character)
  )

  ;; A character puts on an item.
  (:action put-on
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (wearing ?character ?item)
    :agents
      (?character)
  )

  ;; A character takes off an item.
  (:action take-off
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (wearing ?character ?item))
    :effect
      (not (wearing ?character ?item))
    :agents
      (?character)
  )

  ;; A character disguises themselves.
  (:action disguise
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (disguised ?character)))
    :effect
      (disguised ?character)
    :agents
      (?character)
  )

  ;; A character removes their disguise.
  (:action remove-disguise
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (disguised ?character))
    :effect
      (not (disguised ?character))
    :agents
      (?character)
  )

  ;; A character attacks another character.
  (:action attack
    :parameters
      (?attacker - character ?victim - character)
    :precondition
      (and (alive ?attacker)
      (alive ?victim))
    :effect
      (not (alive ?victim))
    :agents
      (?attacker)
  )
)