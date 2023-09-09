(define (problem habitable-zone-life)
  (:domain
    habitable-zone)
  (:objects
    inner-zone outer-zone edge-zone - zone)
  (:init
    (habitable inner-zone)
    (not (habitable outer-zone))
    (not (habitable edge-zone))
    (hot inner-zone)
    (cold outer-zone)
    (cold edge-zone)
    (gaseous-state inner-zone)
    (liquid-state edge-zone))
  (:goal
    (and (supports-life inner-zone)
    (not (supports-life outer-zone))
    (not (supports-life edge-zone))
    (solar-wind inner-zone)))
)