(define (problem timmy-park-adventure)
  (:domain
    timmy-park-adventure)
  (:objects
    timmy mom dad - character
    home park - place)
  (:init
    (at timmy home)
    (at mom home)
    (at dad home)
    (intends timmy (happy timmy))
    (intends mom (happy timmy))
    (intends dad (happy timmy))
    (intends timmy (powerful timmy))
    (intends mom (gathered timmy))
    (intends dad (gathered timmy))
  )
  (:goal
    (and (happy timmy)
    (powerful timmy)
    (gathered timmy))
  )
)