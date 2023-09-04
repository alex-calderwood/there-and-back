(define (domain robot-helper)
  (:requirements :strips :typing :equality)
  (:types robot - object)
  (:predicates
    (owned ?robot - robot)
    (working ?robot - robot)
    (maintained ?robot - robot)
    (playing-video-games)
  )

  ;; A robot is owned by a person.
  (:action own-robot
    :parameters
      (?robot - robot)
    :precondition
      (not (owned ?robot))
    :effect
      (owned ?robot)
  )

  ;; A robot is maintained by a person.
  (:action maintain-robot
    :parameters
      (?robot - robot)
    :precondition
      (and (owned ?robot)
      (working ?robot))
    :effect
      (maintained ?robot)
  )

  ;; A robot is not working.
  (:action break-robot
    :parameters
      (?robot - robot)
    :precondition
      (and (owned ?robot)
      (working ?robot))
    :effect
      (not (working ?robot))
  )

  ;; A robot is working.
  (:action fix-robot
    :parameters
      (?robot - robot)
    :precondition
      (and (owned ?robot)
      (not (working ?robot))
      (maintained ?robot))
    :effect
      (working ?robot)
  )

  ;; A robot plays video games.
  (:action play-video-games
    :precondition
      (and (owned ?robot)
      (working ?robot))
    :effect
      (playing-video-games)
  )
)