(define (problem ruined-carnival-day)
  (:domain carnival-day)
  (:objects
    lily mom machine - object)
  (:init
    (at lily home)
    (at mom home)
    (at machine carnival)
    (modest lily)
    (intends mom (modest mom))
    (intends lily (playing lily))
    (intends mom (not (upset lily))))
  (:goal
    (upset lily)
  )
)