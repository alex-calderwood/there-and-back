(define (problem support-city)
  (:domain
    city-support)
  (:objects
    mom daughter man - character
    city playground - place
    city-beautification - project)
  (:init
    (alive mom)
    (at mom city)
    (intends mom (happy mom))
    (intends mom (supports mom city-beautification))
    (alive daughter)
    (at daughter city)
    (intends daughter (amazed daughter))
    (intends daughter (supports daughter city-beautification))
    (alive man)
    (at man city)
    (intends man (persistent man))
    (intends man (supports man city-beautification))
    (intends man (completed city-beautification))
  )
  (:goal
    (and (supports mom city-beautification)
    (supports daughter city-beautification)
    (persistent man)
    (completed city-beautification))
  )
)