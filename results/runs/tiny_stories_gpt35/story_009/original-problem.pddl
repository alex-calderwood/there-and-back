(define (problem bookcase-playtime-problem)
  (:domain bookcase-playtime)
  (:objects
    ball - ball
    bookcase room - object)
  (:init
    (at ball room)
    (intends ball (not (fallen ball)))
    (intends ball (not (calm ball)))
    (intends ball (bouncing ball))
    (intends ball (at ball room))
    (intends ball (calm ball))
    (intends ball (not (bouncing ball)))
    (intends ball (at ball room))
    (intends ball (not (fallen ball)))
    (intends ball (at ball room))
    (intends ball (calm ball)))
  (:goal
    (and (at ball room)
    (calm ball)
    (not (bouncing ball))
    (not (fallen ball)))
  )
)