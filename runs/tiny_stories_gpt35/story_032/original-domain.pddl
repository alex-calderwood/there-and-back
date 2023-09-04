(define (domain volcano-explorers)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (counting-coins ?person - person)
    (laughing ?person - person)
    (rude ?person - person)
    (polite ?person - person)
    (kind ?person - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
    :agents
      (?person)
  )

  ;; A person starts counting coins.
  (:action start-counting
    :parameters
      (?person - person)
    :precondition
      (and (not (counting-coins ?person))
      (not (laughing ?person))
      (at ?person ?location))
    :effect
      (counting-coins ?person)
    :agents
      (?person)
  )

  ;; A person stops counting coins.
  (:action stop-counting
    :parameters
      (?person - person)
    :precondition
      (counting-coins ?person)
    :effect
      (not (counting-coins ?person))
    :agents
      (?person)
  )

  ;; A person laughs at another person.
  (:action laugh
    :parameters
      (?laugher - person ?laughee - person)
    :precondition
      (and (not (= ?laugher ?laughee))
      (not (counting-coins ?laughee))
      (at ?laugher ?location)
      (at ?laughee ?location))
    :effect
      (laughing ?laugher)
    :agents
      (?laugher)
  )

  ;; A person apologizes to another person.
  (:action apologize
    :parameters
      (?apologizer - person ?apologizee - person)
    :precondition
      (and (not (= ?apologizer ?apologizee))
      (laughing ?apologizer)
      (at ?apologizer ?location)
      (at ?apologizee ?location))
    :effect
      (and (not (laughing ?apologizer))
      (polite ?apologizer)
      (kind ?apologizer))
    :agents
      (?apologizer)
  )

  ;; A person gets yelled at by another person.
  (:action yell
    :parameters
      (?yeller - person ?yellee - person)
    :precondition
      (and (not (= ?yeller ?yellee))
      (laughing ?yellee)
      (at ?yeller ?location)
      (at ?yellee ?location))
    :effect
      (and (not (laughing ?yellee))
      (rude ?yeller))
    :agents
      (?yeller)
  )

  ;; A person learns to be polite and kind.
  (:action learn
    :parameters
      (?person - person)
    :precondition
      (and (not (polite ?person))
      (not (kind ?person)))
    :effect
      (and (polite ?person)
      (kind ?person))
    :agents
      (?person)
  )
)