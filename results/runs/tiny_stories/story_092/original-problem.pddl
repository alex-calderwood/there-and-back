(define (problem dan-university-achievement)
  (:domain
    dan-university)
  (:objects
    dan mom family - character)
  (:init
    (worried dan)
    (hardworking dan)
    (intends dan (accepted-to-university dan))
    (intends dan (dreams-come-true dan))
    (intends mom (applauding mom))
    (intends family (applauding family)))
  (:goal
    (and (dreams-come-true dan)
    (applauding mom)
    (applauding family)))
)