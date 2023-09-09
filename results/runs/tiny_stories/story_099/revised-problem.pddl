(define (problem lily-zoo-visit)
  (:domain
    zoo-visit)
  (:objects
    lily mom - character
    zoo - place
    fish otter - animal)
  (:init
    (at lily zoo)
    (at mom zoo)
    (likes lily fish)
    (likes lily otter)
    (sees lily fish)
    (sees lily otter)
    (knows-about mom fish)
    (knows-about mom otter)
    (is-fish fish)
    (is-otter otter)
    (intends lily (sees lily fish))
    (intends lily (sees lily otter))
    (intends lily (knows-about lily fish))
    (intends lily (knows-about lily otter))
    (intends lily (not (can-touch lily otter)))
  )
  (:goal
    (and (knows-about lily fish)
    (knows-about lily otter)
    (not (can-touch lily otter)))
  )
)