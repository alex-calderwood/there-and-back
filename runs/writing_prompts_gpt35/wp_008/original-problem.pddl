(define (problem revive-best-friend)
  (:domain revive-soul)
  (:objects
    brother father mother - person)
  (:init
    (dead brother)
    (best-friend father brother)
    (best-friend mother brother)
    (intends father (revived brother))
    (intends mother (revived brother)))
  (:goal
    (and (revived brother)))
)