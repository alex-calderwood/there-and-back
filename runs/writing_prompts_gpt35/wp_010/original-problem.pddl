(define (problem stay-in-afterlife)
  (:domain afterlife)
  (:objects
    me - person)
  (:init
    (alive me)
    (intends me (die me))
    (intends me (become-part-of-universe me universe))
    (intends me (enjoy-life me))
    (intends me (be-happy me))
    (intends me (die me)))
  (:goal
    (and (in-afterlife me)
    (part-of-universe me universe)
    (enjoying-life me)
    (happy me)
    (not (resurrected me))))
)