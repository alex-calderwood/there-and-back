(define (domain killer)
  (:requirements :strips :negative-preconditions :typing :equality :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (alive ?character - character)
    (trapped ?location - object)
    (knows ?character - character ?predicate - predicate)
    (intends ?character - character ?predicate - predicate)
    (has ?character - character ?object - object)
    (tied-up ?character - character)
    (bleeding ?character - character)
    (sawing ?character - character)
    (killer ?character - character)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
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

  ;; A character checks for traps at a location.
  (:action check-traps
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (trapped ?location))
    :effect
      (knows ?character (not (trapped ?location)))
    :agents
      (?character)
  )

  ;; A character ties up another character.
  (:action tie-up
    :parameters
      (?tyer - character ?victim - character)
    :precondition
      (and (alive ?tyer)
      (alive ?victim)
      (at ?tyer ?location)
      (at ?victim ?location)
      (not (tied-up ?victim)))
    :effect
      (and (tied-up ?victim)
      (not (alive ?victim)))
    :agents
      (?tyer)
  )

  ;; A character stops the bleeding of another character.
  (:action stop-bleeding
    :parameters
      (?character - character ?victim - character)
    :precondition
      (and (alive ?character)
      (alive ?victim)
      (at ?character ?location)
      (at ?victim ?location)
      (bleeding ?victim))
    :effect
      (not (bleeding ?victim))
    :agents
      (?character)
  )

  ;; A character saws off a limb of another character.
  (:action saw-limb
    :parameters
      (?sawer - character ?victim - character)
    :precondition
      (and (alive ?sawer)
      (alive ?victim)
      (at ?sawer ?location)
      (at ?victim ?location)
      (tied-up ?victim)
      (bleeding ?victim))
    :effect
      (and (not (bleeding ?victim))
      (not (tied-up ?victim))
      (not (alive ?victim))
      (sawing ?sawer))
    :agents
      (?sawer)
  )

  ;; A character intends to kill another character.
  (:action intend-to-kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim)
      (at ?killer ?location)
      (at ?victim ?location)
      (not (intends ?killer (killer ?victim))))
    :effect
      (intends ?killer (killer ?victim))
    :agents
      (?killer)
  )

  ;; A character cancels their intention to kill another character.
  (:action cancel-intention-to-kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim)
      (at ?killer ?location)
      (at ?victim ?location)
      (intends ?killer (killer ?victim)))
    :effect
      (not (intends ?killer (killer ?victim)))
    :agents
      (?killer)
  )

  ;; A character is killed by another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim)
      (at ?killer ?location)
      (at ?victim ?location)
      (intends ?killer (killer ?victim)))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )
)