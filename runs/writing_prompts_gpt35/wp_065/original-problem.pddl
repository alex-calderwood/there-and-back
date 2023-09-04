(define (problem apocalypse-game)
  (:domain apocalypse)
  (:objects
    disease nuclear bill colonel-thomas - character
  )
  (:init
    (alive disease)
    (has-followers disease)
    (intends-to-win disease)
    (alive nuclear)
    (has-followers nuclear)
    (intends-to-launch nuclear)
    (alive bill)
    (in-possession bill bunker)
    (alive colonel-thomas)
    (in-possession colonel-thomas bombs)
    (intends colonel-thomas (launched bombs))
    (in-bunker bill)
    (in-bunker colonel-thomas)
    (intends nuclear (not (in-bunker disease))))
  (:goal
    (and (game-over)
    (not (alive disease))
    (launched bombs))
  )
)