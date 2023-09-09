(define (problem moving-on)
  (:domain breakup)
  (:objects
    myself - person)
  (:init
    (feels-awful myself)
    (thinking-about-breakup myself)
    (picks-wrong-partner myself)
    (intends myself (moves-on myself)))
  (:goal
    (and (not (thinking-about-breakup myself))
    (moves-on myself))
  )
)