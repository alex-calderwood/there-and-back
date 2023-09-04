(define (problem cat-dog-toy)
  (:domain
    cat-and-dog)
  (:objects
    tom jane dog - character
    toy - item
    house - place)
  (:init
    (at tom house)
    (at jane house)
    (at dog house)
    (happy jane)
    (has jane toy)
    (intends jane (happy tom))
    (intends tom (happy tom))
    (intends dog (has dog toy)))
  (:goal
    (and (sad tom)
    (sad jane)
    (has dog toy))
  )
)