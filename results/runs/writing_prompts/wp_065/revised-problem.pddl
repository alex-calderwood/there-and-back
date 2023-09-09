(define (problem apocalypse-game)
  (:domain
    apocalypse-game)
  (:objects
    disease nuclear - god
    bill colonel-thomas - character
    bunker - bunker)
  (:init
    (has-followers disease)
    (has-followers nuclear)
    (intends disease (disease-spreading))
    (intends nuclear (bombs-launched))
    (alive bill)
    (alive colonel-thomas)
    (in-bunker bill bunker)
    (in-bunker colonel-thomas bunker))
  (:goal
    (and (not (has-followers disease))
    (not (has-followers nuclear))))
)