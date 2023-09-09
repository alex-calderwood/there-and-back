(define (problem cat-guardian-problem)
  (:domain
    cat-guardian)
  (:objects
    cat newcomer1 newcomer2 professor - character
    lab - place
    schrodingers-box - box)
  (:init
    (in-box cat schrodingers-box)
    (at schrodingers-box lab)
    (at professor lab)
    (intends professor (opened schrodingers-box))
    (intends cat (opened schrodingers-box))
  )
  (:goal
    (opened schrodingers-box))
)