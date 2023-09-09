(define (problem kevins-situation)
  (:domain
    kevins-intruder)
  (:objects
    kevin stranger - character
    bathroom kitchen bedroom entryway - room
    bottle-opener - item)
  (:init
    (at kevin bathroom)
    (at stranger entryway)
    (has-key stranger)
    (in bottle-opener kitchen)
    (sick kevin)
    (intends kevin (called-911 stranger kevin))
    (intends stranger (has stranger bottle-opener))
  )
  (:goal
    (and (called-911 stranger kevin)
    (not (has stranger bottle-opener))
    (in bottle-opener kitchen))
  )
)