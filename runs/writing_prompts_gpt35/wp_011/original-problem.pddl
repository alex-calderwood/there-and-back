(define (problem first-contact)
  (:domain space-fart-machines)
  (:objects
    qlorog qlala qlaaf qllalee - character
    spindle data-receptor visi-hook - device
    birdies - lifeform
    qqlchar-1 - place)
  (:init
    (in-stasis birdies)
    (fragile birdies)
    (shielded birdies)
    (at qlorog qqlchar-1)
    (has qlorog spindle)
    (intends qlorog (alive qlorog))
    (intends qlorog (detect spindle))
    (at qlala qqlchar-1)
    (intends qlala (alive qlala))
    (intends qlala (tow birdies qqlchar-base-1))
    (intends qlala (tow-in birdies qqlchar-base-1))
    (intends qlala (wake-up birdies))
    (intends qlala (alive birdies)))
  (:goal
    (and (at birdies qqlchar-base-1)
    (intends birdies (alive birdies)))
  )
)