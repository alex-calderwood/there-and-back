(define (problem brother-and-father-tragedy)
  (:domain
    brother-and-father)
  (:objects
    brother father - character
    shotgun - object)
  (:init
    (alive brother)
    (intends brother (tried-revive brother))
    (intends brother (cried brother))
    (dead father)
    (has father shotgun))
  (:goal
    (and (tried-revive brother)
    (cried brother)
    (dead father)))
)