(define (domain sailing-boat)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types person - object)
  (:predicates
    (sailing ?person - person)
    (nice ?person - person)
    (at ?person - person ?location - location)
    (knows-sailing ?person - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person learns how to sail.
  (:action learn-sailing
    :parameters
      (?person - person)
    :precondition
      (and (not (knows-sailing ?person))
      (at ?person shore))
    :effect
      (knows-sailing ?person)
  )

  ;; A person helps another person sail a boat.
  (:action help-sail
    :parameters
      (?helper - person ?sailor - person ?boat - boat)
    :precondition
      (and (at ?helper ?location)
      (at ?sailor ?location)
      (sailing ?sailor)
      (knows-sailing ?helper)
      (not (= ?helper ?sailor)))
    :effect
      (sailing ?helper)
  )

  ;; A person becomes nice.
  (:action become-nice
    :parameters
      (?person - person)
    :precondition
      (and (not (nice ?person))
      (at ?person ?location))
    :effect
      (nice ?person)
  )
)