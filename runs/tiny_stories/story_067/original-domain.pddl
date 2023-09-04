(define (domain toy-factory)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (worker ?character - character)
    (clean ?place - object)
    (makes-toys ?character - character)
    (nervous ?character - character)
    (friends-with ?character1 - character ?character2 - character)
    (happy ?character - character)
  )

  ;; A character starts working at the factory.
  (:action start-working
    :parameters
      (?character - character)
    :effect
      (worker ?character)
    :agents
      (?character)
  )

  ;; A character cleans the factory.
  (:action clean-factory
    :parameters
      (?character - character)
    :precondition
      (worker ?character)
    :effect
      (clean factory)
    :agents
      (?character)
  )

  ;; A character makes toys.
  (:action make-toys
    :parameters
      (?character - character)
    :precondition
      (worker ?character)
    :effect
      (makes-toys ?character)
    :agents
      (?character)
  )

  ;; A character becomes friends with another character.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (worker ?character1)
      (worker ?character2)
      (not (= ?character1 ?character2)))
    :effect
      (friends-with ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (worker ?character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes less nervous.
  (:action become-less-nervous
    :parameters
      (?character - character)
    :precondition
      (and (worker ?character)
      (nervous ?character))
    :effect
      (not (nervous ?character))
    :agents
      (?character)
  )
)