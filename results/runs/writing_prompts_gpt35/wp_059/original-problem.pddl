(define (problem help-a-friend)
  (:domain helping-a-friend)
  (:objects
    me you - person)
  (:init
    (has-friend me you)
    (needing-help you)
    (has-time me)
    (willing-to-help me you))
  (:goal
    (and (smiling you)
    (laughing you))
  )
)