(define (problem jarjar-finn-love-story)
  (:domain
    jarjar-finn-love)
  (:objects
    jarjar finn han - character
    jakku naboo - place)
  (:init
    (alive jarjar)
    (at jarjar jakku)
    (intends jarjar (in-love jarjar finn))
    (intends jarjar (accepts-past jarjar finn))
    (intends jarjar (knows-self jarjar))
    (alive finn)
    (at finn jakku)
    (intends finn (in-love finn jarjar))
    (intends finn (accepts-past finn jarjar))
    (alive han)
    (at han jakku))
  (:goal
    (and (in-love jarjar finn)
    (accepts-past jarjar finn)
    (accepts-past finn jarjar)
    (knows-self jarjar)
    (at jarjar naboo)
    (at finn naboo)
    (at han naboo)))
)