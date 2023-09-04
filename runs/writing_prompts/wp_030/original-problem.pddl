(define (problem solar-wind-exploration-problem)
  (:domain
    solar-wind-exploration)
  (:objects
    home-planet hellhole-planet distant-planet - planet
    primitive-society - society
    kite-technology - technology)
  (:init
    (at primitive-society home-planet)
    (in-habitable-zone home-planet)
    (in-high-wind-zone hellhole-planet)
    (in-low-wind-zone distant-planet))
  (:goal
    (and (explored primitive-society hellhole-planet)
    (explored primitive-society distant-planet)
    (has-technology primitive-society kite-technology)))
)