(define (problem mcdonalds-on-mars-problem)
  (:domain mcdonalds-on-mars)
  (:objects
    steve red-haired-man - character
    twelve-piece-chicken-nuggets - object)
  (:init
    (alive steve)
    (at steve earth)
    (intends steve (communicated steve (equal ?expression1 ?expression2)))
    (intends red-haired-man (has red-haired-man twelve-piece-chicken-nuggets))
    (at red-haired-man mars)
    (intends red-haired-man (alive red-haired-man))
    (intends red-haired-man (communicated red-haired-man (equal ?expression1 ?expression2))))
  (:goal
    (and (at red-haired-man mars)
    (has red-haired-man twelve-piece-chicken-nuggets)))
)