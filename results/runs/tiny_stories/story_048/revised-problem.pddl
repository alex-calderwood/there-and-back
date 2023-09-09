(define (problem park-fun)
  (:domain
    park-adventure)
  (:objects
    tim mom little-girl - character
    home park slide swings sandbox - place)
  (:init
    (at tim home)
    (at mom home)
    (at little-girl park)
    (at slide park)
    (at swings park)
    (at sandbox park)
    (wet sandbox)
    (sad little-girl)
    (intends tim (happy tim))
    (intends tim (happy little-girl))
    (intends tim (friends tim little-girl))
    (intends mom (happy tim))
    (intends mom (dry sandbox))
  )
  (:goal
    (and (happy tim)
    (happy little-girl)
    (friends tim little-girl))
  )
)