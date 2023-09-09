(define (problem prince-story-problem)
  (:domain prince-story)
  (:objects
    prince wizard - person)
  (:init
    (not (talked-to prince wizard))
    (not (talked-to wizard prince))
    (intends prince (not (tricked prince)))
    (intends prince (not (cried prince)))
    (intends prince (wise prince))
    (intends prince (not (happy prince)))
    (intends wizard (tricked prince))
    (intends wizard (not (happy prince))))
  (:goal
    (and (wise prince)
    (happy prince))
  )
)