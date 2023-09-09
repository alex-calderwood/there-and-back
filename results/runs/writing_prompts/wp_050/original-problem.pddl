(define (problem princess-execution)
  (:domain
    rebellion)
  (:objects
    princess knight queen prince bride - character
    rebels nobility army kings-knights - group
    capital city-gates castle throne-room gallows - place)
  (:init
    (alive princess)
    (at princess castle)
    (loyal-to princess army)
    (alive knight)
    (at knight castle)
    (loyal-to knight kings-knights)
    (not (alive queen))
    (executed queen)
    (not (alive prince))
    (executed prince)
    (not (alive bride))
    (executed bride)
    (supports nobility rebels)
    (supports army rebels)
    (supports kings-knights rebels)
    (gates-open city-gates)
    (at gallows capital)
  )
  (:goal
    (and (not (alive princess))
    (executed princess)
    (not (alive knight))
    (executed knight))
  )
)