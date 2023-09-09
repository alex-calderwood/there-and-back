(define (problem who-is-bill-clinton)
  (:domain bill-clinton)
  (:objects
    bill death - person
    rita - person
    john-james-smith - symbol)
  (:init
    (intends bill (not (is bill)))
    (intends bill (not (is john-james-smith))))
  (:goal
    (and (intends bill (is bill))
    (not (intends death (is bill))))
  )
)