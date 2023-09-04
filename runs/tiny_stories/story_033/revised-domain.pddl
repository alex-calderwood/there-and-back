(define (domain jack-and-the-lie)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?place - object)
    (happy ?character - character)
    (sad ?character - character)
    (offered-snack ?giver - character ?receiver - character)
    (snack-is-lie ?giver - character ?receiver - character)
    (trusts ?character1 - character ?character2 - character)
    (compassionate ?character - character)
  )

  ;; A character goes to another character's place.
  (:action go-to-place
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (at ?character1 ?character2))
      (happy ?character1))
    :effect
      (and (at ?character1 ?character2)
      (not (happy ?character1)))
    :agents
      (?character1)
  )

  ;; A character offers a snack to another character.
  (:action offer-snack
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (at ?receiver ?giver)
      (compassionate ?giver))
    :effect
      (offered-snack ?giver ?receiver)
    :agents
      (?giver)
  )

  ;; A character reveals that the snack is a lie.
  (:action reveal-lie
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (offered-snack ?giver ?receiver)
      (not (compassionate ?giver)))
    :effect
      (and (snack-is-lie ?giver ?receiver)
      (not (happy ?receiver))
      (sad ?receiver))
    :agents
      (?giver)
  )

  ;; A character runs away from another character.
  (:action run-away
    :parameters
      (?runner - character ?from - character)
    :precondition
      (and (at ?runner ?from)
      (sad ?runner))
    :effect
      (and (not (at ?runner ?from))
      (not (trusts ?runner ?from)))
    :agents
      (?runner)
  )

  ;; A character learns a lesson.
  (:action learn-lesson
    :parameters
      (?character - character)
    :precondition
      (and (sad ?character)
      (not (trusts ?character ?character)))
    :effect
      (and (not (sad ?character))
      (happy ?character))
    :agents
      (?character)
  )
)