(define (problem lonely-boy-friend)
  (:domain lonely-boy)
  (:objects
    tim tom - character
    drawer room - object
    ben - toy)
  (:init
    (alive tim)
    (at ben drawer)
    (scared ben)
    (talking ben)
    (intends ben (friend tim ben))
    (alive tom)
    (at tom room)
    (intends tom (not (has tom ben))))
  (:goal
    (and (friend tim ben)
    (not (intends tom (has tom ben))))
  )
)