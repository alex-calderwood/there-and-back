(define (plan relaxation-journey-problem-solution)
  (:problem relaxation-journey-problem)
  (:steps (try-relax protagonist)
          (travel protagonist home field)))