(define (domain tim-zigzag)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object place - location)
  (:predicates
    (at ?object - object ?place - location)
    (happy ?character - character)
    (can-fly ?animal - animal)
    (can-run ?character - character)
    (playing ?character - character ?animal - animal)
  )

  ;; A character and an animal play together.
  (:action play
    :parameters
      (?character - character ?animal - animal ?place - location)
    :precondition
      (and (at ?character ?place)
      (at ?animal ?place))
    :effect
      (playing ?character ?animal)
    :agents
      (?character)
  )

  ;; A character and an animal stop playing.
  (:action stop-playing
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (playing ?character ?animal)
    :effect
      (not (playing ?character ?animal))
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character moves to a different location.
  (:action move
    :parameters
      (?object - object ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (at ?object ?from))
    :effect
      (and (not (at ?object ?from))
      (at ?object ?to))
    :agents
      (?object)
  )

  ;; A character can run.
  (:action can-run
    :parameters
      (?character - character)
    :effect
      (can-run ?character)
    :agents
      (?character)
  )

  ;; An animal can fly.
  (:action can-fly
    :parameters
      (?animal - animal)
    :effect
      (can-fly ?animal)
    :agents
      (?animal)
  )
)