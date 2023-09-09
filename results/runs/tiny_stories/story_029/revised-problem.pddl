(define (problem tim-and-bird)
  (:domain
    tim-and-bird)
  (:objects
    tim mom bird - character
    garage - place
    big-red-ball big-box - item)
  (:init
    (at tim garage)
    (at mom garage)
    (alive tim)
    (alive mom)
    (intends tim (alive tim))
    (intends mom (alive mom))
    (intends mom (alive tim))
    (near big-red-ball big-box)
    (in-nest bird)
    (alive bird))
  (:goal
    (and (has tim big-red-ball)
    (in-nest bird)))
)