(define (domain rocket-playtime)
  (:requirements :strips :typing :equality)
  (:types object)
  (:predicates
    (at ?obj - object ?loc - object)
    (held ?obj - object)
    (played ?obj - object)
    (flying ?obj - object)
    (swinging ?obj - object)
  )

  ;; A character moves an object from one location to another.
  (:action move
    :parameters
      (?obj - object ?from - object ?to - object)
    :precondition
      (and (at ?obj ?from))
    :effect
      (and (not (at ?obj ?from))
      (at ?obj ?to))
  )

  ;; A character picks up an object.
  (:action pick-up
    :parameters
      (?obj - object ?loc - object)
    :precondition
      (and (at ?obj ?loc))
    :effect
      (and (not (at ?obj ?loc))
      (held ?obj))
  )

  ;; A character puts down an object.
  (:action put-down
    :parameters
      (?obj - object ?loc - object)
    :precondition
      (and (held ?obj))
    :effect
      (and (not (held ?obj))
      (at ?obj ?loc))
  )

  ;; A character plays with an object.
  (:action play
    :parameters
      (?obj - object)
    :precondition
      (and (held ?obj))
    :effect
      (played ?obj)
  )

  ;; A character swings an object.
  (:action swing
    :parameters
      (?obj - object)
    :precondition
      (and (played ?obj))
    :effect
      (and (not (flying ?obj))
      (swinging ?obj))
  )

  ;; A character flies an object.
  (:action fly
    :parameters
      (?obj - object)
    :precondition
      (and (swinging ?obj))
    :effect
      (flying ?obj)
  )
)