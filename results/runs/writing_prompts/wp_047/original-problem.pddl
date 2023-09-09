(define (problem world-peace)
  (:domain
    world-unity)
  (:objects
    nation1 nation2 nation3 - nation)
  (:init
    (facing-destruction)
    (intends nation1 (at-peace nation1))
    (intends nation1 (advanced-technology nation1))
    (intends nation2 (at-peace nation2))
    (intends nation2 (advanced-technology nation2))
    (intends nation3 (at-peace nation3))
    (intends nation3 (advanced-technology nation3)))
  (:goal
    (and (at-peace nation1)
    (at-peace nation2)
    (at-peace nation3)
    (advanced-technology nation1)
    (advanced-technology nation2)
    (advanced-technology nation3)
    (not (facing-destruction))))
)