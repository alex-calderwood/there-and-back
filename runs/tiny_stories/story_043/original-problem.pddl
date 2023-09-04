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
    (hungry wolf))
  (:goal
    (and (safe remy)
    (safe friends)
    (not (chasing wolf remy))
    (not (chasing wolf friends))))
)