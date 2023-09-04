(define (problem dog-and-cat-problem)
  (:domain dog-and-cat)
  (:objects
    dog cat wrap puddle - object)
  (:init
    (at dog puddle)
    (at cat puddle)
    (at wrap cat)
    (intends dog (not (has-wrap cat)))
    (intends cat (has-wrap cat))
    (intends dog (not (clean wrap)))
    (intends cat (not (clean wrap)))
    (intends dog (not (at wrap cat))))
  (:goal
    (and (clean wrap)
    (at dog puddle)
    (at cat puddle)
    (at wrap cat)
    (has-wrap cat)
    (not (intends dog (has-wrap cat))))
  )
)