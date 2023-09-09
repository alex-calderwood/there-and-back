(define (domain break-in)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?place - object)
    (has ?character - character ?item - object)
    (alive ?character - character)
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

  ;; A character takes an item from another.
  (:action take
    :parameters
      (?taker - character ?item - object ?victim - character ?place - object)
    :precondition
      (and (not (= ?taker ?victim))
      (alive ?taker)
      (at ?taker ?place)
      (at ?victim ?place)
      (has ?victim ?item))
    :effect
      (and (not (has ?victim ?item))
      (has ?taker ?item))
    :agents
      (?taker)
  )

  ;; A character leaves an item behind.
  (:action leave
    :parameters
      (?character - character ?item - object ?place - object)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (at ?item ?place))
    :agents
      (?character)
  )

  ;; A character calls 911.
  (:action call-911
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )
)