(define (problem dan-university)
  (:domain
    dan-university)
  (:objects
    dan - person)
  (:init
    (worried dan)
    (intends dan (happy dan))
    (intends dan (accepted dan)))
  (:goal
    (and (happy dan)
    (accepted dan))
  )
)