(define (domain mistaken-identity)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants translator - object)
  (:predicates
    (abducted ?character - character)
    (has ?character - character ?object - object)
    (knows ?character - character ?expression - expression)
    (intends ?character - character ?expression - expression)
    (understands ?character - character ?expression - expression)
    (alive ?character - character)
  )

  ;; A character takes an object from another character.
  (:action take
    :parameters
      (?taker - character ?object - object ?giver - character)
    :precondition
      (and (alive ?taker)
      (alive ?giver)
      (at ?taker ?place)
      (at ?giver ?place)
      (has ?giver ?object))
    :effect
      (and (not (has ?giver ?object))
      (has ?taker ?object))
    :agents
      (?taker ?giver)
  )

  ;; A character communicates an expression to another character.
  (:action communicate
    :parameters
      (?speaker - character ?listener - character ?expression - expression)
    :precondition
      (and (alive ?speaker)
      (alive ?listener)
      (at ?speaker ?place)
      (at ?listener ?place)
      (understands ?listener ?expression))
    :effect
      (knows ?listener ?expression))
    :agents
      (?speaker ?listener)
  )

  ;; A character lies to another character.
  (:action lie
    :parameters
      (?liar - character ?lie - expression ?listener - character)
    :precondition
      (and (alive ?liar)
      (alive ?listener)
      (at ?liar ?place)
      (at ?listener ?place)
      (intends ?liar ?lie)
      (understands ?listener (not ?lie)))
    :effect
      (knows ?listener ?lie))
    :agents
      (?liar ?listener)
  )

  ;; A character is executed.
  (:action execute
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (not (alive ?character)))
    :agents
      (?character)
  )

  ;; A character intends to keep another character alive.
  (:axiom
    :vars
      (?character - character ?other - character)
    :context
      (intends ?character (alive ?other))
    :implies
      (alive ?other)
  )

  ;; A character intends to keep another character dead.
  (:axiom
    :vars
      (?character - character ?other - character)
    :context
      (intends ?character (not (alive ?other)))
    :implies
      (not (alive ?other))
  )

  ;; A character understands an expression if they have a translator.
  (:axiom
    :vars
      (?character - character ?expression - expression)
    :context
      (has ?character translator)
    :implies
      (understands ?character ?expression)
  )

  ;; A character does not understand an expression if they do not have a translator.
  (:axiom
    :vars
      (?character - character ?expression - expression)
    :context
      (not (has ?character translator))
    :implies
      (not (understands ?character ?expression))
  )
)