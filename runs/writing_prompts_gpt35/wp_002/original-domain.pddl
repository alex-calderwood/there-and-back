(define (domain irrational-love)
  (:requirements :strips :typing :equality)
  (:types term - object)
  (:predicates
    (connected ?term - term)
    (found ?term - term)
    (expressed-love ?term - term)
    (lost ?term - term)
    (differentiated ?term - term)
    (sated ?term - term)
  )

  ;; A term is connected to another term.
  (:action connect
    :parameters
      (?term1 - term ?term2 - term)
    :precondition
      (and (not (= ?term1 ?term2))
      (not (connected ?term1 ?term2)))
    :effect
      (connected ?term1 ?term2)
  )

  ;; A term finds another term.
  (:action find
    :parameters
      (?term1 - term ?term2 - term)
    :precondition
      (and (not (= ?term1 ?term2))
      (connected ?term1 ?term2)
      (not (found ?term1))
      (not (found ?term2)))
    :effect
      (and (found ?term1)
      (found ?term2))
  )

  ;; A term expresses love for another term.
  (:action express-love
    :parameters
      (?term1 - term ?term2 - term)
    :precondition
      (and (not (= ?term1 ?term2))
      (found ?term1)
      (found ?term2)
      (connected ?term1 ?term2)
      (not (expressed-love ?term1))
      (not (expressed-love ?term2)))
    :effect
      (and (expressed-love ?term1)
      (expressed-love ?term2))
  )

  ;; A term is lost.
  (:action lose
    :parameters
      (?term - term)
    :precondition
      (and (found ?term)
      (not (lost ?term)))
    :effect
      (lost ?term)
  )

  ;; A term differentiates.
  (:action differentiate
    :parameters
      (?term - term)
    :precondition
      (and (found ?term)
      (not (differentiated ?term)))
    :effect
      (differentiated ?term)
  )

  ;; A term is sated.
  (:action sate
    :parameters
      (?term - term)
    :precondition
      (and (found ?term)
      (expressed-love ?term)
      (not (sated ?term)))
    :effect
      (sated ?term)
  )
)