(define (domain tim-and-puppy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (tired ?character - character)
    (happy ?character - character)
    (found ?character - character ?object - object)
    (playing-together ?character1 - character ?character2 - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character finds an object.
  (:action find-object
    :parameters
      (?character - character ?object - object ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (found ?character ?object)))
    :effect
      (found ?character ?object)
    :agents
      (?character)
  )

  ;; A character becomes tired.
  (:action become-tired
    :parameters
      (?character - character)
    :precondition
      (not (tired ?character))
    :effect
      (tired ?character)
    :agents
      (?character)
  )

  ;; A character becomes not tired.
  (:action become-not-tired
    :parameters
      (?character - character)
    :precondition
      (tired ?character)
    :effect
      (not (tired ?character))
    :agents
      (?character)
  )

  ;; Two characters play together.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (playing-together ?character1 ?character2)))
    :effect
      (playing-together ?character1 ?character2)
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
)