(define (problem cooking-and-music-problem)
  (:domain cooking-and-music)
  (:objects
    lucy mom band - person
    fake-drum - instrument
    cookies - food)
  (:init
    (not (cooking-with lucy))
    (not (cooking-with mom))
    (not (playing lucy fake-drum))
    (not (has lucy cookies))
    (not (has mom cookies))
    (not (has band cookies)))
  (:goal
    (and (cooking-with lucy mom)
    (playing lucy fake-drum)
    (has band cookies)))
)