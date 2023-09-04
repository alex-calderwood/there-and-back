(define (problem winter-palace)
  (:domain winter-palace)
  (:objects
    boatman man - character
    lake farrowind - place)
  (:init
    (alive boatman)
    (at boatman lake)
    (intends boatman (alive boatman))
    (alive man)
    (at man lake)
    (intends man (alive man))
    (knows man winter)
    (intends man (has man winter)))
  (:goal
    (and (not (alive king))
    (has man winter))
  )
)