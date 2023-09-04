(define (problem tim-and-ben-friends)
  (:domain
    tim-and-ben)
  (:objects
    tim tom - character
    ben - toy)
  (:init
    (in-drawer ben)
    (intends tim (friends tim ben))
    (intends tom (wants-to-take tom ben))
  )
  (:goal
    (and (friends tim ben)
    (not (wants-to-take tom ben))
    (brave tim))
  )
)