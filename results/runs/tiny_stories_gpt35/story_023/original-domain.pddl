(define (domain zigzag-park)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types character animal - object)
  (:predicates
    (at ?character - character ?location - object)
    (playing ?animal - animal)
    (happy ?character - character)
    (can-fly ?animal - animal)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character throws a ball.
  (:action throw-ball
    :parameters
      (?character - character ?ball - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (at ?ball ?location))
    :effect
      (and (not (at ?ball ?location))
      (playing ?ball)
      (happy ?character))
    :agents
      (?character)
  )

  ;; An animal runs to get a ball.
  (:action get-ball
    :parameters
      (?animal - animal ?ball - object ?location - object)
    :precondition
      (and (at ?animal ?location)
      (playing ?ball)
      (not (at ?ball ?location)))
    :effect
      (and (at ?ball ?location)
      (not (playing ?ball))
      (happy ?animal))
    :agents
      (?animal)
  )

  ;; A bird flies away.
  (:action fly-away
    :parameters
      (?bird - animal ?location - object)
    :precondition
      (and (at ?bird ?location)
      (can-fly ?bird))
    :effect
      (not (at ?bird ?location))
    :agents
      (?bird)
  )
)