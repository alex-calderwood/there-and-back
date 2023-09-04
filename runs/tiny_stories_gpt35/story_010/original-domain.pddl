(define (domain skelly-cake)
  (:requirements :strips :typing :equality)
  (:types character - object)
  (:predicates
    (at ?character - character)
    (has-mixing-bowl)
    (has-flour)
    (has-sugar)
    (has-eggs)
    (has-milk)
    (has-oven)
    (has-cake)
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
  )

  ;; A character takes an object.
  (:action take
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (at ?character ?object))
    :effect
      (and (not (at ?character ?object))
      (has ?character ?object))
  )

  ;; A character puts an object.
  (:action put
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (has ?character ?object))
    :effect
      (and (not (has ?character ?object))
      (at ?character ?object))
  )

  ;; A character mixes ingredients.
  (:action mix
    :parameters
      (?character - character)
    :precondition
      (and (at ?character has-mixing-bowl)
      (has ?character has-flour)
      (has ?character has-sugar)
      (has ?character has-eggs)
      (has ?character has-milk))
    :effect
      (and (not (has ?character has-flour))
      (not (has ?character has-sugar))
      (not (has ?character has-eggs))
      (not (has ?character has-milk))
      (has ?character has-cake))
  )

  ;; A character bakes the cake.
  (:action bake
    :parameters
      (?character - character)
    :precondition
      (and (at ?character has-cake)
      (has ?character has-oven))
    :effect
      (and (not (has ?character has-cake))
      (at ?character has-cake))
  )
)