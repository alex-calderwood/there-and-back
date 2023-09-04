(define (domain habitable-zone)
  (:requirements :strips :typing)
  (:types planet - object)
  (:constants earth - planet)
  (:predicates
    (inside-habitable-zone ?planet - planet)
    (outside-habitable-zone ?planet - planet)
    (liquid ?element - element)
    (gaseous ?element - element)
    (orbiting ?element - element ?planet - planet)
    (falling ?element - element)
    (superheated ?element - element)
    (part-of-solar-wind ?element - element)
  )

  ;; An element is in a gaseous state.
  (:action gasify
    :parameters
      (?element - element)
    :precondition
      (and (not (gaseous ?element))
      (not (falling ?element)))
    :effect
      (and (not (liquid ?element))
      (gaseous ?element))
  )

  ;; An element is in a liquid state.
  (:action liquify
    :parameters
      (?element - element)
    :precondition
      (and (not (liquid ?element))
      (not (falling ?element)))
    :effect
      (and (not (gaseous ?element))
      (liquid ?element))
  )

  ;; An element is orbiting a planet.
  (:action orbit
    :parameters
      (?element - element ?planet - planet)
    :precondition
      (and (not (falling ?element))
      (not (orbiting ?element ?planet)))
    :effect
      (orbiting ?element ?planet)
  )

  ;; An element is falling toward a planet.
  (:action fall
    :parameters
      (?element - element ?planet - planet)
    :precondition
      (and (orbiting ?element ?planet)
      (not (falling ?element)))
    :effect
      (falling ?element)
  )

  ;; An element is superheated.
  (:action superheat
    :parameters
      (?element - element)
    :precondition
      (and (gaseous ?element)
      (not (superheated ?element)))
    :effect
      (superheated ?element)
  )

  ;; An element is part of the solar wind.
  (:action solar-wind
    :parameters
      (?element - element)
    :precondition
      (and (superheated ?element)
      (not (part-of-solar-wind ?element)))
    :effect
      (part-of-solar-wind ?element)
  )
)