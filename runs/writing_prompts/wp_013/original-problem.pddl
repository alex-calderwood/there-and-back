(define (problem andrew-transformation)
  (:domain
    andrew-crow-transformation)
  (:objects
    andrew - character)
  (:init
    (human andrew)
    (intends andrew (transformed andrew))
    (sunlight-available))
  (:goal
    (transformed andrew))
)