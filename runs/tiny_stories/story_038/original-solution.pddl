(define (plan hide-and-seek-fun-solution)
  (:problem hide-and-seek-fun)
  (:steps (start-hiding spot park)
          (start-seeking lily park)
          (find lily spot park)))