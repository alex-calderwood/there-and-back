(define (problem peter-alone)
  (:domain
    neverland)
  (:objects
    beach - place
    tinkerbell - character
    wendy - character
    children - group
  )
  (:init
    (at peter beach)
    (alive peter)
    (intends peter (alive peter))
    (at hook beach)
    (not (alive hook))
    (in-group hook pirates)
    (not (group-exists pirates))
    (in-group wendy lost-boys)
    (not (group-exists lost-boys))
    (in-group tinkerbell children)
    (not (group-exists children))
    (believes-in-fairies peter)
  )
  (:goal
    (and (not (alive peter))
    (not (believes-in-fairies peter)))
  )
)