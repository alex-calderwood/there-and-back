(define (problem killer-chase)
  (:domain
    killer-chase)
  (:objects
    james paul - character
    house cellar - place
    rifle handsaw - weapon)
  (:init
    (alive james)
    (at james house)
    (has james rifle)
    (intends james (alive james))
    (intends james (not (alive paul)))
    (alive paul)
    (at paul house)
    (intends paul (alive paul))
    (intends paul (not (alive james)))
    (intends paul (vigilant paul))
  )
  (:goal
    (and (not (alive james))
    (alive paul)))
)