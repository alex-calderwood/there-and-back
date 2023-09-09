(define (problem bookcase-adventure)
  (:domain
    bookcase-adventure)
  (:objects
    tim mom - character)
  (:init
    (intends tim (calm tim))
    (intends mom (calm tim))
    (intends mom (not (books-fall))))
  (:goal
    (and (calm tim)
    (not (books-fall))))
)