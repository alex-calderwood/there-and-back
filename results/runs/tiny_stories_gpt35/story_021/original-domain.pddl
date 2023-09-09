(define (domain cooking-and-music)
  (:requirements :strips :typing :equality)
  (:types person - object instrument - object food - object)
  (:predicates
    (cooking-with ?person - person)
    (playing ?person - person ?instrument - instrument)
    (has ?person - person ?food - food)
    (fake ?instrument - instrument)
  )

  ;; A person cooks with another person.
  (:action cook-with
    :parameters
      (?person1 - person ?person2 - person)
    :precondition
      (and (not (= ?person1 ?person2))
      (not (cooking-with ?person1))
      (not (cooking-with ?person2)))
    :effect
      (and (cooking-with ?person1)
      (cooking-with ?person2))
  )

  ;; A person plays an instrument.
  (:action play
    :parameters
      (?person - person ?instrument - instrument)
    :precondition
      (and (not (playing ?person ?instrument))
      (fake ?instrument))
    :effect
      (playing ?person ?instrument)
  )

  ;; A person gives food to another person.
  (:action give-food
    :parameters
      (?giver - person ?food - food ?receiver - person)
    :precondition
      (and (not (= ?giver ?receiver))
      (has ?giver ?food))
    :effect
      (and (not (has ?giver ?food))
      (has ?receiver ?food))
  )
)