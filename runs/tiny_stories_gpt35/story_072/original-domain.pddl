(define (domain kitty-and-doggy)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types character - object)
  (:constants shoes - object)
  (:predicates
    (at ?character - character ?location - object)
    (has ?character - character ?object - object)
    (fast ?character - character)
    (magic-word-spoken)
    (shaking)
    (cake ?object - object)
  )

  ;; A character travels from one location to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character takes an object.
  (:action take
    :parameters
      (?character - character ?object - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (at ?object ?location))
    :effect
      (and (not (at ?object ?location))
      (not (has ?character ?object))
      (at ?object ?character)
      (has ?character ?object))
  )

  ;; A character drops an object.
  (:action drop
    :parameters
      (?character - character ?object - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (at ?object ?character)
      (has ?character ?object))
    :effect
      (and (not (at ?object ?character))
      (not (has ?character ?object))
      (at ?object ?location))
  )

  ;; A character speaks the magic word.
  (:action speak-magic-word
    :precondition
      (not (magic-word-spoken))
    :effect
      (magic-word-spoken)
  )

  ;; The cake starts shaking.
  (:action shake-cake
    :precondition
      (and (at ?cake ?location)
      (not (shaking))
      (magic-word-spoken))
    :effect
      (shaking)
  )

  ;; The cake turns into shoes.
  (:action turn-cake-into-shoes
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (at ?cake ?character)
      (shaking))
    :effect
      (and (not (at ?cake ?character))
      (not (has ?character shoes))
      (at shoes ?character)
      (has ?character shoes)
      (fast ?character))
  )
)