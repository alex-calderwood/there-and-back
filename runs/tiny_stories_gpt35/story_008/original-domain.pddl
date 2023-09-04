(define (domain lily-and-tim)
  (:requirements :strips :typing :equality)
  (:types character - object ball - item)
  (:predicates
    (has ?character - character ?item - item)
    (played ?character - character)
    (friends ?character - character ?character - character)
  )

  ;; A character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (has ?giver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; Two characters play with a ball.
  (:action play
    :parameters
      (?character1 - character ?character2 - character ?ball - ball)
    :precondition
      (and (not (= ?character1 ?character2))
      (has ?character1 ?ball)
      (has ?character2 ?ball))
    :effect
      (and (played ?character1)
      (played ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (played ?character1)
      (played ?character2))
    :effect
      (and (friends ?character1 ?character2)
      (friends ?character2 ?character1))
    :agents
      (?character1 ?character2)
  )
)