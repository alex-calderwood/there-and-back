(define (problem fox-and-mouse-story)
  (:domain fox-and-mouse)
  (:objects
    fox mouse - character
    tree - place)
  (:init
    (at fox tree)
    (at mouse tree)
    (intends fox (not (stuck fox tree)))
    (intends mouse (not (stuck mouse tree)))
    (intends fox (best-friends fox mouse))
    (intends mouse (best-friends mouse fox)))
  (:goal
    (and (best-friends fox mouse)
    (best-friends mouse fox))
  )
)