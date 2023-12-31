(define (problem dream-torture)
  (:domain dreamscape)
  (:objects
    dreamer monster box material - object)
  (:init
    (in-dream dreamer)
    (alive dreamer)
    (has-power dreamer)
    (in-dream monster)
    (alive monster)
    (face monster late-wife-face)
    (loves dreamer monster)
    (intends dreamer (not (face dreamer late-wife-face)))
    (intends dreamer (not (crying monster)))
    (intends dreamer (not (holding monster dreamer))))
  (:goal
    (and (in-dream dreamer)
    (alive dreamer)
    (has-power dreamer)
    (not (face dreamer late-wife-face)))
  )
)