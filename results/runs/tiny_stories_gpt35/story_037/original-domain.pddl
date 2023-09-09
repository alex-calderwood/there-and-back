(define (domain max-and-whiskers)
  (:requirements :strips :negative-preconditions :typing)
  (:types animal - object)
  (:predicates
    (at ?animal - animal ?location - object)
    (has-treat ?animal - animal)
    (foolish ?animal - animal)
    (tricked ?animal - animal)
    (looking-for-bone)
  )

  ;; A character travels from one location to another.
  (:action travel
    :parameters
      (?animal - animal ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?animal ?from))
    :effect  (and (not (at ?animal ?from))
      (at ?animal ?to))
  )

  ;; A character gives a treat to another.
  (:action give-treat
    :parameters
      (?giver - animal ?receiver - animal)
    :precondition
      (and (at ?giver ?location)
      (at ?receiver ?location)
      (has-treat ?giver))
    :effect
      (and (not (has-treat ?giver))
      (has-treat ?receiver))
  )

  ;; A character tricks another.
  (:action trick
    :parameters
      (?tricker - animal ?tricked - animal)
    :precondition
      (and (at ?tricker ?location)
      (at ?tricked ?location)
      (foolish ?tricked))
    :effect
      (and (tricked ?tricked))
  )

  ;; Max looks for the bone.
  (:action look-for-bone
    :parameters
      (?max - animal)
    :precondition
      (and (at ?max ?location)
      (not (looking-for-bone)))
    :effect
      (looking-for-bone)
  )

  ;; Max finds the bone.
  (:action find-bone
    :parameters
      (?max - animal)
    :precondition
      (and (at ?max ?location)
      (looking-for-bone))
    :effect
      (not (looking-for-bone))
  )

)