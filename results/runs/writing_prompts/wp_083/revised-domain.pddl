(define (domain the-six)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (friends ?character1 - character ?character2 - character)
    (in-love ?character1 - character ?character2 - character)
    (betrayed ?character1 - character ?character2 - character)
    (at ?character - character ?place - place)
    (peace ?place - place)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (friends ?character1 ?character2)))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters fall in love.
  (:action fall-in-love
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (in-love ?character1 ?character2))
      (friends ?character1 ?character2))
    :effect
      (in-love ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character betrays another character.
  (:action betray
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (in-love ?character1 ?character2))
    :effect
      (betrayed ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character redeems themselves.
  (:action redeem
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (betrayed ?character1 ?character2))
    :effect
      (and (not (betrayed ?character1 ?character2))
      (in-love ?character1 ?character2))
    :agents
      (?character1)
  )

  ;; A character brings peace to a place.
  (:action bring-peace
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (peace ?place))
      (exists (?character2 - character)
      (in-love ?character ?character2)))
    :effect
      (peace ?place)
    :agents
      (?character)
  )
)