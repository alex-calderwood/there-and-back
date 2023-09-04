(define (problem explore-safari)
  (:domain
    gifted-giraffe)
  (:objects
    stretch - character
    hippos - character
    safari - place
    new-places - place)
  (:init
    (at stretch safari)
    (at hippos safari)
    (intends stretch (explored stretch new-places))
    (intends stretch (interacted stretch hippos))
    (intends stretch (at stretch new-places))
  )
  (:goal
    (and (explored stretch new-places)
    (interacted stretch hippos)))
)