(define (domain emma-birthday-party)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (happy ?character - character)
    (party-prepared ?character - character)
    (has-balloons)
    (has-cake)
    (has-present ?character - character)
    (played-games)
    (thanked-parents ?character - character)
  )

  ;; A character prepares a party for another character.
  (:action prepare-party
    :parameters
      (?preparer - character ?receiver - character)
    :precondition
      (not (party-prepared ?receiver))
    :effect
      (party-prepared ?receiver)
    :agents
      (?preparer ?receiver)
  )

  ;; A character decorates the party with balloons.
  (:action decorate-with-balloons
    :parameters
      (?character - character)
    :precondition
      (and (not (has-balloons))
      (party-prepared ?character))
    :effect
      (has-balloons)
    :agents
      (?character)
  )

  ;; A character prepares a cake for the party.
  (:action prepare-cake
    :parameters
      (?character - character)
    :precondition
      (and (not (has-cake))
      (party-prepared ?character))
    :effect
      (has-cake)
    :agents
      (?character)
  )

  ;; A character plays games at the party.
  (:action play-games
    :parameters
      (?character - character)
    :precondition
      (party-prepared ?character)
    :effect
      (played-games)
    :agents
      (?character)
  )

  ;; A character gives a present to another character.
  (:action give-present
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (not (has-present ?receiver))
      (party-prepared ?receiver))
    :effect
      (has-present ?receiver)
    :agents
      (?giver ?receiver)
  )

  ;; A character thanks their parents.
  (:action thank-parents
    :parameters
      (?character - character)
    :precondition
      (and (not (thanked-parents ?character))
      (has-present ?character))
    :effect
      (thanked-parents ?character)
    :agents
      (?character)
  )

  ;; When a character has a party, they are happy.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (happy ?character))
      (party-prepared ?character)
      (has-balloons)
      (has-cake)
      (played-games)
      (has-present ?character)
      (thanked-parents ?character))
    :implies
      (happy ?character)
  )
)