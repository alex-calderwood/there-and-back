(define (problem flower-picking)
  (:domain flower-picking)
  (:objects
    lily tim - character
    secret-flower-place - object
    pretty-flower1 pretty-flower2 pretty-flower3 - flower)
  (:init
    (at lily secret-flower-place)
    (at tim secret-flower-place)
    (intends lily (shared-secret lily tim))
    (intends tim (shared-secret tim lily))
    (intends lily (has lily pretty-flower1))
    (intends lily (has lily pretty-flower2))
    (intends lily (has lily pretty-flower3))
    (intends tim (has tim pretty-flower1))
    (intends tim (has tim pretty-flower2))
    (intends tim (has tim pretty-flower3)))
  (:goal
    (and (has lily pretty-flower1)
    (has lily pretty-flower2)
    (has lily pretty-flower3)
    (has tim pretty-flower1)
    (has tim pretty-flower2)
    (has tim pretty-flower3)
    (shared-secret lily tim)
    (shared-secret tim lily)))
)