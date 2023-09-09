(define (problem longevity-serum-revolution)
  (:domain
    longevity-serum)
  (:objects
    protagonist - character
    prison - place
    outside - place
  )
  (:init
    (alive protagonist)
    (at protagonist prison)
    (imprisoned protagonist)
    (has-serum protagonist)
    (intends protagonist (not (imprisoned protagonist)))
    (intends protagonist (not (religious protagonist)))
  )
  (:goal
    (and (not (imprisoned protagonist))
    (not (religious protagonist)))
  )
)