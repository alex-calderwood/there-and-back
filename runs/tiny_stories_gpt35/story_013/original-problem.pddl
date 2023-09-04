(define (problem sue-and-cat-problem)
  (:domain sue-and-cat)
  (:objects
    sue cat - person
    tree box - object
    ball doll - toy)
  (:init
    (at sue tree)
    (at cat tree)
    (lost cat ball)
    (intends sue (found ball))
    (intends sue (has cat ball))
    (found ball)
    (found doll)
    (intends cat (happy cat))
    (intends cat (found ball))
    (intends cat (found doll)))
  (:goal
    (and (at sue box)
    (at cat box)
    (has cat ball)
    (not (lost cat ball))
    (happy cat)
    (play sue ball)
    (play sue doll))
  )
)