(define (domain deserted-amphitheatre)
  (:requirements :strips :typing)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (has ?character - character ?item - object)
    (alive ?character - character)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (at ?character ?from)
      (not (= ?from ?to)))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character drinks too much.
  (:action drink
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
  )

  ;; A character falls to their knees.
  (:action fall
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location))
    :effect
      (not (at ?character ?location))
  )

  ;; A character wears a bracelet.
  (:action wear
    :parameters
      (?character - character ?item - object)
    :precondition
      (alive ?character)
    :effect
      (has ?character ?item)
  )

  ;; A character's bracelet fades.
  (:action fade
    :parameters
      (?character - character ?item - object)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (not (has ?character ?item))
  )

  ;; A character belches.
  (:action belch
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (and (not (alive ?character))
      (at ?character nowhere))
  )

  ;; A character vomits.
  (:action vomit
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location))
    :effect
      (not (at ?character ?location))
  )
)