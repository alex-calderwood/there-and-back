(define (problem support-friend)
  (:domain
    friendship-support)
  (:objects
    narrator friend - character)
  (:init
    (friend narrator friend)
    (needs-help friend)
    (intends narrator (provides-help narrator friend))
    (intends narrator (smiling friend))
    (intends narrator (laughing friend)))
  (:goal
    (and (provides-help narrator friend)
    (smiling friend)
    (laughing friend))
  )
)