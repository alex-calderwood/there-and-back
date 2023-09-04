(define (problem end-of-humanity-problem)
  (:domain
    end-of-humanity)
  (:objects
    protagonist - character)
  (:init
    (alive protagonist)
    (last-soul protagonist)
    (intends protagonist (alive protagonist))
    (intends protagonist (feeling protagonist))
    (intends protagonist (witness protagonist))
    (intends protagonist (understand protagonist))
    (intends protagonist (end protagonist))
  )
  (:goal
    (and (not (alive protagonist))
    (feeling protagonist)
    (witness protagonist)
    (understand protagonist)
    (end protagonist))
  )
)