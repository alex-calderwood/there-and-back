(define (plan foggy-friends-solution)
  (:problem foggy-friends)
  (:steps (search max ball home)
          (become-friends max ben)
          (become-happy max)
          (move ben park home)
          (become-happy ben)))