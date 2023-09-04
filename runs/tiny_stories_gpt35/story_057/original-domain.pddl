(define (domain bell-story)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :intentionality)
  (:types person - object bell - item)
  (:predicates
    (at ?person - person ?place - object)
    (has ?person - person ?item - item)
    (needs-oil ?item - item)
    (working ?item - item)
    (intends ?person - person ?predicate - predicate)
  )

  ;; A person travels from one place to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
    :agents  (?person)
  )

  ;; A person buys an item.
  (:action buy
    :parameters
      (?person - person ?item - item)
    :precondition
      (and (at ?person store)
      (needs-oil ?item))
    :effect
      (and (not (needs-oil ?item))
      (has ?person ?item))
    :agents  (?person)
  )

  ;; A person gives an item to another.
  (:action give
    :parameters
      (?giver - person ?item - item ?receiver - person)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver home)
      (has ?giver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; A person fixes an item with oil.
  (:action fix
    :parameters
      (?person - person ?item - item)
    :precondition
      (and (at ?person ?item)
      (needs-oil ?item)
      (has ?person oil))
    :effect
      (and (not (needs-oil ?item))
      (working ?item))
    :agents  (?person)
  )

  ;; A person rings a bell.
  (:action ring
    :parameters
      (?person - person ?bell - bell)
    :precondition
      (and (at ?person home)
      (has ?person ?bell)
      (working ?bell))
    :effect
      (and (not (working ?bell)))
    :agents  (?person)
  )

  ;; A person intends to do something.
  (:action intend
    :parameters
      (?person - person ?predicate - predicate)
    :precondition
      (and (at ?person home))
    :effect
      (intends ?person ?predicate)
    :agents  (?person)
  )

  ;; A person follows through with their intention.
  (:action follow-through
    :parameters
      (?person - person ?predicate - predicate)
    :precondition
      (and (intends ?person ?predicate))
    :effect
      (and ?predicate)
    :agents  (?person)
  )
)