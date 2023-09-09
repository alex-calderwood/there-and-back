(define (problem dog-and-cat-trust)
  (:domain
    dog-and-cat)
  (:objects
    max whiskers - character)
  (:init
    (happy max)
    (intends max (happy max))
    (intends max (searched-for-bone max))
    (intends max (gave-treat max whiskers))
    (intends max (not (trusts max whiskers)))
    (intends whiskers (tricked whiskers max))
  )
  (:goal
    (and (tricked whiskers max)
    (not (trusts max whiskers))
    (searched-for-bone max)
    (gave-treat max whiskers)
    (sad max))
  )
)