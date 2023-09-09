(define (problem tim-and-his-wagon-problem)
  (:domain tim-and-his-wagon)
  (:objects
    tim wagon tree wind tears - object)
  (:init
    (at tim home)
    (at wagon tim)
    (has tim wagon)
    (at tree park)
    (at wind park)
    (at tears home))
  (:goal
    (lost wagon))
)