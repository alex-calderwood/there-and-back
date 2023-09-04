(define (problem magic-party-problem)
  (:domain
    magic-party)
  (:objects
    kitty doggy magician - character)
  (:init
    (intends kitty (at-party kitty))
    (intends kitty (fast kitty))
    (intends doggy (at-party doggy))
    (intends doggy (fast doggy))
    (intends magician (at-party magician))
    (intends magician (cake-transformed))
  )
  (:goal
    (and (at-party kitty)
    (at-party doggy)
    (at-party magician)
    (fast kitty)
    (fast doggy)
    (cake-transformed))
  )
)