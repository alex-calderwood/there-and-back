(define (problem find-cap)
  (:domain
    tim-and-cap)
  (:objects
    tim - character
    bedroom kitchen toy-box - place
    old-cap new-cap - cap)
  (:init
    (at tim bedroom)
    (has tim old-cap)
    (intends tim (found tim old-cap))
  )
  (:goal
    (and (found tim old-cap)
    (has tim new-cap)
    (not (has tim old-cap)))
  )
)