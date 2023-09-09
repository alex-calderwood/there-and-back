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
    (intends girl (nice girl))
    (intends girl (together thief girl))
    (intends thief (together thief girl)))
  (:goal
    (and (sailor thief)
    (nice thief)
    (together thief girl)))
)