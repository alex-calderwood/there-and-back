(define (problem explore)
  (:domain space)
  (:objects ;; People
            zoe - creature
            lizard - creature
            ;; Places
            ship - ship
            surface - landform)
  (:init (habitable ship)
         (safe ship)
         (habitable surface)
         (safe surface)
         (alive zoe)
         (safe zoe)
         (at zoe ship)
         (captain zoe ship)
         (alive lizard)
         (safe lizard)
         (at lizard surface)
         (guardian lizard surface)
         (intends zoe (friends zoe lizard))
         (intends zoe (not (fighting zoe lizard)))
         (intends zoe (safe zoe))
         (intends zoe (alive zoe))
         (intends lizard (safe lizard))
         (intends lizard (alive lizard)))
  (:goal (and
       (not (habitable surface))
       (friends zoe lizard)
       (not (alive lizard))
       (alive zoe)
       (stunned lizard)
       )))