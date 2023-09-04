(define (domain kite-explorers)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types
    planet wind current - object
    primitive-society - agent)
  (:constants
    sun - object
    breathable-air - object
    plasma - object
    solar-wind - object
    kite - object)
  (:predicates
    (in-atmosphere ?planet - planet)
    (in-current ?planet - planet ?current - current)
    (in-wind ?planet - planet ?wind - wind)
    (has-kite ?society - primitive-society ?planet - planet)
    (explored ?planet - planet)
    (knows ?society - primitive-society ?fact - expression)
    (intends ?society - primitive-society ?goal - expression)
  )

  ;; Primitive society builds a kite to explore the winds.
  (:action build-kite
    :parameters
      (?society - primitive-society ?planet - planet)
    :precondition
      (and (in-atmosphere ?planet)
      (not (has-kite ?society ?planet)))
    :effect
      (has-kite ?society ?planet)
    :agents
      (?society)
  )

  ;; Primitive society explores a planet.
  (:action explore-planet
    :parameters
      (?society - primitive-society ?planet - planet)
    :precondition
      (and (in-atmosphere ?planet)
      (has-kite ?society ?planet)
      (not (explored ?planet)))
    :effect
      (explored ?planet)
    :agents
      (?society)
  )

  ;; Primitive society learns a fact.
  (:action learn-fact
    :parameters
      (?society - primitive-society ?fact - expression)
    :precondition
      (and (intends ?society ?fact))
    :effect
      (knows ?society ?fact)
    :agents
      (?society)
  )

  ;; Primitive society intends to explore a planet.
  (:action intend-explore
    :parameters
      (?society - primitive-society ?planet - planet)
    :precondition
      (in-atmosphere ?planet)
    :effect
      (intends ?society (explored ?planet))
    :agents
      (?society)
  )

  ;; Primitive society intends to learn a fact.
  (:action intend-learn
    :parameters
      (?society - primitive-society ?fact - expression)
    :effect
      (intends ?society ?fact)
    :agents
      (?society)
  )

  ;; A planet is in a convection current.
  (:axiom
    :vars
      (?planet - planet ?current - current)
    :context
      (and (in-atmosphere ?planet)
      (in-current ?planet ?current))
    :effect
      (in-wind ?planet (wind-from ?current) solar-wind)
  )

  ;; A planet is in the habitable zone.
  (:axiom
    :vars
      (?planet - planet)
    :context
      (in-atmosphere ?planet)
    :effect
      (in-current ?planet (habitable-zone ?planet) ?)
  )

  ;; A planet is in the plasma zone.
  (:axiom
    :vars
      (?planet - planet)
    :context
      (in-atmosphere ?planet)
    :effect
      (in-current ?planet (plasma-zone ?planet) ?)
  )

  ;; A planet is in the breathable air zone.
  (:axiom
    :vars
      (?planet - planet)
    :context
      (in-atmosphere ?planet)
    :effect
      (in-current ?planet (breathable-air-zone ?planet) ?)
  )

  ;; A planet is not in any current.
  (:axiom
    :vars
      (?planet - planet)
    :context
      (in-atmosphere ?planet)
    :effect
      (not (in-current ?planet ?))
  )
)