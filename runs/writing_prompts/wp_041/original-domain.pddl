(define (domain mark-implant)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character lab - object prototype - item)
  (:predicates
    (awake ?character - character)
    (at ?character - character ?lab - lab)
    (has-implant ?character - character ?prototype - prototype)
    (prototype-ready ?prototype - prototype)
    (prototype-tested ?prototype - prototype)
    (prototype-successful ?prototype - prototype)
    (working-3d-printer ?lab - lab)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (not (awake ?character))
    :effect
      (awake ?character)
    :agents
      (?character)
  )

  ;; A character calls another character.
  (:action call
    :parameters
      (?caller - character ?receiver - character)
    :precondition
      (and (awake ?caller)
      (not (= ?caller ?receiver)))
    :effect
      (intends ?receiver (awake ?receiver))
    :agents
      (?caller)
  )

  ;; A character creates a prototype.
  (:action create-prototype
    :parameters
      (?character - character ?lab - lab ?prototype - prototype)
    :precondition
      (and (awake ?character)
      (at ?character ?lab)
      (working-3d-printer ?lab))
    :effect
      (prototype-ready ?prototype)
    :agents
      (?character)
  )

  ;; A character tests a prototype on lab rats.
  (:action test-prototype
    :parameters
      (?character - character ?prototype - prototype)
    :precondition
      (and (awake ?character)
      (prototype-ready ?prototype))
    :effect
      (prototype-tested ?prototype)
    :agents
      (?character)
  )

  ;; A character evaluates the success of a prototype.
  (:action evaluate-prototype
    :parameters
      (?character - character ?prototype - prototype)
    :precondition
      (and (awake ?character)
      (prototype-tested ?prototype))
    :effect
      (prototype-successful ?prototype)
    :agents
      (?character)
  )

  ;; A character implants a prototype into themselves.
  (:action implant
    :parameters
      (?character - character ?prototype - prototype)
    :precondition
      (and (awake ?character)
      (prototype-successful ?prototype))
    :effect
      (has-implant ?character ?prototype)
    :agents
      (?character)
  )
)