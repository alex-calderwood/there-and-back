(define (problem kitty-and-doggy-play-with-yarn)
  (:domain kitty-and-doggy)
  (:objects
    kitty doggy - animal
    ball-of-yarn living-room - object)
  (:init
    (at kitty living-room)
    (at doggy living-room)
    (at ball-of-yarn living-room)
    (has-yarn kitty)
    (intends kitty (playing kitty))
    (intends doggy (playing doggy)))
  (:goal
    (and (playing kitty)
    (playing doggy)))
)