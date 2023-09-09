(define (problem share-toys)
  (:domain
    cat-and-dog)
  (:objects
    tom max - character
    ball - toy)
  (:init
    (has tom ball)
    (friends tom max)
    (intends tom (shares tom))
    (intends max (playing-together tom max))
  )
  (:goal
    (and (shares tom)
    (playing-together tom max))
  )
)