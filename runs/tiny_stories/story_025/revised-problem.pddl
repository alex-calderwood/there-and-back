(define (problem fox-and-mouse)
  (:domain
    forest-adventure)
  (:objects
    fox mouse - character
    forest tree - place)
  (:init
    (at fox forest)
    (at mouse tree)
    (intends fox (not (stuck fox tree)))
    (intends fox (helped mouse fox))
    (intends fox (friends mouse fox))
    (intends mouse (helped mouse fox))
    (intends mouse (friends mouse fox))
    (intends fox (friends fox mouse)))
  (:goal
    (friends fox mouse))
)