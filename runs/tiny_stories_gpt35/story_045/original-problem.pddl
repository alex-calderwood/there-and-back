(define (problem sharing-mirror)
  (:domain sharing-friends)
  (:objects
    jack jill - friend
    mirror ice-cream - object
    grandma-house - place)
  (:init
    (at jack grandma-house)
    (at jill grandma-house)
    (at mirror grandma-house)
    (has jack mirror)
    (intends jack (has jill mirror))
    (intends jill (has jack mirror))
    (intends jack (has jack ice-cream))
    (intends jill (has jill ice-cream)))
  (:goal
    (and (has jack ice-cream)
    (has jill ice-cream)
    (has jack mirror)
    (has jill mirror)))
)