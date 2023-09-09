(define (domain lily-swing)
  (:requirements :strips :typing :equality)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (swinging ?character - character)
    (happy ?character - character)
  )

  ;; A character moves to a location.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character starts swinging on the swing.
  (:action start-swinging
    :parameters
      (?character - character ?swing - object)
    :precondition
      (and (at ?character ?swing)
      (not (swinging ?character)))
    :effect
      (swinging ?character)
  )

  ;; A character stops swinging on the swing.
  (:action stop-swinging
    :parameters
      (?character - character ?swing - object)
    :precondition
      (and (at ?character ?swing)
      (swinging ?character))
    :effect
      (not (swinging ?character))
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (not (happy ?character))
    :effect
      (happy ?character)
  )
)