(define (problem gifted-girl-problem)
  (:domain gifted-girl)
  (:objects
    girl - character)
  (:init
    (has-skin girl)
    (intends girl (has-skin girl))
    (intends girl (visited girl))
    (intends voice (rewarded girl))
    (intends voice (take-skin girl)))
  (:goal
    (and (not (visited girl))
    (not (upset girl))
    (rewarded girl)))
)