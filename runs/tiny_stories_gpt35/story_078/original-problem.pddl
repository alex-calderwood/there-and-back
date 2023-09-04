(define (problem city-support-problem)
  (:domain city-support)
  (:objects
    mom daughter man - person
    playground city - object)
  (:init
    (at mom city)
    (at daughter city)
    (at man playground)
    (supports man project)
    (intends mom (volunteers mom))
    (intends daughter (volunteers daughter))
    (intends man (persistent man))
    (beautiful city)
    (clean playground)
    (litter playground)
  )
  (:goal
    (and (planted city)
    (not (litter playground))
    (supports mom project)
    (supports daughter project)
    (persistent man))
  )
)