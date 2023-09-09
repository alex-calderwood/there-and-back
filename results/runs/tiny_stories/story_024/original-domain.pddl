(define (domain frog-and-whale)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (friends ?character1 - character ?character2 - character)
    (happy ?character - character)
    (scared ?character - character)
    (play ?character1 - character ?character2 - character)
    (grow ?character - character)
    (whale ?character - character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action make-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (friends ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (not (happy ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes scared.
  (:action become-scared
    :parameters
      (?character - character)
    :precondition
      (not (scared ?character))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; Two characters play together.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (friends ?character1 ?character2)
    :effect
      (play ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character grows.
  (:action grow-up
    :parameters
      (?character - character)
    :precondition
      (not (grow ?character))
    :effect
      (grow ?character)
    :agents
      (?character)
  )

  ;; A character becomes a whale.
  (:action become-whale
    :parameters
      (?character - character)
    :precondition
      (not (whale ?character))
    :effect
      (whale ?character)
    :agents
      (?character)
  )
)