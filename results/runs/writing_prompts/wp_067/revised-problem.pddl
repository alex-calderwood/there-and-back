(define (problem nightmare-escape)
  (:domain
    nightmare-control)
  (:objects
    protagonist late-wife - character
    monster - monster
    impenetrable-material - object)
  (:init
    (alive protagonist)
    (in-dream protagonist)
    (nightmare monster)
    (impenetrable impenetrable-material)
    (face-of-deceased monster late-wife))
  (:goal
    (and (control-dream protagonist)
    (trapped monster)))
  (:intention
    (and (intends protagonist (control-dream protagonist))
    (intends protagonist (trapped monster))))
)