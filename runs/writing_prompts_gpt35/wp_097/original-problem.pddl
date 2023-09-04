(define (problem human-chop-shop-problem)
  (:domain human-chop-shop)
  (:objects
    me partner owner - person
    warehouse door basement - object
    keys - key)
  (:init
    (at me warehouse)
    (at partner warehouse)
    (at owner warehouse)
    (locked door)
    (unlocked keys door)
    (has me keys)
    (alive me)
    (alive partner)
    (intends me (evidence-found))
    (intends partner (evidence-found))
    (intends owner (not (evidence-found))))
  (:goal
    (and (evidence-found)
    (not (alive owner))))
)