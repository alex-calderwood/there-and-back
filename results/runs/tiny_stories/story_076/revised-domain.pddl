(define (domain cat-and-dog)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object toy - item)
  (:predicates
    (has ?character - character ?item - item)
    (playing-together ?character1 - character ?character2 - character)
    (shares ?character - character)
    (friends ?character1 - character ?character2 - character)
  )

  ;; A character shares a toy with another character.
  (:action share
    :parameters
      (?sharer - character ?item - item ?receiver - character)
    :precondition
      (and (not (= ?sharer ?receiver))
      (has ?sharer ?item)
      (friends ?sharer ?receiver))
    :effect
      (and (shares ?sharer)
      (has ?receiver ?item))
    :agents
      (?sharer)
  )

  ;; Two characters play together.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (friends ?character1 ?character2)
      (shares ?character1))
    :effect
      (playing-together ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character apologizes to another character.
  (:action apologize
    :parameters
      (?apologizer - character ?receiver - character)
    :precondition
      (and (not (= ?apologizer ?receiver))
      (friends ?apologizer ?receiver))
    :effect
      (shares ?apologizer)
    :agents
      (?apologizer)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)