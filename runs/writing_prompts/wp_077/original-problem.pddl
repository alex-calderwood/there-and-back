(define (problem poem-existence)
  (:domain
    poem-life)
  (:objects
    reader1 - reader
    poem1 - poem)
  (:init
    (alive poem1)
    (intends reader1 (read reader1 poem1))
    (intends reader1 (echo reader1 poem1)))
  (:goal
    (and (read reader1 poem1)
    (echo reader1 poem1)
    (dead poem1))
  )
)