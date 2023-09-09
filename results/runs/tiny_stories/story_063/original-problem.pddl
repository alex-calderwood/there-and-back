(define (problem eat-apple)
  (:domain
    ant-and-bird)
  (:objects
    ant bird - character
    apple - object)
  (:init
    (hard apple)
    (intends ant (eaten apple))
    (intends bird (eaten apple)))
  (:goal
    (eaten apple))
)