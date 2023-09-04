(define (problem rabbit-wins-race)
  (:domain
    rabbit-race)
  (:objects
    rabbit big-kids - character)
  (:init
    (scared rabbit)
    (intends rabbit (winner rabbit))
    (intends rabbit (celebrating rabbit))
    (intends big-kids (winner big-kids))
  )
  (:goal
    (and (winner rabbit)
         (celebrating rabbit)
         (not (winner big-kids))))
)