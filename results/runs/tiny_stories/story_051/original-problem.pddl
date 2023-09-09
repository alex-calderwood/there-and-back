(define (problem tree-adventure)
  (:domain
    magical-tree)
  (:objects
    mia max - character
    tree - object
    park magical-world - place
    squirrel rabbit - animal)
  (:init
    (at mia park)
    (at max park)
    (at tree park)
    (at squirrel magical-world)
    (at rabbit magical-world)
    (intends mia (hugged mia tree))
    (intends max (hugged max tree))
    (intends mia (friendly squirrel))
    (intends mia (friendly rabbit))
    (intends max (friendly squirrel))
    (intends max (friendly rabbit))
  )
  (:goal
    (and (hugged mia tree)
    (hugged max tree)
    (friendly squirrel)
    (friendly rabbit))
  )
)