(define (domain tim-and-the-penny)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types object - person candy - item)
  (:constants penny - item)
  (:predicates
    (has ?person - person ?item - item)
    (original ?item - item)
    (good ?item - item)
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
  )

  ;; A person buys an item.
  (:action buy
    :parameters
      (?person - person ?item - item ?seller - person ?price - candy)
    :precondition
      (and (at ?person ?seller)
      (good ?item)
      (has ?seller ?item)
      (has ?person penny))
    :effect
      (and (not (has ?person penny))
      (not (has ?seller ?item))
      (has ?person ?item)
      (has ?seller ?price))
    :agents
      (?person ?seller)
  )

  ;; A person finds an item.
  (:action find
    :parameters
      (?person - person ?item - item ?place - object)
    :precondition
      (and (not (has ?person ?item))
      (at ?person ?place)
      (original ?item))
    :effect
      (and (has ?person ?item))
    :agents
      (?person)
  )
)