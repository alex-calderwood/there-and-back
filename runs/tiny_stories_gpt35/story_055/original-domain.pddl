(define (domain vase-story)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types person - object bug vase - item)
  (:predicates
    (at ?person - person ?item - item)
    (scared ?person - person)
    (near ?bug - bug ?vase - vase)
    (in ?bug - bug ?place - place)
    (in ?vase - vase ?place - place)
    (safe ?bug - bug)
  )

  ;; A person moves from one place to another.
  (:action move
    :parameters
      (?person - person ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person gets scared.
  (:action scare
    :parameters
      (?person - person)
    :precondition
      (and (not (safe ?bug))
      (near ?bug ?vase)
      (at ?person ?vase))
    :effect
      (scared ?person)
  )

  ;; A person gets over their fear.
  (:action overcome-fear
    :parameters
      (?person - person)
    :precondition
      (scared ?person)
    :effect
      (not (scared ?person))
  )

  ;; A person checks if a bug is safe.
  (:action check-bug
    :parameters
      (?person - person ?bug - bug)
    :precondition
      (and (in ?bug ?place)
      (at ?person ?place))
    :effect
      (safe ?bug)
  )

  ;; A person removes a bug from a vase.
  (:action remove-bug
    :parameters
      (?person - person ?bug - bug ?vase - vase ?place - place)
    :precondition
      (and (in ?bug ?vase)
      (not (safe ?bug))
      (at ?person ?place)
      (in ?vase ?place))
    :effect
      (and (not (in ?bug ?vase))
      (in ?bug ?place))
  )

  ;; A person puts a bug outside.
  (:action put-outside
    :parameters
      (?person - person ?bug - bug ?place - place)
    :precondition
      (and (in ?bug ?place)
      (at ?person ?place))
    :effect
      (not (in ?bug ?place))
  )
)