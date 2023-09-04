(define (problem odd-one-out)
  (:domain irrational-love)
  (:objects
    term1 term2 term3 term4 - term)
  (:init
    (not (= term1 term2))
    (not (= term1 term3))
    (not (= term1 term4))
    (not (= term2 term3))
    (not (= term2 term4))
    (not (= term3 term4))
    (intends term1 (found term1))
    (intends term2 (found term2))
    (intends term3 (found term3))
    (intends term4 (found term4))
    (intends term1 (differentiated term1))
    (intends term2 (differentiated term2))
    (intends term3 (differentiated term3))
    (intends term4 (differentiated term4))
    (intends term1 (lost term1))
    (intends term2 (lost term2))
    (intends term3 (lost term3))
    (intends term4 (lost term4)))
  (:goal
    (and (lost term1)
    (lost term2)
    (lost term3)
    (found term4)
    (differentiated term4)
    (not (sated term4))))
)