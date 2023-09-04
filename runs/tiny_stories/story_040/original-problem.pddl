(define (problem tim-toy-mountain)
  (:domain
    tim-and-the-mountain)
  (:objects
    tim big-bird - character
    mountain - place
    toy - toy)
  (:init
    (at tim mountain)
    (scared tim)
    (intends tim (has tim toy))
    (intends tim (not (scared tim)))
    (intends tim (friends tim big-bird))
    (at big-bird mountain)
    (on-top toy mountain))
  (:goal
    (and (has tim toy)
    (friends tim big-bird)
    (not (scared tim))))
)