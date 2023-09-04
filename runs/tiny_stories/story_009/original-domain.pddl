(define (domain bookcase-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (reading ?character - character)
    (playing ?character - character)
    (calm ?character - character)
    (books-fall)
  )

  ;; A character starts reading.
  (:action start-reading
    :parameters
      (?character - character)
    :precondition
      (not (reading ?character))
    :effect
      (reading ?character)
    :agents
      (?character)
  )

  ;; A character stops reading.
  (:action stop-reading
    :parameters
      (?character - character)
    :precondition
      (reading ?character)
    :effect
      (not (reading ?character))
    :agents
      (?character)
  )

  ;; A character starts playing.
  (:action start-playing
    :parameters
      (?character - character)
    :precondition
      (not (playing ?character))
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
      (not (playing ?character))
    :agents
      (?character)
  )

  ;; A character becomes calm.
  (:action become-calm
    :parameters
      (?character - character)
    :precondition
      (not (calm ?character))
    :effect
      (calm ?character)
    :agents
      (?character)
  )

  ;; A character becomes uncalm.
  (:action become-uncalm
    :parameters
      (?character - character)
    :precondition
      (calm ?character)
    :effect
      (not (calm ?character))
    :agents
      (?character)
  )

  ;; The books fall.
  (:action books-fall
    :precondition
      (not (books-fall))
    :effect
      (books-fall)
  )
)