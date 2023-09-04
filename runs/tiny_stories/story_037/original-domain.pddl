(define (domain dog-and-cat)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (happy ?character - character)
    (sad ?character - character)
    (trusts ?character1 - character ?character2 - character)
    (tricked ?character1 - character ?character2 - character)
    (searched-for-bone ?character - character)
    (gave-treat ?character1 - character ?character2 - character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (sad ?character)
    :effect
      (and (not (sad ?character))
      (happy ?character))
    :agents
      (?character)
  )

  ;; A character becomes sad.
  (:action become-sad
    :parameters
      (?character - character)
    :precondition
      (happy ?character)
    :effect
      (and (not (happy ?character))
      (sad ?character))
    :agents
      (?character)
  )

  ;; A character trusts another character.
  (:action trust
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (trusts ?character1 ?character2))
    :effect
      (trusts ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character searches for a bone.
  (:action search-for-bone
    :parameters
      (?character - character)
    :effect
      (searched-for-bone ?character)
    :agents
      (?character)
  )

  ;; A character gives a treat to another character.
  (:action give-treat
    :parameters
      (?character1 - character ?character2 - character)
    :effect
      (gave-treat ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character tricks another character.
  (:action trick
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (trusts ?character2 ?character1)
    :effect
      (tricked ?character1 ?character2)
    :agents
      (?character1)
  )
)