(define (problem playtime)
  (:domain garage-playtime)
  (:objects
    tim mom ball box bird nest - object)
  (:init
    (at tim garage)
    (at mom garage)
    (at ball box)
    (at bird ground)
    (dead bird))
  (:goal
    (and (in-nest bird)
    (at ball tim)))
)