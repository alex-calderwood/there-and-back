(define (domain wally-and-wilma)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (knows ?character1 - character ?character2 - character)
    (together ?character1 - character ?character2 - character)
    (missing ?character - character)
    (relationship ?character1 - character ?character2 - character)
    (searching ?searcher - character ?target - character)
    (found ?searcher - character ?target - character)
  )

  ;; A character starts searching for another character.
  (:action start-search
    :parameters
      (?searcher - character ?target - character)
    :precondition
      (and (not (= ?searcher ?target))
      (not (searching ?searcher ?target))
      (missing ?target))
    :effect
      (searching ?searcher ?target)
    :agents
      (?searcher)
  )

  ;; A character stops searching for another character.
  (:action stop-search
    :parameters
      (?searcher - character ?target - character)
    :precondition
      (searching ?searcher ?target)
    :effect
      (not (searching ?searcher ?target))
    :agents
      (?searcher)
  )

  ;; A character finds another character.
  (:action find
    :parameters
      (?searcher - character ?target - character)
    :precondition
      (and (searching ?searcher ?target)
      (missing ?target))
    :effect
      (and (not (missing ?target))
      (found ?searcher ?target))
    :agents
      (?searcher)
  )

  ;; A character starts a relationship with another character.
  (:action start-relationship
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (relationship ?character1 ?character2))
      (knows ?character1 ?character2))
    :effect
      (relationship ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character ends a relationship with another character.
  (:action end-relationship
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (relationship ?character1 ?character2)
    :effect
      (not (relationship ?character1 ?character2))
    :agents
      (?character1 ?character2)
  )
)