(define (problem obama-election)
  (:domain obama-election)
  (:objects
    obama celebrity - person)
  (:init
    (famous obama)
    (intends obama (winning obama))
    (intends obama (succeeding obama))
    (intends celebrity (winning obama))
    (intends celebrity (succeeding obama))
    (intends celebrity (hearing celebrity))
    (not (hearing obama))
    (not (burning obama)))
  (:goal
    (and (succeeding obama)
    (hearing celebrity)))
)