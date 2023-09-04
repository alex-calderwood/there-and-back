(define (problem gifted-girl-story)
  (:domain
    gifted-girl)
  (:objects
    girl - character
    forest old-house - place)
  (:init
    (at girl forest)
    (has-skin girl)
    (intends girl (rewarded girl))
    (intends girl (has-skin girl)))
  (:goal
    (and (not (at girl old-house))
    (not (has-skin girl))
    (not (rewarded girl))))
)