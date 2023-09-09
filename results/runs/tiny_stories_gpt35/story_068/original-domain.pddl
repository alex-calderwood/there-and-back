(define (domain flower-picking)
  (:requirements :strips :typing :equality)
  (:types character - object flower - item)
  (:predicates
    (at ?character - character ?place - object)
    (picked ?flower - flower)
    (has ?character - character ?flower - flower)
    (shared-secret ?character1 - character ?character2 - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character picks a flower.
  (:action pick
    :parameters
      (?character - character ?flower - flower ?place - object)
    :precondition
      (and (at ?character ?place)
      (not (picked ?flower))
      (not (has ?character ?flower)))
    :effect
      (and (picked ?flower)
      (has ?character ?flower))
  )

  ;; Two characters share a secret.
  (:action share-secret
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (at ?character1 ?place)
      (at ?character2 ?place)
      (not (= ?character1 ?character2)))
    :effect
      (and (shared-secret ?character1 ?character2)
      (shared-secret ?character2 ?character1))
  )
)