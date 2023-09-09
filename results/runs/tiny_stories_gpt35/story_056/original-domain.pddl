(define (domain dress-up)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types character - object)
  (:predicates
    (dressed-up ?character - character)
    (holding-hands)
    (kissing)
    (monster ?character - character)
    (alive ?character - character)
    (in-wardrobe ?character - character)
  )

  ;; A character dresses up in clothes.
  (:action dress-up
    :parameters
      (?character - character ?clothes - object)
    :precondition
      (and (not (dressed-up ?character))
      (at ?clothes ?character))
    :effect
      (dressed-up ?character)
    :agents
      (?character)
  )

  ;; Two characters hold hands.
  (:action hold-hands
    :precondition
      (and (dressed-up ?character1)
      (dressed-up ?character2)
      (not (holding-hands)))
    :effect
      (holding-hands)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters kiss.
  (:action kiss
    :precondition
      (and (holding-hands)
      (not (kissing)))
    :effect
      (kissing)
    :agents
      (?character1 ?character2)
  )

  ;; A monster appears and attacks two characters.
  (:action monster-attack
    :parameters
      (?monster - character ?character1 - character ?character2 - character)
    :precondition
      (and (alive ?monster)
      (not (in-wardrobe ?monster))
      (not (in-wardrobe ?character1))
      (not (in-wardrobe ?character2)))
    :effect
      (and (not (alive ?character1))
      (not (alive ?character2))
      (in-wardrobe ?character1)
      (in-wardrobe ?character2))
    :agents
      (?monster)
  )

  ;; A character tries to run away from the monster.
  (:action run-away
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (in-wardrobe ?character))
      (monster ?monster)
      (not (in-wardrobe ?monster)))
    :effect
      (in-wardrobe ?character)
    :agents
      (?character)
  )
)