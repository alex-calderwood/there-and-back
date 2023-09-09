(define (problem emotional-support-matt)
  (:domain
    emotional-support)
  (:objects
    matt - character)
  (:init
    (hurting matt)
    (struggling matt)
    (loved matt her)
    (not (ready her))
    (intends matt (not (struggling matt)))
    (intends matt (letting-go matt her))
    (intends matt (better-times matt)))
  (:goal
    (and (not (struggling matt))
    (letting-go matt her)
    (better-times matt))
  )
)