(define (problem get-mop)
  (:domain
    mop-shopping)
  (:objects
    sue mom - girl
    store - place
    dog - dog
    pink-handle-mop blue-handle-mop - mop)
  (:init
    (at sue store)
    (intends sue (has mom pink-handle-mop))
    (intends mom (has mom blue-handle-mop))
    (at mom store)
    (at dog store)
    (intends dog (found clean-pretty-mop))
    (intends sue (likes pink-handle-mop))
    (intends mom (likes blue-handle-mop)))
  (:goal
    (and (has sue clean-pretty-mop)
    (not (has sue pink-handle-mop))
    (not (has mom blue-handle-mop)))
  )
)