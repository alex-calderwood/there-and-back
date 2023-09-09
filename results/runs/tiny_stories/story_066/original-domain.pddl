(define (domain surprise-gifts)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (happy ?character - character)
    (gave-gift ?giver - character ?receiver - character ?item - item)
  )

  ;; A character finds an item.
  (:action find
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (has ?character ?item)))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character gives an item to another character.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver ?place)
      (has ?giver ?item)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item)
      (gave-gift ?giver ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; A character plays with an item.
  (:action play
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (at ?character ?place)
      (has ?character ?item))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character makes another character happy.
  (:action make-happy
    :parameters
      (?character - character ?target - character)
    :precondition
      (and (not (= ?character ?target))
      (not (happy ?target)))
    :effect
      (happy ?target)
    :agents
      (?character)
  )
)