(define (domain kevins-intruder)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character room - object item - thing)
  (:predicates
    (at ?character - character ?room - room)
    (has-key ?character - character)
    (has ?character - character ?item - item)
    (in ?item - item ?room - room)
    (sick ?character - character)
    (called-911 ?character - character)
  )

  ;; A character moves from one room to another.
  (:action move
    :parameters
      (?character - character ?from - room ?to - room)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character takes an item from a room.
  (:action take-item
    :parameters
      (?character - character ?item - item ?room - room)
    :precondition
      (and (at ?character ?room)
      (in ?item ?room))
    :effect
      (and (not (in ?item ?room))
      (has ?character ?item))
    :agents  (?character)
  )

  ;; A character leaves an item in a room.
  (:action leave-item
    :parameters
      (?character - character ?item - item ?room - room)
    :precondition
      (and (at ?character ?room)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (in ?item ?room))
    :agents  (?character)
  )

  ;; A character calls 911.
  (:action call-911
    :parameters
      (?caller - character ?sick-person - character)
    :precondition
      (and (sick ?sick-person)
      (not (called-911 ?caller ?sick-person)))
    :effect
      (called-911 ?caller ?sick-person)
    :agents  (?caller)
  )
)