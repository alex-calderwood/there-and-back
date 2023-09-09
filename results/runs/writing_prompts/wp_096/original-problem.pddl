(define (problem magician-satisfaction)
  (:domain
    magician-show)
  (:objects
    magician assistant - character)
  (:init
    (intends magician (satisfied magician))
    (intends assistant (satisfied magician)))
  (:goal
    (satisfied magician))
)