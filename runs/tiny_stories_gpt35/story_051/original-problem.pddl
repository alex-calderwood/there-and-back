(define (problem magical-tree-visit)
  (:domain magical-tree)
  (:objects
    mia max - character
    rabbit bird - animal)
  (:init
    (inside mia tree)
    (intends mia (visited mia))
    (intends mia (hug rabbit))
    (intends mia (hug bird))
    (inside max tree)
    (intends max (visited max))
    (intends max (hug rabbit))
    (intends max (hug bird))
    (friendly rabbit)
    (friendly bird))
  (:goal
    (and (visited mia)
    (visited max)
    (happy rabbit)
    (happy bird))
  )
)