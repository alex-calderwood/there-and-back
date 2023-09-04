(define (problem the-six-story)
  (:domain
    the-six)
  (:objects
    roth raquel - character
    man-hut-ton - place)
  (:init
    (at roth man-hut-ton)
    (at raquel man-hut-ton)
    (friends roth raquel)
    (intends roth (in-love roth raquel))
    (intends roth (peace man-hut-ton))
    (intends raquel (in-love raquel roth))
    (intends raquel (peace man-hut-ton))
  )
  (:goal
    (and (in-love roth raquel)
    (peace man-hut-ton))
  )
)