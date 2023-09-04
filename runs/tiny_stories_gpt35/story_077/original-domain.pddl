(define (domain bunny-and-bird)
  (:requirements :strips :typing :equality)
  (:types character - object ball - item)
  (:predicates
    (at ?character - character ?place - object)
    (has ?character - character ?item - item)
    (playing)
    (tired)
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

  ;; A character kicks a ball.
  (:action kick-ball
    :parameters
      (?character - character ?ball - ball ?from - object ?to - object)
    :precondition
      (and (at ?character ?from)
      (at ?ball ?from))
    :effect
      (and (not (at ?ball ?from))
      (at ?ball ?to))
    :agents
      (?character)
  )

  ;; A character catches a ball.
  (:action catch-ball
    :parameters
      (?character - character ?ball - ball ?from - object ?to - object)
    :precondition
      (and (at ?character ?from)
      (at ?ball ?from))
    :effect
      (and (not (at ?ball ?from))
      (at ?ball ?to))
    :agents
      (?character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?speaker - character ?listener - character)
    :precondition
      (and (at ?speaker ?place)
      (at ?listener ?place))
    :effect
      (and (not (playing))
      (not (tired)))
    :agents
      (?speaker ?listener)
  )
)