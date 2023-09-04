(define (problem the-six-story)
  (:domain the-six)
  (:objects
    queen-raquel roth - character)
  (:init
    (alive queen-raquel)
    (alive roth)
    (friends queen-raquel roth)
    (intends queen-raquel (alive queen-raquel))
    (intends roth (alive roth))
    (intends queen-raquel (friends queen-raquel roth))
    (intends roth (friends roth queen-raquel)))
  (:goal
    (and (heart-won roth queen-raquel)
    (friends queen-raquel roth)
    (not (on-break queen-raquel roth)))
  )
)