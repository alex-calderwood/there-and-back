(define (problem vase-party-problem)
  (:domain vase-party)
  (:objects
    vase-1 - vase
    flower-1 flower-2 - flower
    cake table - object
    mom family - physical-object)
  (:init
    (not (has-flowers vase-1))
    (not (has-cake))
    (not (on-table cake))
    (not (at-party mom))
    (not (at-party family))
    (intends mom (put-flowers-in-vase vase-1 flower-1))
    (intends mom (put-flowers-in-vase vase-1 flower-2))
    (intends mom (put-on-table cake))
    (intends mom (go-to-party mom))
    (intends family (go-to-party family))
  )
  (:goal
    (and (has-flowers vase-1)
    (has-cake)
    (on-table cake)
    (at-party mom)
    (at-party family)
    (happy mom)
    (happy family)))
)