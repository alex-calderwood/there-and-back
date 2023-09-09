(define (domain farm-life)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (friend ?character1 - character ?character2 - character)
    (happy ?character - character)
    (sad ?character - character)
    (ready ?character - character)
    (practice ?character1 - character ?character2 - character)
  )

  ;; A character becomes friends with another character.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (friend ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character cheers up another character.
  (:action cheer-up
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (friend ?character1 ?character2)
      (sad ?character2))
    :effect
      (and (not (sad ?character2))
      (happy ?character2))
    :agents
      (?character1)
  )

  ;; A character helps another character practice.
  (:action help-practice
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (friend ?character1 ?character2)
      (not (ready ?character2)))
    :effect
      (practice ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes ready after practicing.
  (:action become-ready
    :parameters
      (?character - character)
    :precondition
      (practice ?character)
    :effect
      (ready ?character)
    :agents
      (?character)
  )

)