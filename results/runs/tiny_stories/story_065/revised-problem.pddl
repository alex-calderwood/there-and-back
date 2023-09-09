(define (problem park-exploration)
  (:domain
    park-adventure)
  (:objects
    mama baby - character
    park fence - object)
  (:init
    (at mama park)
    (at baby park)
    (intends mama (not (hurt baby)))
    (intends mama (not (scared baby)))
    (intends baby (not (hurt baby)))
    (intends baby (not (scared baby))))
  (:goal
    (and (at mama park)
    (at baby park)
    (not (hurt baby))
    (not (scared baby))
    (hugging mama baby)))
)