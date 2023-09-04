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

<|Solution|>

(define (plan dan-university-achievement-solution)
  (:problem dan-university-achievement)
  (:steps (get-accepted dan)
          (start-applauding family dan)
          (start-applauding mom dan)
          (make-dreams-come-true dan)))