(define (domain tim-handprint)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (has ?character - character ?object - object)
    (found ?character - character ?object - object)
    (made-handprint ?character - character)
    (celebrated ?character - character)
  )

  ;; A character finds an object.
  (:action find
    :parameters
      (?character - character ?object - object)
    :precondition
      (not (found ?character ?object))
    :effect
      (found ?character ?object)
    :agents
      (?character)
  )

  ;; A character makes a handprint.
  (:action make-handprint
    :parameters
      (?character - character)
    :precondition
      (found ?character colors)
    :effect
      (made-handprint ?character)
    :agents
      (?character)
  )

  ;; A character shows their handprint to another character.
  (:action show-handprint
    :parameters
      (?shower - character ?viewer - character)
    :precondition
      (and (made-handprint ?shower)
      (not (= ?shower ?viewer)))
    :effect
      (celebrated ?viewer)
    :agents
      (?shower ?viewer)
  )

  ;; Characters celebrate with a party.
  (:action celebrate
    :parameters
      (?celebrator - character ?celebratee - character)
    :precondition
      (and (celebrated ?celebrator)
      (not (= ?celebrator ?celebratee)))
    :effect
      (celebrated ?celebratee)
    :agents
      (?celebrator ?celebratee)
  )
)