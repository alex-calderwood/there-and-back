(define (problem max-and-whiskers-problem)
  (:domain max-and-whiskers)
  (:objects
    max whiskers - animal
    town bone treat - object)
  (:init
    (at max town)
    (at whiskers town)
    (foolish whiskers)
    (intends max (at max town))
    (intends whiskers (at whiskers town))
  )
  (:goal
    (and (not (tricked max))
    (not (looking-for-bone))
    (has-treat whiskers))
  )
)