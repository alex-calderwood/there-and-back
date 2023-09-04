(define (domain bunny-bird-friends)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (happy ?character - character)
    (tired ?character - character)
    (played-together ?character1 - character ?character2 - character)
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

  ;; Two characters play together.
  (:action play
    :parameters
      (?character1 - character ?character2 - character ?place - place)
    :precondition
      (and (not (= ?character1 ?character2))
      (at ?character1 ?place)
      (at ?character2 ?place))
    :effect
      (and (played-together ?character1 ?character2)
      (happy ?character1)
      (happy ?character2)
      (tired ?character1)
      (tired ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; A character rests.
  (:action rest
    :parameters
      (?character - character)
    :precondition
      (tired ?character)
    :effect
      (not (tired ?character))
    :agents
      (?character)
  )
)