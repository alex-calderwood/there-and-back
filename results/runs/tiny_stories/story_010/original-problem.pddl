(define (problem skelly-cake-party)
  (:domain
    skelly-cake)
  (:objects
    skelly friend1 friend2 friend3 - character)
  (:init
    (happy skelly)
    (intends skelly (cake-made))
    (intends skelly (full skelly))
    (intends skelly (playing-games skelly))
    (happy friend1)
    (intends friend1 (full friend1))
    (intends friend1 (playing-games friend1))
    (happy friend2)
    (intends friend2 (full friend2))
    (intends friend2 (playing-games friend2))
    (happy friend3)
    (intends friend3 (full friend3))
    (intends friend3 (playing-games friend3))
  )
  (:goal
    (and (cake-made)
    (full skelly)
    (full friend1)
    (full friend2)
    (full friend3)
    (playing-games skelly)
    (playing-games friend1)
    (playing-games friend2)
    (playing-games friend3))
  )
)