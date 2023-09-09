(define (domain spot-and-cat)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (fierce ?character - character)
    (scared ?character1 - character ?character2 - character)
    (friends ?character1 - character ?character2 - character)
    (playing ?character1 - character ?character2 - character)
    (sneezed ?character - character)
  )

  ;; A character becomes friends with another character.
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

  ;; A character plays with another character.
  (:action play
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (friends ?character1 ?character2))
    :effect
      (playing ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character sneezes.
  (:action sneeze
    :parameters
      (?character - character)
    :effect
      (sneezed ?character)
    :agents
      (?character)
  )

  ;; A character becomes scared of another character.
  (:action become-scared
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (fierce ?character2))
    :effect
      (scared ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character stops being scared of another character.
  (:action stop-being-scared
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (scared ?character1 ?character2)
    :effect
      (not (scared ?character1 ?character2))
    :agents
      (?character1)
  )
)