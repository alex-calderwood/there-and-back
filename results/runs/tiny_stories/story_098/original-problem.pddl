(define (problem sail-big-boat)
  (:domain
    big-boat-sailing)
  (:objects
    thief girl - character)
  (:init
    (not (sailor thief))
    (not (nice thief))
    (sailor girl)
    (nice girl)
    (intends thief (sailor thief))
    (intends thief (nice thief))
    (intends girl (sailor girl))
    (intends girl (nice girl)))
  (:goal
    (and (sailor thief)
    (nice thief)
    (together thief girl)))
)