(define (problem rolling-on-couch-fun)
  (:domain
    rolling-on-couch)
  (:objects
    lily ben mom - character)
  (:init
    (bored lily)
    (intends lily (happy lily))
    (bored ben)
    (intends ben (happy ben))
    (intends mom (happy lily))
    (intends mom (happy ben)))
  (:goal
    (and (happy lily)
    (happy ben)))
)

<|Solution|>

(define (plan rolling-on-couch-fun-solution)
  (:problem rolling-on-couch-fun)
  (:steps (start-rolling ben)
          (stop-rolling ben)
          (lie-down ben)
          (get-up ben)
          (start-rolling lily)
          (stop-rolling lily)
          (lie-down lily)
          (get-up lily)))