(define (problem kingdom-feast-problem)
  (:domain kingdom-feast)
  (:objects
    popop boy lady-wendy - character
    harvest-baskets - item
    kingdom-castle - place
    princess - noble)
  (:init
    (alive popop)
    (at popop kingdom-castle)
    (alive boy)
    (at boy kingdom-castle)
    (intends boy (has boy harvest-baskets))
    (alive lady-wendy)
    (intends lady-wendy (married lady-wendy))
    (in-love boy lady-wendy)
    (alive princess)
    (at princess kingdom-castle)
    (intends princess (alive princess))
    (trap-door kingdom-castle))
  (:goal
    (and (married lady-wendy)
    (not (kidnapped princess))))
)