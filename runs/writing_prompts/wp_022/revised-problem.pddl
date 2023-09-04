(define (problem prank-message)
  (:domain
    prank-message)
  (:objects
    jimmy j-frantz - character)
  (:init
    (intends j-frantz (pranked j-frantz jimmy)))
  (:goal
    (pranked j-frantz jimmy))
)