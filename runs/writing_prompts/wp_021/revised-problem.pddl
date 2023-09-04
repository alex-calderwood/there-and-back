(define (problem dealer-story-problem)
  (:domain
    dealer-story)
  (:objects
    protagonist dealer - character)
  (:init
    (alive protagonist)
    (alive dealer)
    (has-supply dealer)
    (intends protagonist (high protagonist))
    (intends protagonist (intimate protagonist dealer))
    (intends protagonist (craving protagonist))
  )
  (:goal
    (and (high protagonist)
    (intimate protagonist dealer)
    (craving protagonist))
  )
)