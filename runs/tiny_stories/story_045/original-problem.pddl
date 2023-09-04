(define (problem share-mirror)
  (:domain
    jack-and-jill)
  (:objects
    jack jill grandma - character)
  (:init
    (intends jack (shares jack jill mirror))
    (intends jill (shares jill jack mirror)))
  (:goal
    (and (shares jack jill mirror)
    (shares jill jack mirror)))
)