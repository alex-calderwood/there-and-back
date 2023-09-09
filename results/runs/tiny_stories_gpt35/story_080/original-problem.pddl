(define (problem lily-books)
  (:domain lily-books)
  (:objects
    book1 book2 book3 - book
    teddy - teddybear)
  (:init
    (on-shelf book1)
    (on-shelf book2)
    (on-shelf book3)
    (held teddy))
  (:goal
    (and (on-shelf book1)
    (on-shelf book2)
    (on-shelf book3)))