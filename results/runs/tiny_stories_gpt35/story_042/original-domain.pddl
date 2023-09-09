(define (domain carnival-day)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (playing ?person - person)
    (modest ?person - person)
    (upset ?person - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
    :agents
      (?person)
  )

  ;; A person plays a game.
  (:action play
    :parameters
      (?person - person ?game - object)
    :precondition
      (and (at ?person ?game)
      (modest ?person)
      (not (playing ?person)))
    :effect
      (and (playing ?person)
      (not (modest ?person)))
    :agents
      (?person)
  )

  ;; A person is weighed and wins.
  (:action weigh-and-win
    :parameters
      (?person - person ?machine - object)
    :precondition
      (and (at ?person ?machine)
      (playing ?person))
    :effect
      (and (not (playing ?person))
      (not (upset ?person)))
    :agents
      (?person)
  )

  ;; A person is weighed and loses.
  (:action weigh-and-lose
    :parameters
      (?person - person ?machine - object)
    :precondition
      (and (at ?person ?machine)
      (playing ?person))
    :effect
      (and (not (playing ?person))
      (upset ?person))
    :agents
      (?person)
  )

  ;; A person tries to comfort another person.
  (:action comfort
    :parameters
      (?comforter - person ?comfortee - person)
    :precondition
      (and (at ?comforter ?location)
      (at ?comfortee ?location)
      (upset ?comfortee))
    :effect
      (not (upset ?comfortee))
    :agents
      (?comforter)
  )
)