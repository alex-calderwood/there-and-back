(define (domain sonnet-21)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character trial - object)
  (:constants blood sweat tears - trial death - character)
  (:predicates
    (dead ?character - character)
    (alive ?character - character)
    (completed ?character - character ?trial - trial)
    (offered ?character - character ?trial - trial)
  )

  ;; A character is offered a trial by Death.
  (:action offer-trial
    :parameters
      (?character - character ?trial - trial)
    :precondition
      (and (dead ?character)
      (not (offered ?character ?trial)))
    :effect
      (offered ?character ?trial)
    :agents
      (death)
  )

  ;; A character chooses a trial.
  (:action choose-trial
    :parameters
      (?character - character ?trial - trial)
    :precondition
      (and (dead ?character)
      (offered ?character ?trial))
    :effect
      (and (completed ?character ?trial)
      (not (offered ?character ?trial)))
    :agents
      (?character)
  )

  ;; A character is reborn after completing a trial.
  (:action rebirth
    :parameters
      (?character - character)
    :precondition
      (and (dead ?character)
      (or (completed ?character blood)
      (completed ?character sweat)
      (completed ?character tears)))
    :effect
      (and (alive ?character)
      (not (dead ?character))
      (not (completed ?character blood))
      (not (completed ?character sweat))
      (not (completed ?character tears)))
    :agents
      (death)
  )

  ;; When a character is not alive, they are dead.
  (:axiom
    :vars
      (?character - character)
    :context
      (not (alive ?character))
    :implies
      (dead ?character)
  )

  ;; When a character is not dead, they are alive.
  (:axiom
    :vars
      (?character - character)
    :context
      (not (dead ?character))
    :implies
      (alive ?character)
  )
)