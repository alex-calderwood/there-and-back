(define (domain lily-and-fairy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (wearing-hat ?character - character)
    (is-dog ?character - character)
    (is-fairy ?character - character)
    (has-magic-flower ?character - character)
    (friends ?character1 - character ?character2 - character)
    (playing-together ?character1 - character ?character2 - character)
  )

  ;; A character removes a hat from another character.
  (:action remove-hat
    :parameters
      (?remover - character ?wearer - character)
    :precondition
      (and (not (= ?remover ?wearer))
      (wearing-hat ?wearer))
    :effect
      (not (wearing-hat ?wearer))
    :agents
      (?remover)
  )

  ;; A character transforms from a dog to a fairy.
  (:action transform
    :parameters
      (?character - character)
    :precondition
      (is-dog ?character)
    :effect
      (and (not (is-dog ?character))
      (is-fairy ?character))
    :agents
      (?character)
  )

  ;; A fairy gives a magic flower to a character.
  (:action give-magic-flower
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (is-fairy ?giver))
    :effect
      (has-magic-flower ?receiver)
    :agents
      (?giver)
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

  ;; Two characters play together.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (friends ?character1 ?character2))
    :effect
      (playing-together ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)