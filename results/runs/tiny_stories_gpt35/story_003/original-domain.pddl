(define (domain amy-bike)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types person bike - object)
  (:predicates
    (at ?person - person ?location - object)
    (broken ?bike - bike)
    (fixed ?bike - bike)
    (riding ?person - person ?bike - bike)
    (flying ?bike - bike)
  )

  ;; A person walks from one location to another.
  (:action walk
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person takes a bike.
  (:action take-bike
    :parameters
      (?person - person ?bike - bike ?location - object)
    :precondition
      (and (not (broken ?bike))
      (at ?person ?location)
      (at ?bike ?location))
    :effect
      (and (not (at ?bike ?location))
      (not (at ?person ?location))
      (at ?person ?bike)
      (not (at ?bike ?location)))
  )

  ;; A person fixes a bike.
  (:action fix-bike
    :parameters
      (?person - person ?bike - bike)
    :precondition
      (and (at ?person ?bike)
      (broken ?bike))
    :effect
      (and (not (broken ?bike))
      (fixed ?bike))
  )

  ;; A person rides a bike.
  (:action ride-bike
    :parameters
      (?person - person ?bike - bike)
    :precondition
      (and (at ?person ?bike)
      (fixed ?bike))
    :effect
      (and (not (at ?person ?bike))
      (riding ?person ?bike))
  )

  ;; A bike starts flying.
  (:action fly-bike
    :parameters
      (?bike - bike)
    :precondition
      (and (riding ?person ?bike))
    :effect
      (flying ?bike)
  )
)