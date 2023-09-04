(define (domain tom-the-cat)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (playing ?character - character)
    (tired ?character - character)
    (sleeping ?character - character)
    (awake ?character - character)
    (has-energy ?character - character)
  )

  ;; A character starts playing.
  (:action start-playing
    :parameters
      (?character - character)
    :precondition
      (and (awake ?character)
      (not (playing ?character))
      (has-energy ?character))
    :effect
      (playing ?character)
    :agents
      (?character)
  )

  ;; A character stops playing.
  (:action stop-playing
    :parameters
      (?character - character)
    :precondition
      (playing ?character)
    :effect
      (and (not (playing ?character))
      (tired ?character))
    :agents
      (?character)
  )

  ;; A character goes to sleep.
  (:action sleep
    :parameters
      (?character - character)
    :precondition
      (and (tired ?character)
      (not (sleeping ?character)))
    :effect
      (and (not (awake ?character))
      (sleeping ?character))
    :agents
      (?character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (sleeping ?character)
    :effect
      (and (awake ?character)
      (not (sleeping ?character))
      (not (tired ?character))
      (has-energy ?character))
    :agents
      (?character)
  )
)