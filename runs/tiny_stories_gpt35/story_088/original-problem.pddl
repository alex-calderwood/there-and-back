(define (problem curious-boy-egg)
  (:domain curious-boy-egg)
  (:objects
    boy egg park - object)
  (:init
    (at boy park)
    (intends boy (explored park))
    (intends boy (become-curious boy))
    (intends boy (find boy egg))
    (intends boy (pick-up boy egg))
    (intends boy (wonder boy egg))
    (intends boy (become-happy boy egg))
  )
  (:goal
    (and (happy boy)
    (wondered boy)
    (held egg))
  )
)