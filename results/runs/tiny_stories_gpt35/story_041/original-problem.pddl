(define (problem billy-and-tommy-problem)
  (:domain billy-and-tommy)
  (:objects
    billy tommy bunny mommy-bunny - character
    park - object)
  (:init
    (at billy park)
    (at tommy park)
    (at bunny park)
    (lost bunny)
    (crying bunny)
    (intends billy (and (not (lost bunny)) (not (crying bunny))))
    (intends tommy (and (not (lost bunny)) (not (crying bunny))))
  )
  (:goal
    (and (not (lost bunny))
    (not (crying bunny))
    (happy mommy-bunny)
    (helped billy bunny)
    (helped tommy bunny)
    (has mommy-bunny bunny))
  )
)