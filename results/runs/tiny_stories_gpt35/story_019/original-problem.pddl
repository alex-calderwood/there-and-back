(define (problem tim-draws-problem)
  (:domain tim-draws)
  (:objects
    tim box colors paper print cake balloons - object
    bedroom living-room - location)
  (:init
    (at tim bedroom)
    (at box bedroom)
    (has-color box colors)
    (has-paper box paper)
    (intends tim (has-color tim colors))
    (intends tim (has-print paper))
    (at cake living-room)
    (at balloons living-room)
    (intends tim (has-print print))
  )
  (:goal
    (and (has-print tim print)
    (not (has-print cake print))
    (not (has-print balloons print)))
  )
)