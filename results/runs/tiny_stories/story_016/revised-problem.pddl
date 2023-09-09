(define (problem prince-wizard-lesson)
  (:domain
    prince-and-wizard)
  (:objects
    prince wizard - character)
  (:init
    (happy prince)
    (careless prince)
    (mean wizard)
    (intends prince (wise prince))
    (intends prince (not (happy prince)))
    (intends wizard (tricked prince)))
  (:goal
    (and (wise prince)
    (not (happy prince))))
)