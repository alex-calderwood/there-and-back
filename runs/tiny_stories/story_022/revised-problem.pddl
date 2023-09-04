(define (problem foggy-friends)
  (:domain
    foggy-adventure)
  (:objects
    max ben - character
    home park - place
    ball - item)
  (:init
    (at max home)
    (at ben park)
    (has max ball)
    (foggy park)
    (intends max (found ball))
    (intends max (happy max))
    (intends max (friends max ben))
    (intends ben (at ben home))
    (intends ben (happy ben))
    (intends ben (friends max ben)))
  (:goal
    (and (found ball)
    (at ben home)
    (happy max)
    (happy ben)
    (friends max ben))
  )
)