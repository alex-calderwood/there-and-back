(define (problem star-crossed-lovers)
  (:domain
    star-wars-love-story)
  (:objects
    jarjar finn han - character)
  (:init
    (alive jarjar)
    (alive finn)
    (alive han)
    (intends jarjar (in-love jarjar finn))
    (intends finn (in-love finn jarjar))
    (intends han (not (in-love jarjar finn)))
    (intends han (not (in-love finn jarjar))))
  (:goal
    (and (not (in-love jarjar finn))
    (not (in-love finn jarjar)))
  )
)