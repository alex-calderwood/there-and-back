(define (problem mask-play)
  (:domain
    mask-friends)
  (:objects
    tim friend1 friend2 friend3 - character
    mask - object)
  (:init
    (alive tim)
    (intends tim (alive tim))
    (alive friend1)
    (intends friend1 (alive friend1))
    (alive friend2)
    (intends friend2 (alive friend2))
    (alive friend3)
    (intends friend3 (alive friend3))
    (friends tim friend1)
    (friends tim friend2)
    (friends tim friend3)
    (friends friend1 tim)
    (friends friend2 tim)
    (friends friend3 tim))
  (:goal
    (and (recognize tim friend1)
    (recognize tim friend2)
    (recognize tim friend3)
    (recognize friend1 tim)
    (recognize friend2 tim)
    (recognize friend3 tim)
    (not (wearing tim mask))))
)