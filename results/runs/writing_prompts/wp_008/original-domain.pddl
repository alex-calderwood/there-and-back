(define (domain brother-and-father)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (has ?character - character ?item - object)
    (dead ?character - character)
    (tried-revive ?character - character)
    (cried ?character - character)
  )

  ;; A character tries to revive another character.
  (:action try-revive
    :parameters
      (?reviver - character ?revivee - character)
    :precondition
      (and (not (= ?reviver ?revivee))
      (alive ?reviver)
      (dead ?revivee))
    :effect
      (tried-revive ?reviver)
    :agents
      (?reviver)
  )

  ;; A character cries.
  (:action cry
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (cried ?character)
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (dead ?character)
    :agents
      (?character)
  )
)