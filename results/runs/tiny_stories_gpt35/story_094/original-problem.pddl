(define (problem tom-and-jane-problem)
  (:domain tom-and-jane)
  (:objects
    tom jane dog - character
    gift toy - item
    house - object)
  (:init
    (alive tom)
    (alive jane)
    (alive dog)
    (at tom house)
    (at jane house)
    (at dog house)
    (at gift house)
    (intends tom (alive tom))
    (intends jane (alive jane))
    (intends dog (alive dog))
    (intends dog (has dog toy))
    (intends tom (has tom gift))
    (intends jane (give jane gift tom house))
  )
  (:goal
    (and (not (has tom toy))
    (not (has jane toy))
    (has dog toy)
    (not (alive dog)))
  )
)