(define (domain solar-wind-exploration)
  (:requirements :adl :domain-axioms)
  (:types planet society technology - object)
  (:predicates
    (at ?society - society ?planet - planet)
    (has-technology ?society - society ?technology - technology)
    (in-habitable-zone ?planet - planet)
    (in-high-wind-zone ?planet - planet)
    (in-low-wind-zone ?planet - planet)
    (explored ?society - society ?planet - planet)
  )

  ;; A society develops a technology.
  (:action develop-technology
    :parameters
      (?society - society ?technology - technology)
    :effect
      (has-technology ?society ?technology)
  )

  ;; A society explores a planet using a technology.
  (:action explore
    :parameters
      (?society - society ?planet - planet ?technology - technology)
    :precondition
      (and (at ?society ?planet)
      (has-technology ?society ?technology)
      (or (in-habitable-zone ?planet)
      (in-high-wind-zone ?planet)
      (in-low-wind-zone ?planet)))
    :effect
      (explored ?society ?planet)
  )

  ;; A society moves to another planet using a technology.
  (:action move
    :parameters
      (?society - society ?from - planet ?to - planet ?technology - technology)
    :precondition
      (and (at ?society ?from)
      (has-technology ?society ?technology)
      (or (in-habitable-zone ?to)
      (in-high-wind-zone ?to)
      (in-low-wind-zone ?to)))
    :effect
      (and (not (at ?society ?from))
      (at ?society ?to))
  )
)