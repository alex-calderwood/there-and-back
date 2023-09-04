(define (problem break-in)
  (:domain break-in)
  (:objects
    kevin stranger - character
    bathroom bedroom kitchen - object
    bottle-opener - object)
  (:init
    (alive kevin)
    (at kevin bathroom)
    (intends kevin (alive kevin))
    (intends kevin (has kevin bottle-opener))
    (alive stranger)
    (at stranger kitchen)
    (intends stranger (alive stranger))
    (intends stranger (not (has stranger bottle-opener))))
  (:goal
    (and (at bottle-opener bathroom)
    (not (alive stranger))))
)