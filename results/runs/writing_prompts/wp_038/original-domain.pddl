(define (domain alien-abduction)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (abducted ?character - character)
    (has-translator ?character - character)
    (knows-mistake ?character - character)
    (playing-game ?character - character ?character2 - character)
    (friends ?character - character ?character2 - character)
  )

  ;; A character abducts another character.
  (:action abduct
    :parameters
      (?abductor - character ?abductee - character ?place - place)
    :precondition
      (and (not (= ?abductor ?abductee))
      (alive ?abductor)
      (at ?abductor ?place)
      (alive ?abductee)
      (at ?abductee ?place))
    :effect
      (and (abducted ?abductee)
      (not (at ?abductee ?place)))
    :agents
      (?abductor)
  )

  ;; A character gives a translator to another character.
  (:action give-translator
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (alive ?receiver)
      (abducted ?receiver))
    :effect
      (has-translator ?receiver)
    :agents
      (?giver)
  )

  ;; A character reveals their mistake to another character.
  (:action reveal-mistake
    :parameters
      (?mistaken - character ?informed - character)
    :precondition
      (and (not (= ?mistaken ?informed))
      (alive ?mistaken)
      (alive ?informed)
      (has-translator ?informed))
    :effect
      (knows-mistake ?informed ?mistaken)
    :agents
      (?mistaken)
  )

  ;; Characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (alive ?character2)
      (has-translator ?character1))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Characters play a game together.
  (:action play-game
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (alive ?character2)
      (friends ?character1 ?character2))
    :effect
      (playing-game ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Characters stop playing a game together.
  (:action stop-game
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (alive ?character2)
      (playing-game ?character1 ?character2))
    :effect
      (not (playing-game ?character1 ?character2))
    :agents
      (?character1 ?character2)
  )
)