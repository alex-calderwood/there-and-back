(define (problem matrix-glitch)
  (:domain
    glitch-in-matrix)
  (:objects
    jennah mila man - character
    prague - place)
  (:init
    (at jennah prague)
    (at mila prague)
    (at man prague)
    (clothed jennah)
    (clothed mila)
    (clothed man)
    (alive jennah)
    (alive mila)
    (alive man)
    (stuck man)
    (falling jennah)
    (falling mila)
    (falling man))
  (:goal
    (and (aware-glitch jennah)
    (aware-glitch mila)
    (not (stuck man))))
  (:intentionality
    (intends jennah (aware-glitch jennah))
    (intends mila (aware-glitch mila))
    (intends jennah (not (stuck man))))
)