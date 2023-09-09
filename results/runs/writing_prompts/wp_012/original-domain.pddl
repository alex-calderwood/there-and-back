(define (domain carl-and-carl-jr)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character robot - object)
  (:predicates
    (at ?character - character ?location - object)
    (assembled ?robot - robot)
    (has-robot ?character - character ?robot - robot)
    (working-on-task ?robot - robot)
    (playing-game ?character - character)
  )

  ;; A character assembles a robot.
  (:action assemble
    :parameters
      (?character - character ?robot - robot)
    :precondition
      (and (at ?character garage)
      (not (assembled ?robot)))
    :effect
      (and (assembled ?robot)
      (has-robot ?character ?robot))
    :agents  (?character)
  )

  ;; A robot starts working on a task.
  (:action start-task
    :parameters
      (?robot - robot)
    :precondition
      (and (assembled ?robot)
      (not (working-on-task ?robot)))
    :effect
      (working-on-task ?robot)
    :agents  (?robot)
  )

  ;; A character starts playing a game.
  (:action play-game
    :parameters
      (?character - character)
    :precondition
      (and (at ?character house)
      (not (playing-game ?character)))
    :effect
      (playing-game ?character)
    :agents  (?character)
  )

  ;; A character stops playing a game.
  (:action stop-game
    :parameters
      (?character - character)
    :precondition
      (playing-game ?character)
    :effect
      (not (playing-game ?character))
    :agents  (?character)
  )
)