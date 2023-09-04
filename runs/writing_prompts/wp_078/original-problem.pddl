(define (problem king-koopa-story)
  (:domain
    king-koopa)
  (:objects
    king-koopa lady-wendy tyrant-king - character
    kingdom - place)
  (:init
    (alive king-koopa)
    (at king-koopa kingdom)
    (intends king-koopa (married king-koopa lady-wendy))
    (intends king-koopa (freedom kingdom))
    (alive lady-wendy)
    (at lady-wendy kingdom)
    (alive tyrant-king)
    (at tyrant-king kingdom)
    (intends tyrant-king (not (freedom kingdom)))
  )
  (:goal
    (and (married king-koopa lady-wendy)
    (freedom kingdom)
    (not (alive tyrant-king)))
  )
)