(define (domain sara-and-spot)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object)
  (:predicates
    (at ?character - character ?place - object)
    (has ?character - character ?animal - animal)
    (friendly ?animal - animal)
    (scared ?character - character)
    (happy ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character pets an animal.
  (:action pet
    :parameters
      (?character - character ?animal - animal ?place - object)
    :precondition
      (and (at ?character ?place)
      (at ?animal ?place)
      (friendly ?animal))
    :effect
      (and (happy ?character)
      (not (scared ?character)))
    :agents
      (?character)
  )

  ;; A character plays with an animal.
  (:action play
    :parameters
      (?character - character ?animal - animal ?place - object)
    :precondition
      (and (at ?character ?place)
      (at ?animal ?place)
      (friendly ?animal))
    :effect
      (and (happy ?character)
      (happy ?animal)
      (not (scared ?character)))
    :agents
      (?character)
  )

  ;; A character throws a ball for an animal.
  (:action throw-ball
    :parameters
      (?character - character ?animal - animal ?place - object)
    :precondition
      (and (at ?character ?place)
      (at ?animal ?place)
      (friendly ?animal))
    :effect
      (and (happy ?character)
      (happy ?animal)
      (not (scared ?character)))
    :agents
      (?character)
  )

  ;; A character introduces themselves to another character.
  (:action introduce
    :parameters
      (?introducer - character ?introducee - character)
    :precondition
      (and (not (= ?introducer ?introducee))
      (at ?introducer ?place)
      (at ?introducee ?place))
    :effect
      (and (not (scared ?introducer))
      (not (scared ?introducee)))
    :agents
      (?introducer)
  )
)