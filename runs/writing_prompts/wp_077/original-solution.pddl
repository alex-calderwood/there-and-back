(define (plan poem-existence-solution)
  (:problem poem-existence)
  (:steps (read-poem reader1 poem1)
          (poem-dies poem1)))