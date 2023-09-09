(define (problem secret-flower-sharing)
  (:domain
    secret-flower-place)
  (:objects
    lily tim - character
    home secret-place - place)
  (:init
    (at lily home)
    (at tim home)
    (knows-secret lily)
    (patient lily)
    (intends lily (happy lily))
    (intends lily (happy tim))
    (intends lily (happy (parents lily)))
    (intends lily (happy (parents tim)))
    (intends tim (happy tim))
    (intends tim (happy lily))
    (intends tim (happy (parents tim)))
    (intends tim (happy (parents lily))))
  (:goal
    (and (gave-flowers lily (parents lily))
    (gave-flowers tim (parents tim))
    (happy (parents lily))
    (happy (parents tim))
    (patient lily)
    (kind lily)
    (patient tim)
    (kind tim)))
)