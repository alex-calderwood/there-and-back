(define (problem tamara-vacation)
  (:domain
    tamara-vacation)
  (:objects
    tamara - character
    amphitheatre resort - place
    mojito - drink)
  (:init
    (alive tamara)
    (at tamara resort)
    (has tamara mojito)
    (intends tamara (drunk tamara))
    (intends tamara (vomit-stain amphitheatre))
  )
  (:goal
    (and (drunk tamara)
    (vomit-stain amphitheatre))
  )
)