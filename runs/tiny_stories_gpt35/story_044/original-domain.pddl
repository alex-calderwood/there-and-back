(define (domain ball-rescue)
  (:requirements :strips :typing :equality)
  (:types object - physical-object bird - object)
  (:predicates
    (at ?object - object ?location - object)
    (in-mailbox ?object - object)
    (holding ?bird - bird ?object - object)
  )

  ;; A character moves from one location to another.
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

  ;; A bird rescues an object from a mailbox.
  (:action rescue
    :parameters
      (?bird - bird ?object - object ?mailbox - object)
    :precondition
      (and (at ?bird ?mailbox)
      (in-mailbox ?object)
      (not (holding ?bird ?object)))
    :effect
      (and (not (in-mailbox ?object))
      (holding ?bird ?object))
    :agents
      (?bird)
  )

  ;; A bird drops an object.
  (:action drop
    :parameters
      (?bird - bird ?object - object ?location - object)
    :precondition
      (and (at ?bird ?location)
      (holding ?bird ?object))
    :effect
      (and (not (holding ?bird ?object))
      (at ?object ?location))
    :agents
      (?bird)
  )
)