(define (problem cat-dog-park)
  (:domain
    cat-dog-park)
  (:objects
    tom big-dog - character
    park - place
    big-seat small-seat - seat)
  (:init
    (at tom park)
    (at big-dog park)
    (big big-seat)
    (small small-seat)
    (sitting big-dog big-seat)
    (important big-dog)
    (intends tom (sitting tom small-seat))
    (intends big-dog (sitting big-dog big-seat))
  )
  (:goal
    (and (sitting tom small-seat)
    (sitting big-dog small-seat)
    (broken big-seat))
  )
)