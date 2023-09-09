(define (domain dark-woods)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (hungry ?character - character)
    (friend ?character1 - character ?character2 - character)
    (alive ?character - character)
    (food-available)
  )

  ;; A character asks another character to be friends.
  (:action ask-to-be-friends
    :parameters
      (?asker - character ?askee - character)
    :precondition
      (and (alive ?asker)
      (alive ?askee)
      (not (friend ?asker ?askee)))
    :effect
      (friend ?asker ?askee)
    :agents
      (?asker)
  )

  ;; A character searches for food.
  (:action search-for-food
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (food-available)
    :agents
      (?character)
  )

  ;; A character feeds another character.
  (:action feed
    :parameters
      (?feeder - character ?eater - character)
    :precondition
      (and (alive ?feeder)
      (alive ?eater)
      (hungry ?eater)
      (food-available))
    :effect
      (not (hungry ?eater))
    :agents
      (?feeder)
  )

  ;; A character eats another character.
  (:action eat
    :parameters
      (?eater - character ?eaten - character)
    :precondition
      (and (alive ?eater)
      (hungry ?eater)
      (alive ?eaten))
    :effect
      (not (alive ?eaten))
    :agents
      (?eater)
  )
)