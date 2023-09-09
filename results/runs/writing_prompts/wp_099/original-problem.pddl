(define (problem new-world-conversion)
  (:domain
    conquistadors-elder-gods)
  (:objects
    captain-santos flores crewman - character
    ship shore - place)
  (:init
    (alive captain-santos)
    (at captain-santos ship)
    (intends captain-santos (converted crewman))
    (alive flores)
    (at flores ship)
    (intends flores (landed flores))
    (alive crewman)
    (at crewman ship)
    (intends crewman (landed crewman))
    (land-nearby ship))
  (:goal
    (and (landed captain-santos)
    (landed flores)
    (landed crewman)
    (converted crewman))
  )
)