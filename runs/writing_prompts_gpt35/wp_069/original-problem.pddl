(define (problem habitable-zone-problem)
  (:domain habitable-zone)
  (:objects
    CO2 O2 N - element
    earth - planet)
  (:init
    (inside-habitable-zone earth)
    (intends earth (inside-habitable-zone earth))
  )
  (:goal
    (and (outside-habitable-zone earth)
    (falling CO2)
    (falling O2)
    (falling N)
    (part-of-solar-wind CO2)
    (part-of-solar-wind O2)
    (part-of-solar-wind N))
  )
)