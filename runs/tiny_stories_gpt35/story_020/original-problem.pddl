(define (problem stretch-explores)
  (:domain safari-exploration)
  (:objects
    stretch - animal
    grass hippos - object)
  (:init
    (at stretch grass)
    (at hippos grass)
    (intends stretch (explored grass))
  )
  (:goal
    (explored grass)
  )
)