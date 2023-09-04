(define (domain mcdonalds-on-mars)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants mars earth - object)
  (:predicates
    (at ?character - character ?place - object)
    (has ?character - character ?food - object)
    (alive ?character - character)
    (intends ?character - character ?predicate - expression)
    (communicated ?character - character ?message - expression)
    (understands ?character - character ?message - expression)
    (equal ?expression1 - expression ?expression2 - expression)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character communicates a message to another.
  (:action communicate
    :parameters
      (?speaker - character ?listener - character ?message - expression)
    :precondition
      (and (alive ?speaker)
      (alive ?listener)
      (at ?speaker earth)
      (at ?listener mars)
      (intends ?speaker (equal ?message ?message))
      (intends ?listener (understands ?listener ?message)))
    :effect
      (and (communicated ?speaker ?message)
      (understands ?listener ?message))
    :agents
      (?speaker ?listener)
  )

  ;; A character takes food from a McDonald's on Mars.
  (:action take-food
    :parameters
      (?character - character ?food - object)
    :precondition
      (and (alive ?character)
      (at ?character mars)
      (has ?character ?food))
    :effect
      (not (has ?character ?food))
    :agents
      (?character)
  )

  ;; A character gives food to another.
  (:action give-food
    :parameters
      (?giver - character ?food - object ?receiver - character)
    :precondition
      (and (alive ?giver)
      (at ?giver mars)
      (has ?giver ?food)
      (alive ?receiver)
      (at ?receiver mars))
    :effect
      (and (not (has ?giver ?food))
      (has ?receiver ?food))
    :agents
      (?giver ?receiver)
  )

  ;; A character understands a message that is equal to another message.
  (:axiom
    :vars
      (?character - character ?message1 - expression ?message2 - expression)
    :context
      (and (intends ?character (equal ?message1 ?message2))
      (understands ?character ?message1))
    :implies
      (understands ?character ?message2)
  )

  ;; A character understands a message that has been communicated to them.
  (:axiom
    :vars
      (?character - character ?message - expression)
    :context
      (communicated ?speaker ?message)
    :implies
      (understands ?character ?message)
  )
)