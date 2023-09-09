(define (problem remy-escapes-wolf)
  (:domain
    remy-and-friends)
  (:objects
    remy friends wolf - character
    forest hole - place)
  (:init
    (at remy forest)
    (at friends forest)
    (at wolf forest)
    (has-long-tail remy)
    (hungry wolf)
    (intends remy (safe remy))
    (intends remy (safe friends))
    (intends friends (safe friends))
    (intends wolf (chasing wolf remy))
    (intends wolf (chasing wolf friends)))
  (:goal
    (and (safe remy)
    (safe friends)
    (not (chasing wolf remy))
    (not (chasing wolf friends))))
)