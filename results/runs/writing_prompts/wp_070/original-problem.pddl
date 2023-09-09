(define (problem ice-cream-discussion)
  (:domain
    ice-cream-discussion)
  (:objects
    user - character
    mackinac-island-fudge - flavor)
  (:init
    (alive user)
    (intends user (discussing user (tag-rules)))
    (intends user (favorite-flavor user mackinac-island-fudge)))
  (:goal
    (and (discussing user (tag-rules))
    (discussing user (new-tag))
    (favorite-flavor user mackinac-island-fudge)))
)