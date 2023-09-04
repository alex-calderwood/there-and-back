(define (problem painting-in-park)
  (:domain
    painting-friends)
  (:objects
    lucy tom mom - character
    room park - place
    bag paints brushes - item)
  (:init
    (at lucy room)
    (at mom room)
    (at tom park)
    (intends lucy (happy lucy))
    (intends lucy (painting lucy))
    (intends lucy (likes tom bag))
    (intends tom (happy tom))
    (intends tom (painting tom))
    (intends mom (happy mom))
    (has lucy bag)
    (has lucy paints)
    (has lucy brushes)
    (has tom paints)
    (has tom brushes))
  (:goal
    (and (at lucy park)
    (at mom park)
    (at tom park)
    (painting lucy)
    (painting tom)
    (happy lucy)
    (happy tom)
    (likes tom bag))
  )
)