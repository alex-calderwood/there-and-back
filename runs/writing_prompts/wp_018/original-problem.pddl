(define (problem grim-reaper-transition)
  (:domain
    grim-reaper)
  (:objects
    old-reaper protagonist - character)
  (:init
    (alive old-reaper)
    (dead protagonist)
    (reaper old-reaper)
    (has-scythe old-reaper)
    (has-robe old-reaper)
    (intends old-reaper (retired old-reaper))
    (intends protagonist (reaper protagonist))
    (intends protagonist (has-scythe protagonist))
    (intends protagonist (has-robe protagonist))
  )
  (:goal
    (and (retired old-reaper)
    (reaper protagonist)
    (has-scythe protagonist)
    (has-robe protagonist))
  )
)