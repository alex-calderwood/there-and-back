(define (problem frog-and-whale)
  (:domain frog-pond)
  (:objects
    tim sam - character
    hut pond - location)
  (:init
    (alive tim)
    (at tim hut)
    (intends tim (alive tim))
    (intends tim (playing tim))
    (friends tim sam)
    (alive sam)
    (at sam pond)
    (intends sam (alive sam))
    (intends sam (playing sam))
    (intends sam (transform sam))
    (intends sam (make-happy sam))
  )
  (:goal
    (and (at tim pond)
    (at sam pond)
    (happy tim)
    (happy sam)
    (whale sam))
  )
)