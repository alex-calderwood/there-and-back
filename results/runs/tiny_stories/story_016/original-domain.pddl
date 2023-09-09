(define (domain prince-and-wizard)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (talks-to ?character1 - character ?character2 - character)
    (happy ?character - character)
    (sad ?character - character)
    (careless ?character - character)
    (wise ?character - character)
    (tricked ?character - character)
    (mean ?character - character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (talks-to ?character1 ?character2)))
    :effect
      (talks-to ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character tricks another character.
  (:action trick
    :parameters
      (?tricker - character ?tricked - character)
    :precondition
      (and (not (= ?tricker ?tricked))
      (mean ?tricker)
      (talks-to ?tricked ?tricker)
      (careless ?tricked))
    :effect
      (tricked ?tricked)
    :agents
      (?tricker)
  )

  ;; A character becomes sad.
  (:action become-sad
    :parameters
      (?character - character)
    :precondition
      (and (not (sad ?character))
      (tricked ?character))
    :effect
      (sad ?character)
    :agents
      (?character)
  )

  ;; A character becomes wise.
  (:action become-wise
    :parameters
      (?character - character)
    :precondition
      (and (not (wise ?character))
      (sad ?character))
    :effect
      (wise ?character)
    :agents
      (?character)
  )

  ;; A character becomes unhappy.
  (:action become-unhappy
    :parameters
      (?character - character)
    :precondition
      (and (happy ?character)
      (wise ?character))
    :effect
      (not (happy ?character))
    :agents
      (?character)
  )
)