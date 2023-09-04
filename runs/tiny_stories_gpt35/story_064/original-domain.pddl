(define (domain anna-and-lily)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types doll - object)
  (:predicates
    (doll ?doll - doll)
    (broken ?doll - doll)
    (held ?doll - doll)
    (scared ?character - doll)
    (loves ?doll - doll ?character - doll)
    (at ?doll - doll ?place - doll)
    (pretty ?doll - doll)
    (ugly ?doll - doll)
    (monster ?doll - doll)
  )

  ;; A character picks up a doll.
  (:action pick-up
    :parameters
      (?character - doll ?doll - doll)
    :precondition
      (and (not (held ?doll))
      (at ?character ?doll))
    :effect
      (and (not (at ?character ?doll))
      (held ?doll))
    :agents
      (?character)
  )

  ;; A character puts down a doll.
  (:action put-down
    :parameters
      (?character - doll ?doll - doll)
    :precondition
      (held ?doll)
    :effect
      (and (not (held ?doll))
      (at ?character ?doll))
    :agents
      (?character)
  )

  ;; A character hugs a doll.
  (:action hug
    :parameters
      (?character - doll ?doll - doll)
    :precondition
      (and (held ?doll)
      (at ?character ?doll))
    :effect
      (and (loves ?doll ?character))
    :agents
      (?character)
  )

  ;; A doll breaks.
  (:action break
    :parameters
      (?doll - doll)
    :precondition
      (held ?doll)
    :effect
      (and (broken ?doll))
    :agents
      (?doll)
  )

  ;; A doll becomes pretty.
  (:action make-pretty
    :parameters
      (?doll - doll)
    :precondition
      (and (not (ugly ?doll))
      (not (monster ?doll)))
    :effect
      (pretty ?doll)
  )

  ;; A doll becomes ugly.
  (:action make-ugly
    :parameters
      (?doll - doll)
    :precondition
      (and (not (pretty ?doll))
      (not (monster ?doll)))
    :effect
      (ugly ?doll)
  )

  ;; A doll becomes a monster.
  (:action make-monster
    :parameters
      (?doll - doll)
    :precondition
      (and (not (pretty ?doll))
      (not (ugly ?doll)))
    :effect
      (monster ?doll)
  )

  ;; A character becomes scared of a doll.
  (:action scare
    :parameters
      (?character - doll ?doll - doll)
    :precondition
      (and (held ?doll)
      (at ?character ?doll)
      (not (monster ?doll)))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character becomes unscared of a doll.
  (:action unscare
    :parameters
      (?character - doll ?doll - doll)
    :precondition
      (and (held ?doll)
      (at ?character ?doll)
      (not (monster ?doll))
      (scared ?character))
    :effect
      (not (scared ?character))
    :agents
      (?character)
  )
)