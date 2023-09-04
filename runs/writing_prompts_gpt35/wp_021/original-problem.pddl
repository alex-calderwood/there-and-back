(define (problem drug-dealer-story)
  (:domain drug-dealer)
  (:objects
    dealer buyer - person
    heroin cocaine - drug)
  (:init
    (intends dealer (has buyer heroin))
    (intends buyer (craves buyer heroin))
    (intends dealer (has buyer cocaine))
    (intends buyer (craves buyer cocaine))
    (intends buyer (feels buyer (expression "high")))
    (intends buyer (in-withdrawal buyer)))
  (:goal
    (and (not (in-withdrawal buyer))
    (not (intends buyer (craves buyer heroin)))
    (not (intends buyer (craves buyer cocaine)))
    (not (intends buyer (feels buyer (expression "high")))))
  )
)