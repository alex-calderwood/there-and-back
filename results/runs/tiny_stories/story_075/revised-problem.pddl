(define (problem girl-new-dress)
  (:domain
    smart-girl-dress)
  (:objects
    girl mum - character
    red-dress pink-dress - dress)
  (:init
    (has girl red-dress)
    (intends girl (happy girl))
    (intends mum (happy girl)))
  (:goal
    (and (happy girl)
    (wearing girl pink-dress)
    (not (wearing girl red-dress))))
)