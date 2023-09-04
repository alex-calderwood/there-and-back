(define (domain bookcase-playtime)
  (:requirements :strips :typing)
  (:types ball - object)
  (:predicates
    (at ?object - object ?location - object)
    (bouncing ?ball - ball)
    (calm ?object - object)
    (fallen ?object - object)
  )

  ;; A ball bounces.
  (:action bounce
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (not (fallen ?ball))
      (not (calm ?ball)))
    :effect
      (and (bouncing ?ball)
      (not (at ?ball ?location)))
  )

  ;; A ball stops bouncing.
  (:action stop-bouncing
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (bouncing ?ball))
    :effect
      (and (not (bouncing ?ball))
      (at ?ball ?location))
  )

  ;; A ball falls.
  (:action fall
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (bouncing ?ball))
    :effect
      (and (fallen ?ball)
      (not (bouncing ?ball))
      (not (at ?ball ?location)))
  )

  ;; A ball is picked up.
  (:action pick-up
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (not (bouncing ?ball)))
    :effect
      (at ?ball ?location)
  )

  ;; A ball is thrown.
  (:action throw
    :parameters
      (?ball - ball ?from - object ?to - object)
    :precondition
      (and (at ?ball ?from)
      (not (bouncing ?ball))
      (not (fallen ?ball))
      (not (= ?from ?to)))
    :effect
      (and (not (at ?ball ?from))
      (at ?ball ?to))
  )

  ;; A ball is played with calmly.
  (:action play-calmly
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (not (fallen ?ball)))
    :effect
      (calm ?ball)
  )

  ;; A ball is played with excitedly.
  (:action play-excitedly
    :parameters
      (?ball - ball ?location - object)
    :precondition
      (and (at ?ball ?location)
      (not (fallen ?ball)))
    :effect
      (not (calm ?ball))
  )
)