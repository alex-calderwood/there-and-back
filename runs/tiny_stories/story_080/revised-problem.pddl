(define (problem lily-sneezes)
  (:domain
    lily-and-books)
  (:objects
    lily mom teddy-bear - character
    bookshelf - bookshelf
    animal-book flower-book - book)
  (:init
    (has lily animal-book)
    (on-shelf animal-book bookshelf)
    (on-shelf flower-book bookshelf)
    (in-room lily)
    (in-room teddy-bear)
    (in-kitchen mom)
    (intends lily (likes lily animal-book))
    (intends lily (likes lily flower-book))
    (intends mom (likes mom flower-book))
    (intends lily (not (scared lily)))
  )
  (:goal
    (and (has lily flower-book)
    (likes lily flower-book)
    (likes mom flower-book)
    (not (fell-down animal-book))
    (not (scared lily)))
  )
)