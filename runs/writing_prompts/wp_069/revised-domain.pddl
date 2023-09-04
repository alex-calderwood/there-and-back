(define (domain habitable-zone)
  (:requirements :adl :domain-axioms)
  (:types zone - object)
  (:constants
    inner-zone - zone
    outer-zone - zone
    edge-zone - zone
  )
  (:predicates
    (habitable ?zone - zone)
    (supports-life ?zone - zone)
    (hot ?zone - zone)
    (cold ?zone - zone)
    (gaseous-state ?zone - zone)
    (liquid-state ?zone - zone)
    (solar-wind ?zone - zone)
  )

  ;; The zone becomes hot.
  (:action heat-zone
    :parameters
      (?zone - zone)
    :precondition
      (and (not (hot ?zone))
      (habitable ?zone))
    :effect
      (hot ?zone)
  )

  ;; The zone becomes cold.
  (:action cool-zone
    :parameters
      (?zone - zone)
    :precondition
      (and (not (cold ?zone))
      (not (habitable ?zone)))
    :effect
      (cold ?zone)
  )

  ;; The zone transitions to a gaseous state.
  (:action gaseous-transition
    :parameters
      (?zone - zone)
    :precondition
      (and (not (gaseous-state ?zone))
      (liquid-state ?zone))
    :effect
      (and (gaseous-state ?zone)
      (not (liquid-state ?zone)))
  )

  ;; The zone transitions to a liquid state.
  (:action liquid-transition
    :parameters
      (?zone - zone)
    :precondition
      (and (not (liquid-state ?zone))
      (gaseous-state ?zone))
    :effect
      (and (liquid-state ?zone)
      (not (gaseous-state ?zone)))
  )

  ;; The zone is affected by solar wind.
  (:action solar-wind-effect
    :parameters
      (?zone - zone)
    :precondition
      (and (not (solar-wind ?zone))
      (gaseous-state ?zone))
    :effect
      (solar-wind ?zone)
  )

  ;; When a zone is hot, it supports life.
  (:axiom
    :vars
      (?zone - zone)
    :context
      (and (not (supports-life ?zone))
      (hot ?zone))
    :implies
      (supports-life ?zone)
  )

  ;; When a zone is cold, it does not support life.
  (:axiom
    :vars
      (?zone - zone)
    :context
      (and (supports-life ?zone)
      (cold ?zone))
    :implies
      (not (supports-life ?zone))
  )
)