(define (problem bird-adventure)
  (:domain
    bird-adventure)
  (:objects
    tim sam - bird
    ground sky trees houses - place)
  (:init
    (on-ground tim)
    (intends tim (in-sky tim))
    (intends tim (friends tim sam))
    (intends tim (happy tim))
    (on-ground sam)
    (intends sam (friends sam tim))
  )
  (:goal
    (and (friends tim sam)
    (happy tim))
  )
)