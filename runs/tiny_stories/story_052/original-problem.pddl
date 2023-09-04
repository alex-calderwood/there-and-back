(define (problem kitty-food)
  (:domain
    kitty-and-dog)
  (:objects
    kitty dog - character
    garden - place)
  (:init
    (hungry kitty)
    (at kitty garden)
    (intends kitty (fed kitty))
    (intends kitty (not (scared kitty)))
    (has-food garden)
    (deaf dog)
    (at dog garden)
    (intends dog (scared kitty)))
  (:goal
    (and (fed kitty)
    (not (scared kitty))))
)