(define (domain lucy-cooking-and-playing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (cooking ?character - character)
    (wants-to-cook ?character - character)
    (playing-with-band ?character - character)
    (wants-to-play-with-band ?character - character)
    (has-fake-drum ?character - character)
  )

  ;; A character starts cooking.
  (:action start-cooking
    :parameters
      (?character - character)
    :precondition
      (wants-to-cook ?character)
    :effect
      (cooking ?character)
    :agents
      (?character)
  )

  ;; A character stops cooking.
  (:action stop-cooking
    :parameters
      (?character - character)
    :precondition
      (cooking ?character)
    :effect
      (not (cooking ?character))
    :agents
      (?character)
  )

  ;; A character starts playing with a band.
  (:action start-playing-with-band
    :parameters
      (?character - character)
    :precondition
      (and (wants-to-play-with-band ?character)
      (has-fake-drum ?character))
    :effect
      (playing-with-band ?character)
    :agents
      (?character)
  )

  ;; A character stops playing with a band.
  (:action stop-playing-with-band
    :parameters
      (?character - character)
    :precondition
      (playing-with-band ?character)
    :effect
      (not (playing-with-band ?character))
    :agents
      (?character)
  )

  ;; A character gets a fake drum.
  (:action get-fake-drum
    :parameters
      (?character - character)
    :effect
      (has-fake-drum ?character)
    :agents
      (?character)
  )
)