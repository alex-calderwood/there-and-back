(define (problem emotional-manipulation-problem)
  (:domain emotional-manipulation)
  (:objects
    protagonist bill mcInleys - character)
  (:init
    (alive protagonist)
    (alive bill)
    (close-to protagonist bill)
    (not (close-to protagonist mcInleys))
    (not (close-to bill mcInleys))
    (intends protagonist (hates bill))
    (intends protagonist (kill bill))
    (intends protagonist (express-hate protagonist bill))
    (intends protagonist (manipulate bill))
    (intends protagonist (drown mcInleys-cat))
    (intends protagonist (put-in-freezer bill))
    (intends protagonist (express-love protagonist mcInleys)))
  (:goal
    (and (not (alive bill))
    (