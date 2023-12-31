(define (problem tim-and-the-secret-room)
  (:domain tim-and-the-secret-room)
  (:objects
    tim spade hat box key door room - object)
  (:init
    (at tim park)
    (wears-hat tim)
    (has-spade tim)
    (intends tim (digs tim park))
    (intends tim (have-key tim))
    (intends tim (open-door tim door))
    (intends tim (enter-room tim room))
    (intends tim (be-happy tim))
    (at spade park)
    (at hat park)
    (at door tree)
    (opens door)
    (at room tree)
  )
  (:goal
    (happy tim)
  )
)