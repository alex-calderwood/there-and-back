(define (problem park-swing-problem)
  (:domain park-swing)
  (:objects
    joe paul - friend)
  (:init
    (at-park)
    (intends joe (on-swing paul))
    (intends paul (on-swing joe)))
  (:goal
    (and (not (on-swing joe))
    (not (on-swing paul))))
)