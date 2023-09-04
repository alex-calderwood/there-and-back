(define (domain tim-and-his-wagon)
  (:requirements :strips :typing)
  (:types object - physical-object)
  (:predicates
    (at ?object - object ?location - object)
    (has ?object - object ?item - object)
    (lost ?object - object)
  )

  ;; Tim moves an object from one location to another.
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

  ;; Tim puts an object inside another object.
  (:action put
    :parameters
      (?object - object ?item - object ?container - object)
    :precondition
      (and (at ?object ?container)
      (not (= ?object ?item))
      (at ?item ?object))
    :effect
      (and (not (at ?item ?object))
      (at ?item ?container))
  )

  ;; Tim loses an object.
  (:action lose
    :parameters
      (?object - object)
    :precondition
      (at ?object ?location)
    :effect
      (lost ?object)
  )
)