(define (problem tim-penny-candy)
  (:domain
    tim-penny-candy)
  (:objects
    tim storeman old-lady - character
    store1 store2 - store
    old-penny candy big-candy - item)
  (:init
    (has tim old-penny)
    (at tim store1)
    (at storeman store1)
    (at old-lady store2)
    (accepts store1 candy)
    (accepts store2 big-candy)
    (special old-penny)
    (has storeman candy)
    (has old-lady big-candy)
    (intends tim (succeeded tim))
    (intends tim (happy tim))
    (intends old-lady (happy old-lady))
  )
  (:goal
    (and (succeeded tim)
    (happy tim)
    (happy old-lady))
  )
)