(define (problem anna-and-lily)
  (:domain
    anna-and-lily)
  (:objects
    anna - character
    lily - doll
    trick-mirror - mirror
    moms-room - place)
  (:init
    (alive anna)
    (intends anna (hug anna lily))
    (intends anna (not (scared anna)))
    (intends anna (not (broken lily)))
    (trick-mirror trick-mirror)
    (has anna trick-mirror)
    (at anna moms-room)
    (holding anna lily))
  (:goal
    (and (hug anna lily)
    (not (scared anna))
    (not (broken lily))))
)