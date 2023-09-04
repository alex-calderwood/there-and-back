(define (domain anna-and-lily)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character doll - object mirror - item)
  (:predicates
    (has ?character - character ?item - item)
    (broken ?doll - doll)
    (scared ?character - character)
    (trick-mirror ?mirror - mirror)
    (holding ?character - character ?doll - doll)
    (at ?character - character ?location - place)
    (hug ?character - character ?doll - doll)
  )

  ;; A character picks up a doll.
  (:action pick-up
    :parameters
      (?character - character ?doll - doll)
    :precondition
      (and (alive ?character)
      (not (holding ?character ?doll)))
    :effect
      (holding ?character ?doll)
    :agents
      (?character)
  )

  ;; A character drops a doll.
  (:action drop
    :parameters
      (?character - character ?doll - doll)
    :precondition
      (and (alive ?character)
      (holding ?character ?doll))
    :effect
      (and (not (holding ?character ?doll))
      (broken ?doll))
    :agents
      (?character)
  )

  ;; A character gets scared.
  (:action get-scared
    :parameters
      (?character - character ?mirror - mirror)
    :precondition
      (and (alive ?character)
      (has ?character ?mirror)
      (trick-mirror ?mirror))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character hugs a doll.
  (:action hug
    :parameters
      (?character - character ?doll - doll)
    :precondition
      (and (alive ?character)
      (not (scared ?character))
      (holding ?character ?doll))
    :effect
      (hug ?character ?doll)
    :agents
      (?character)
  )

  ;; A character moves to a location.
  (:action move
    :parameters
      (?character - character ?location - place)
    :precondition
      (and (alive ?character)
      (not (at ?character ?location)))
    :effect
      (at ?character ?location)
    :agents
      (?character)
  )
)