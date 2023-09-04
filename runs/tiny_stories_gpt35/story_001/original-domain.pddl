(define (domain clara-rainy-day)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types character - object)
  (:predicates
    (outside ?character - character)
    (covered-in-mud ?character - character)
    (scared ?character - character)
    (frozen ?character - character)
    (heard-noise ?character - character)
    (saw-animal ?character - character)
    (brave ?character - character)
    (inside ?character - character)
  )

  ;; A character moves from inside to outside or vice versa.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (or (and (inside ?character ?from)
      (outside ?to))
      (and (outside ?character ?from)
      (inside ?to))))
    :effect
      (and (not (inside ?character ?from))
      (not (outside ?character ?from))
      (inside ?character ?to))
    :agents
      (?character)
  )

  ;; A character steps into a muddy puddle.
  (:action step-in-puddle
    :parameters
      (?character - character ?puddle - object)
    :precondition
      (and (outside ?character)
      (at ?puddle)
      (not (covered-in-mud ?character)))
    :effect
      (covered-in-mud ?character)
    :agents
      (?character)
  )

  ;; A character hears a loud noise.
  (:action hear-noise
    :parameters
      (?character - character)
    :precondition
      (outside ?character)
    :effect
      (heard-noise ?character)
    :agents
      (?character)
  )

  ;; A character sees an animal.
  (:action see-animal
    :parameters
      (?character - character)
    :precondition
      (and (outside ?character)
      (not (frozen ?character)))
    :effect
      (saw-animal ?character)
    :agents
      (?character)
  )

  ;; A character becomes scared.
  (:action become-scared
    :parameters
      (?character - character)
    :precondition
      (and (outside ?character)
      (or (heard-noise ?character)
      (saw-animal ?character)))
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
      (and (scared ?character)
      (not (frozen ?character)))
    :effect
      (brave ?character)
    :agents
      (?character)
  )

  ;; A character goes inside.
  (:action go-inside
    :parameters
      (?character - character)
    :precondition
      (and (inside ?character)
      (not (frozen ?character)))
    :effect
      (not (outside ?character))
    :agents
      (?character)
  )

  ;; A character becomes frozen.
  (:action become-frozen
    :parameters
      (?character - character)
    :precondition
      (and (scared ?character)
      (not (brave ?character)))
    :effect
      (frozen ?character)
    :agents
      (?character)
  )
)