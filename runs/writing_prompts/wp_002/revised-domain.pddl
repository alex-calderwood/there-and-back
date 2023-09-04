(define (domain mathematical-love)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (solitary ?character - character)
    (connected ?character1 - character ?character2 - character)
    (irrational-love ?character1 - character ?character2 - character)
    (rational-proof ?character1 - character ?character2 - character)
    (differentiate ?character - character)
    (prime ?character - character)
    (integral-partner ?character1 - character ?character2 - character)
    (fated ?character - character)
    (paired ?character1 - character ?character2 - character)
  )

  ;; A character connects with another character.
  (:action connect
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (connected ?character1 ?character2)))
    :effect
      (connected ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character differentiates from another character.
  (:action differentiate
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (connected ?character1 ?character2))
    :effect
      (not (connected ?character1 ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; A character finds their integral partner.
  (:action find-integral-partner
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (integral-partner ?character1 ?character2))
      (rational-proof ?character1 ?character2))
    :effect
      (integral-partner ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes fated.
  (:action become-fated
    :parameters
      (?character - character)
    :precondition
      (and (not (fated ?character))
      (solitary ?character))
    :effect
      (fated ?character)
    :agents
      (?character)
  )

  ;; A character becomes paired.
  (:action become-paired
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (paired ?character1 ?character2))
      (integral-partner ?character1 ?character2))
    :effect
      (paired ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)