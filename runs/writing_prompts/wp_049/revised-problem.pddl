(define (problem dog-guardians-story)
  (:domain
    dog-guardians)
  (:objects
    ori boo master - character)
  (:init
    (guardian ori)
    (guardian boo)
    (master master)
    (ancient-oath ori)
    (ancient-oath boo)
    (not (in-herenow master))
    (intends ori (in-herenow master))
    (intends boo (in-herenow master))
  )
  (:goal
    (and (in-herenow master)
    (time-of-passing))
  )
)