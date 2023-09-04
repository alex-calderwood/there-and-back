(define (problem clara-plays-outside)
  (:domain
    clara-and-the-storm)
  (:objects
    clara - character
    home outside - place)
  (:init
    (inside clara)
    (raining)
    (muddy outside)
    (intends clara (playing clara))
    (intends clara (safe clara)))
  (:goal
    (and (inside clara)
    (safe clara)
    (playing clara))
  )
)