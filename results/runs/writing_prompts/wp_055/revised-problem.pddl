(define (problem clogged-toilet)
  (:domain
    zombie-apocalypse)
  (:objects
    protagonist zombae - character
    house hardware-store - place
    chair - item)
  (:init
    (alive protagonist)
    (at protagonist house)
    (intends protagonist (alive protagonist))
    (intends protagonist (not (clogged house)))
    (clogged house)
    (has protagonist chair)
    (burned chair)
    (zombie zombae)
    (at zombae hardware-store))
  (:goal
    (and (not (alive protagonist))
    (zombie protagonist)
    (at protagonist hardware-store))
  )
)