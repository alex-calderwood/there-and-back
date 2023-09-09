(define (problem volcano-lesson)
  (:domain
    volcano-adventure)
  (:objects
    friend1 friend2 old-man - character
    home volcano - place)
  (:init
    (at friend1 home)
    (at friend2 home)
    (at old-man volcano)
    (intends friend1 (learned-lesson friend1))
    (intends friend2 (learned-lesson friend2))
  )
  (:goal
    (and (learned-lesson friend1)
    (learned-lesson friend2))
  )
)