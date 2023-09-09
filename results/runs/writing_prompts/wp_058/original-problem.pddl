(define (problem save-magical-bird)
  (:domain
    magical-bird)
  (:objects
    girl papa finn - character
    shed - object
    magical-bird - bird)
  (:init
    (at girl shed)
    (alive girl)
    (intends girl (alive girl))
    (alive papa)
    (intends papa (alive papa))
    (alive finn)
    (intends finn (alive finn))
    (locked shed)
    (tracks finn shed)
    (blood-trail finn shed)
    (inside magical-bird shed)
    (injured magical-bird))
  (:goal
    (and (not (injured magical-bird))
    (has girl magical-bird)))
)