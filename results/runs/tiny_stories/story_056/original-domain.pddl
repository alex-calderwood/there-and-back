(define (domain monster-wardrobe)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (dressed ?character - character)
    (holding-hands ?character1 - character ?character2 - character)
    (kissing ?character1 - character ?character2 - character)
    (monster-in-wardrobe)
    (monster-angry)
    (monster-hungry)
    (eaten ?character - character)
  )

  ;; A character dresses up.
  (:action dress-up
    :parameters
      (?character - character)
    :effect
      (dressed ?character)
    :agents
      (?character)
  )

  ;; Two characters hold hands.
  (:action hold-hands
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (dressed ?character1)
      (dressed ?character2))
    :effect
      (holding-hands ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters attempt to kiss.
  (:action try-kiss
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (holding-hands ?character1 ?character2))
    :effect
      (kissing ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; The monster appears.
  (:action monster-appears
    :precondition
      (monster-in-wardrobe)
    :effect
      (and (monster-angry)
      (monster-hungry))
  )

  ;; The monster eats a character.
  (:action monster-eats
    :parameters
      (?character - character)
    :precondition
      (and (monster-angry)
      (monster-hungry)
      (not (eaten ?character)))
    :effect
      (eaten ?character)
    :agents
      (?character)
  )

  ;; The monster calms down.
  (:action monster-calms
    :precondition
      (monster-angry)
    :effect
      (not (monster-angry))
  )
)