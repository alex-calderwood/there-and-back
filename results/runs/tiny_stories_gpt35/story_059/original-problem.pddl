(define (problem kitty-and-buddy-puzzle)
  (:domain kitty-and-buddy-puzzle)
  (:objects
    kitty buddy - animal
    puzzle-piece-1 puzzle-piece-2 puzzle-piece-3 - object
    location-1 location-2 location-3 - object)
  (:init
    (alive kitty)
    (alive buddy)
    (at kitty location-1)
    (at buddy location-1)
    (at puzzle-piece-1 location-1)
    (at puzzle-piece-2 location-2)
    (at puzzle-piece-3 location-3)
    (intends kitty (alive kitty))
    (intends buddy (alive buddy)))
  (:goal
    (and (put-together-puzzle)
    (friends kitty buddy)))
)