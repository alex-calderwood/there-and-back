(define (problem billy-and-henry)
  (:domain
    farm-life)
  (:objects
    billy henry - character)
  (:init
    (happy billy)
    (intends billy (friend billy henry))
    (intends billy (happy henry))
    (intends billy (ready henry))
    (sad henry))
  (:goal
    (and (friend billy henry)
    (happy billy)
    (happy henry)
    (ready henry))
  )
)