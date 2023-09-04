(define (domain lily-and-the-fairy)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types character - object flower - item)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (stuck ?character - character ?item - item)
    (friend ?character - character ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character takes an item from another.
  (:action take
    :parameters
      (?taker - character ?item - item ?giver - character ?place - place)
    :precondition
      (and (not (= ?taker ?giver))
      (at ?taker ?place)
      (at ?giver ?place)
      (has ?giver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?taker ?item))
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helped - character ?item - item ?place - place)
    :precondition
      (and (not (= ?helper ?helped))
      (at ?helper ?place)
      (at ?helped ?place)
      (stuck ?helped ?item))
    :effect
      (and (not (stuck ?helped ?item))
      (not (has ?helped ?item))
      (not (at ?item ?place))
      (friend ?helper ?helped))
  )

  ;; A character receives an item from another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver ?place)
      (at ?receiver ?place)
      (has ?giver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
  )
)