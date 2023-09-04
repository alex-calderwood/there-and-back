(define (problem play-with-ball)
  (:domain
    big-red-ball)
  (:objects
    lily tim - character)
  (:init
    (has lily ball)
    (intends lily (friends lily tim))
    (intends lily (played-together lily tim))
    (intends lily (happy lily))
    (intends tim (friends tim lily))
    (intends tim (played-together tim lily))
    (intends tim (happy tim)))
  (:goal
    (and (friends lily tim)
    (played-together lily tim)
    (happy lily)
    (happy tim))
  )
)