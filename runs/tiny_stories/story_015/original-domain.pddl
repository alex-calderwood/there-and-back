(define (domain dog-race)
  (:requirements :adl :domain-axioms :intentionality)
  (:types dog - character)
  (:predicates
    (friend ?dog1 - dog ?dog2 - dog)
    (practices ?dog1 - dog ?dog2 - dog)
    (participates ?dog - dog)
    (wins ?dog - dog)
    (plays-with-toy-stack ?dog - dog)
  )

  ;; One dog helps another dog practice running.
  (:action practice-running
    :parameters
      (?helper - dog ?runner - dog)
    :precondition
      (and (friend ?helper ?runner)
      (not (practices ?helper ?runner)))
    :effect
      (practices ?helper ?runner)
    :agents
      (?helper ?runner)
  )

  ;; A dog participates in a race.
  (:action participate-in-race
    :parameters
      (?dog - dog)
    :precondition
      (not (participates ?dog))
    :effect
      (participates ?dog)
    :agents
      (?dog)
  )

  ;; A dog wins a race.
  (:action win-race
    :parameters
      (?dog - dog)
    :precondition
      (and (participates ?dog)
      (practices ?dog ?helper - dog))
    :effect
      (wins ?dog)
    :agents
      (?dog)
  )

  ;; A dog plays with a toy stack.
  (:action play-with-toy-stack
    :parameters
      (?dog - dog)
    :precondition
      (not (plays-with-toy-stack ?dog))
    :effect
      (plays-with-toy-stack ?dog)
    :agents
      (?dog)
  )
)