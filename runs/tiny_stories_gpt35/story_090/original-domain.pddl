(define (domain lonely-boy)
  (:requirements :adl :expression-variables :intentionality)
  (:types character toy - object)
  (:constants ben - toy)
  (:predicates
    (alive ?character - character)
    (at ?toy - toy ?place - object)
    (has ?character - character ?toy - toy)
    (friend ?character - character ?toy - toy)
    (scared ?toy - toy)
    (talking ?toy - toy)
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

  ;; A toy talks to a character.
  (:action talk
    :parameters
      (?toy - toy ?character - character)
    :precondition
      (and (alive ?character)
      (at ?toy ?place)
      (at ?character ?place)
      (talking ?toy)
      (scared ?toy))
    :effect
      (and (not (scared ?toy))
      (friend ?character ?toy))
    :agents
      (?toy)
  )

  ;; A character takes a toy from another character.
  (:action take
    :parameters
      (?taker - character ?toy - toy ?giver - character ?place - object)
    :precondition
      (and (not (= ?taker ?giver))
      (alive ?taker)
      (at ?taker ?place)
      (at ?giver ?place)
      (has ?giver ?toy))
    :effect
      (and (not (has ?giver ?toy))
      (has ?taker ?toy))
    :agents
      (?taker)
  )

  ;; A character stands up to another character.
  (:action stand-up
    :parameters
      (?stander - character ?bully - character ?place - object)
    :precondition
      (and (alive ?stander)
      (alive ?bully)
      (at ?stander ?place)
      (at ?bully ?place))
    :effect
      (and (intends ?stander (friend ?stander ben))
      (not (intends ?bully (has ?bully ben))))
    :agents
      (?stander)
  )
)