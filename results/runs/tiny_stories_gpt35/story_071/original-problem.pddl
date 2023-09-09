(define (problem bird-escape-problem)
  (:domain bird-escape)
  (:objects
    bella - bird
    tom - cat)
  (:init
    (in-cage bella)
    (knows-escape-idea tom)
    (intends tom (knows-escape-idea bella)))
  (:goal
    (free bella)
  )
)