(define (domain lucy-paints)
  (:requirements :strips :typing :equality)
  (:types character item - object)
  (:predicates
    (has ?character - character ?item - item)
    (at ?character - character ?location - object)
    (painting ?character - character)
  )

  ;; A character takes an item.
  (:action take
    :parameters
      (?character - character ?item - item ?location - object)
    :precondition
      (and (at ?character ?location)
      (at ?item ?location))
    :effect
      (and (not (at ?item ?location))
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character puts an item.
  (:action put
    :parameters
      (?character - character ?item - item ?location - object)
    :precondition
      (and (has ?character ?item)
      (at ?character ?location))
    :effect
      (and (not (has ?character ?item))
      (at ?item ?location))
    :agents
      (?character)
  )

  ;; A character paints a picture.
  (:action paint
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (has ?character paints)
      (at ?character ?location))
    :effect
      (painting ?character)
    :agents
      (?character)
  )
)