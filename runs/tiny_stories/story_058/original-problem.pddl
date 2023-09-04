(define (problem razor-balancing-story)
  (:domain
    razor-balancing)
  (:objects
    powerful-man ant - character
    park - object)
  (:init
    (can-balance powerful-man)
    (can-balance ant)
    (intends powerful-man (balanced powerful-man))
    (intends ant (balanced ant))
  )
  (:goal
    (and (amazed powerful-man)
    (balanced ant)
    (at powerful-man park)
    (at ant park))
  )
)