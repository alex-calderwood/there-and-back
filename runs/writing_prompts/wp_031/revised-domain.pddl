(define (domain moby-dick)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character ship - object)
  (:predicates
    (alive ?character - character)
    (on-ship ?character - character ?ship - ship)
    (moby-dick-spotted ?ship - ship)
    (moby-dick-attacking ?ship - ship)
    (read-moby-dick ?character - character)
    (trained-in-whale-killing ?character - character)
    (battle-stations ?ship - ship)
  )

  ;; A character spots Moby Dick.
  (:action spot-moby-dick
    :parameters
      (?character - character ?ship - ship)
    :precondition
      (and (alive ?character)
      (on-ship ?character ?ship))
    :effect
      (moby-dick-spotted ?ship)
    :agents
      (?character)
  )

  ;; Moby Dick attacks the ship.
  (:action moby-dick-attack
    :parameters
      (?ship - ship)
    :precondition
      (moby-dick-spotted ?ship)
    :effect
      (moby-dick-attacking ?ship)
  )

  ;; A character orders battle stations.
  (:action order-battle-stations
    :parameters
      (?character - character ?ship - ship)
    :precondition
      (and (alive ?character)
      (on-ship ?character ?ship)
      (moby-dick-spotted ?ship))
    :effect
      (battle-stations ?ship)
    :agents
      (?character)
  )

  ;; A character tries to kill Moby Dick.
  (:action try-kill-moby-dick
    :parameters
      (?character - character ?ship - ship)
    :precondition
      (and (alive ?character)
      (on-ship ?character ?ship)
      (trained-in-whale-killing ?character)
      (moby-dick-attacking ?ship)
      (battle-stations ?ship))
    :effect
      (not (moby-dick-attacking ?ship))
    :agents
      (?character)
  )

  ;; A character reads Moby Dick.
  (:action read-moby-dick
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (read-moby-dick ?character)
    :agents
      (?character)
  )

  ;; A character becomes trained in whale killing.
  (:action train-in-whale-killing
    :parameters
      (?character - character)
    :precondition
      (read-moby-dick ?character)
    :effect
      (trained-in-whale-killing ?character)
    :agents
      (?character)
  )
)