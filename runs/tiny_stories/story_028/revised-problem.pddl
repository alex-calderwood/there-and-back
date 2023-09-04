(define (problem organize-room)
  (:domain
    lily-and-soap)
  (:objects
    lily friend1 friend2 - character
    house - place
    book1 book2 book3 soap - item)
  (:init
    (at lily house)
    (reads lily)
    (intends lily (organized house))
    (intends lily (happy lily))
    (at friend1 house)
    (reads friend1)
    (intends friend1 (happy friend1))
    (at friend2 house)
    (reads friend2)
    (intends friend2 (happy friend2))
    (on-shelf book1)
    (on-shelf book2)
    (on-shelf book3))
  (:goal
    (and (organized house)
    (happy lily)
    (happy friend1)
    (happy friend2)))
)