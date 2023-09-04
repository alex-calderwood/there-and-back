(define (problem tv-sharing-problem)
  (:domain
    tv-sharing)
  (:objects
    tim sue mom - character)
  (:init
    (wants-to-watch-tv tim)
    (wants-to-watch-tv sue)
    (intends mom (nice tim))
    (intends mom (happy tim))
    (intends mom (happy sue))
    (intends tim (watches-tv tim))
    (intends sue (watches-tv sue)))
  (:goal
    (and (happy tim)
    (happy sue)
    (watches-tv tim)
    (watches-tv sue)
    (nice tim)))
)