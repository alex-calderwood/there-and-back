(define (domain survivor-type)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables :intentionality)
  (:types character - object skill-type - expression)
  (:constants stealth-type - skill-type)
  (:predicates
    (at ?character - character ?location - location)
    (alive ?character - character)
    (has-skill ?character - character ?skill - skill-type)
    (enemy ?character - character ?enemy - character)
    (in-range ?attacker - character ?target - character)
    (dead ?character - character)
    (conquered ?character - character)
    (intends ?character - character ?predicate - predicate)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character attacks another character with a weapon.
  (:action attack
    :parameters
      (?attacker - character ?target - character ?weapon - expression)
    :precondition
      (and (alive ?attacker)
      (alive ?target)
      (in-range ?attacker ?target)
      (has-skill ?attacker ?weapon)
      (not (has-skill ?target ?weapon)))
    :effect
      (and (not (alive ?target))
      (intends ?attacker (conquered ?target)))
    :agents
      (?attacker)
  )

  ;; A character conquers another character.
  (:action conquer
    :parameters
      (?conqueror - character ?conquered - character)
    :precondition
      (and (alive ?conqueror)
      (alive ?conquered)
      (intends ?conqueror (conquered ?conquered)))
    :effect
      (and (not (alive ?conquered))
      (conquered ?conquered))
    :agents
      (?conqueror)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
  )

  ;; A character intends to conquer another character.
  (:action intend-conquer
    :parameters
      (?conqueror - character ?conquered - character)
    :precondition
      (alive ?conqueror)
    :effect
      (intends ?conqueror (conquered ?conquered))
    :agents
      (?conqueror)
  )

  ;; A character intends to move to a location.
  (:action intend-move
    :parameters
      (?character - character ?location - location)
    :precondition
      (alive ?character)
    :effect
      (intends ?character (at ?character ?location))
    :agents
      (?character)
  )

  ;; A character intends to attack another character with a weapon.
  (:action intend-attack
    :parameters
      (?attacker - character ?target - character ?weapon - expression)
    :precondition
      (alive ?attacker)
    :effect
      (intends ?attacker (and (in-range ?attacker ?target)
      (has-skill ?attacker ?weapon)
      (not (has-skill ?target ?weapon)))))
)