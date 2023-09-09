(define (problem park-fun)
  (:domain park-playtime)
  (:objects
    tim mom little-girl - person
    slide swings sandbox - object)
  (:init
    (at tim home)
    (at mom home)
    (at little-girl sandbox)
    (wet sandbox)
    (intends tim (playing tim))
    (intends tim (become-best-friends tim little-girl))
    (intends mom (playing mom)))
  (:goal
    (and (playing tim)
    (playing little-girl)
    (best-friends tim little-girl)
    (not (crying little-girl))))
)