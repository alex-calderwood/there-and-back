(define (problem bunny-and-bird-game)
  (:domain bunny-and-bird)
  (:objects
    bob tim - character
    ball - ball
    bridge home - object)
  (:init
    (at bob bridge)
    (at tim bridge)
    (at ball bridge)
    (intends bob (not (tired)))
    (intends tim (not (tired)))
    (intends bob (playing))
    (intends tim (playing)))
  (:goal
    (and (not (playing))
    (not (tired))
    (at bob home)
    (at tim home)
    (intends bob (not (tired)))
    (intends tim (not (tired)))) 
  )
)