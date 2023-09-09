(define (problem frog-and-whale)
  (:domain
    frog-and-whale)
  (:objects
    tim - character
    sam - character
    pond - place
  )
  (:init
    (at tim pond)
    (at sam pond)
    (intends tim (friends tim sam))
    (intends tim (happy tim))
    (intends sam (friends tim sam))
    (intends sam (happy sam))
    (intends sam (grow sam))
    (intends sam (whale sam))
  )
  (:goal
    (and (friends tim sam)
    (happy tim)
    (happy sam)
    (grow sam)
    (whale sam))
  )
)