(define (domain clara-and-the-storm)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (raining)
    (sunny)
    (muddy ?place - place)
    (playing ?character - character)
    (scared ?character - character)
    (brave ?character - character)
    (safe ?character - character)
    (inside ?character - character)
  )

  ;; A character goes outside.
  (:action go-outside
    :parameters
      (?character - character)
    :precondition
      (and (inside ?character)
      (sunny))
    :effect
      (and (not (inside ?character))
      (at ?character outside))
    :agents
      (?character)
  )

  ;; A character goes inside.
  (:action go-inside
    :parameters
      (?character - character)
    :precondition
      (at ?character outside)
    :effect
      (and (not (at ?character outside))
      (inside ?character)
      (safe ?character))
    :agents
      (?character)
  )

  ;; A character plays in the mud.
  (:action play-in-mud
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (muddy ?place))
    :effect
      (playing ?character)
    :agents
      (?character)
  )

  ;; A character becomes scared.
  (:action become-scared
    :parameters
      (?character - character)
    :precondition
      (and (at ?character outside)
      (not (scared ?character)))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character becomes brave.
  (:action become-brave
    :parameters
      (?character - character)
    :precondition
      (and (at ?character outside)
      (scared ?character))
    :effect
      (and (not (scared ?character))
      (brave ?character))
    :agents
      (?character)
  )

  ;; The weather changes from raining to sunny.
  (:action stop-raining
    :precondition
      (raining)
    :effect
      (and (not (raining))
      (sunny))
  )

  ;; The weather changes from sunny to raining.
  (:action start-raining
    :precondition
      (sunny)
    :effect
      (and (not (sunny))
      (raining))
  )
)