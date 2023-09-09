(define (problem kite-exploration)
  (:domain kite-explorers)
  (:objects
    primitive-society - agent
    mercury venus earth mars jupiter saturn uranus neptune - planet
    solar-wind - wind
    habitable-zone plasma-zone breathable-air-zone - current)
  (:init
    (in-atmosphere mercury)
    (in-atmosphere venus)
    (in-atmosphere earth)
    (in-atmosphere mars)
    (in-atmosphere jupiter)
    (in-atmosphere saturn)
    (in-atmosphere uranus)
    (in-atmosphere neptune)
    (in-current mercury (habitable-zone mercury))
    (in-current venus (habitable-zone venus))
    (in-current earth (habitable-zone earth))
    (in-current mars (habitable-zone mars))
    (in-current jupiter (plasma-zone jupiter))
    (in-current saturn (plasma-zone saturn))
    (in-current uranus (breathable-air-zone uranus))
    (in-current neptune (breathable-air-zone neptune))
    (intends primitive-society (intends primitive-society (explored earth)))
    (intends primitive-society (intends primitive-society (knows (in-wind earth ? ?))))
    (intends primitive-society (intends primitive-society (knows (in-current earth ? ?)))))