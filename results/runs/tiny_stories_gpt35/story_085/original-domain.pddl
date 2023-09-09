(define (domain tea-party)
  (:requirements :strips :typing :negative-preconditions :equality :quantified-preconditions :intentionality)
  (:types person - object doll - person cup saucer - item)
  (:predicates
    (has ?person - person ?item - item)
    (at ?item - item ?place - place)
    (broken ?item - item)
    (filled ?cup - cup)
    (intends ?person - person ?predicate - predicate)
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
    :agents
      (?person)
  )

  ;; A person takes an item from a place.
  (:action take
    :parameters
      (?person - person ?item - item ?place - place)
    :precondition
      (and (at ?person ?place)
      (at ?item ?place))
    :effect
      (and (not (at ?item ?place))
      (at ?item ?person)
      (not (has ?person ?item))
      (has ?person ?item))
    :agents
      (?person)
  )

  ;; A person puts an item in a place.
  (:action put
    :parameters
      (?person - person ?item - item ?from - place ?to - place)
    :precondition
      (and (at ?person ?from)
      (at ?item ?person)
      (not (= ?from ?to)))
    :effect
      (and (not (at ?item ?person))
      (at ?item ?to)
      (not (has ?person ?item)))
    :agents
      (?person)
  )

  ;; A person fills a cup with water.
  (:action fill
    :parameters
      (?person - person ?cup - cup ?place - place)
    :precondition
      (and (at ?person ?place)
      (at ?cup ?person)
      (not (filled ?cup)))
    :effect
      (filled ?cup)
    :agents
      (?person)
  )

  ;; A person breaks an item.
  (:action break
    :parameters
      (?person - person ?item - item ?place - place)
    :precondition
      (and (at ?person ?place)
      (at ?item ?place)
      (not (broken ?item)))
    :effect
      (broken ?item)
    :agents
      (?person)
  )

  ;; A person cleans up a mess.
  (:action clean
    :parameters
      (?person - person ?item - item ?place - place)
    :precondition
      (and (at ?person ?place)
      (broken ?item)
      (at ?item ?place))
    :effect
      (and (not (broken ?item))
      (not (at ?item ?place)))
    :agents
      (?person)
  )

  ;; A person apologizes to another person.
  (:action apologize
    :parameters
      (?apologizer - person ?apologizee - person)
    :precondition
      (and (not (= ?apologizer ?apologizee))
      (intends ?apologizer (not (intends ?apologizee (broken ?item)))))
    :effect
      (and (intends ?apologizer (intends ?apologizee (not (intends ?apologizer (broken ?item))))))
    :agents
      (?apologizer)
  )
)