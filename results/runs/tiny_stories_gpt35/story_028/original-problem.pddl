(define (problem lily-room-organization)
  (:domain lily-room)
  (:objects
    lily box soap - physical-object
    book1 book2 book3 - book
    bookshelf - object)
  (:init
    (organized bookshelf)
    (at bookshelf lily)
    (organized lily)
    (at lily lily)
    (at box lily)
    (at soap box)
    (intends lily (organized lily))
    (intends lily (smells-good bookshelf))
    (intends lily (has bookshelf book1))
    (intends lily (has bookshelf book2))
    (intends lily (has bookshelf book3)))
  (:goal
    (and (at bookshelf lily)
    (has bookshelf book1)
    (has bookshelf book2)
    (has bookshelf book3)
    (smells-good bookshelf)))
)