(define (domain dog-guardians)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (needs-walk ?character - character)
    (in-herenow ?character - character)
    (ancient-oath ?dog - character)
    (guardian ?dog - character)
    (master ?character - character)
    (time-of-passing)
  )

  ;; A dog reminds the master of the ancient oath.
  (:action remind-ancient-oath
    :parameters
      (?dog - character ?master - character)
    :precondition
      (and (guardian ?dog)
      (master ?master)
      (ancient-oath ?dog))
    :effect
      (needs-walk ?master)
    :agents
      (?dog)
  )

  ;; A dog brings the master to the herenow.
  (:action bring-to-herenow
    :parameters
      (?dog - character ?master - character)
    :precondition
      (and (guardian ?dog)
      (master ?master)
      (not (in-herenow ?master)))
    :effect
      (in-herenow ?master)
    :agents
      (?dog)
  )

  ;; A dog takes the master for a walk.
  (:action walk
    :parameters
      (?dog - character ?master - character)
    :precondition
      (and (guardian ?dog)
      (master ?master)
      (needs-walk ?master))
    :effect
      (and (not (needs-walk ?master))
      (in-herenow ?master))
    :agents
      (?dog)
  )

  ;; The time of passing occurs.
  (:action time-of-passing
    :precondition
      (not (time-of-passing))
    :effect
      (time-of-passing)
  )
)