(define (domain ant-and-bird)
  (:requirements :strips :typing :equality)
  (:types object - physical-object ant bird - object)
  (:predicates
    (at ?object - object ?location - object)
    (holding ?object - object ?item - object)
    (broken ?object - object)
  )

  ;; A character travels from one location to another.
  (:action move
    :parameters
      (?object - object ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?object ?from))
    :effect
      (and (not (at ?object ?from))
      (at ?object ?to))
  )

  ;; A bird hits an object with its beak.
  (:action hit
    :parameters
      (?bird - bird ?object - object)
    :precondition
      (and (at ?bird ?object))
    :effect
      (and (broken ?object))
    :agents
      (?bird)
  )

  ;; An ant tries to enter an object.
  (:action enter
    :parameters
      (?ant - ant ?object - object)
    :precondition
      (and (at ?ant ?object)
      (not (broken ?object)))
    :effect
      (and (not (holding ?ant ?object))
      (holding ?ant ?object))
    :agents
      (?ant)
  )

  ;; An ant eats an object.
  (:action eat
    :parameters
      (?ant - ant ?object - object)
    :precondition
      (and (holding ?ant ?object)
      (not (broken ?object)))
    :effect
      (and (not (holding ?ant ?object)))
    :agents
      (?ant)
  )
)