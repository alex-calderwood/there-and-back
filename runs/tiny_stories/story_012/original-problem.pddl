(define (problem play-with-yarn)
  (:domain
    kitty-and-doggy)
  (:objects
    kitty doggy - character)
  (:init
    (nervous kitty)
    (intends kitty (happy kitty))
    (intends kitty (can-play-with-yarn kitty))
    (happy doggy)
    (can-play-with-yarn doggy)
    (intends doggy (happy doggy))
  )
  (:goal
    (and (happy kitty)
    (can-play-with-yarn kitty)
    (happy doggy))
  )
)