(define (plan cat-dog-toy-solution)
  (:problem cat-dog-toy)
  (:steps (take-toy tom jane toy)
          (non-executed (play tom toy))
          (take-toy dog tom toy)))