(define (problem find-spaghetti)
  (:domain
    hide-and-seek-toys)
  (:objects
    lily mommy - character
    spaghetti - toy
    room bed door toy-box big-chair - place)
  (:init
    (at lily room)
    (intends lily (found spaghetti))
    (at mommy room)
    (intends mommy (found spaghetti))
    (hidden spaghetti big-chair))
  (:goal
    (found spaghetti))
)