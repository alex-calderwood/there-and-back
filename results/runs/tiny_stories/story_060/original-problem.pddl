(define (problem vase-joins-party)
  (:domain
    vase-party)
  (:objects
    family mom - character
    house - object)
  (:init
    (happy family)
    (happy mom)
    (at vase house)
    (has family vase)
    (intends family (happy family))
    (intends mom (cake house))
    (intends mom (party house))
  )
  (:goal
    (and (at vase house)
    (cake house)
    (party house)
    (happy family))
  )
)