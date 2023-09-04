(define (problem anna-and-lily-problem)
  (:domain anna-and-lily)
  (:objects
    anna lily - doll)
  (:init
    (doll anna)
    (doll lily)
    (at anna anna)
    (at lily anna)
    (loves lily anna)
    (intends anna (not (scared lily)))
    (intends anna (loves lily anna)))
  (:goal
    (and (at lily anna)
    (loves lily anna)
    (not (broken lily))))
)