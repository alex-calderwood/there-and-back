(define (domain rabbit-race)
  (:requirements :strips :typing)
  (:types rabbit kid - participant)
  (:predicates
    (at ?participant - participant ?location - location)
    (finished ?participant - participant)
    (winner ?participant - participant)
  )

  ;; A participant moves from one location to another.
  (:action move
    :parameters
      (?participant - participant ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (at ?participant ?from))
    :effect  (and (not (at ?participant ?from))
      (at ?participant ?to))
  )

  ;; A participant finishes the race.
  (:action finish
    :parameters
      (?participant - participant ?location - location)
    :precondition
      (at ?participant ?location)
    :effect
      (and (finished ?participant)
      (winner ?participant))
  )
)