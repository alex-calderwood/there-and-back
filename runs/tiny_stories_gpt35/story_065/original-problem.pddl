(define (problem mama-and-baby-park)
  (:domain mama-and-baby)
  (:objects
    mama baby - character
    park fence - object)
  (:init
    (at mama park)
    (at baby park)
    (at fence park)
    (intends mama (not (touched-fence)))
    (intends baby (not (touched-fence))))
  (:goal
    (and (hugged mama baby)
    (not (touched-fence))))
)