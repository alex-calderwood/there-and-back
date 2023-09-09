(define (problem balancing-act-problem)
  (:domain balancing-act)
  (:objects
    powerful-man park razor - object
    tiny-ant - ant)
  (:init
    (at powerful-man park)
    (at razor park)
    (intends powerful-man (on-razor powerful-man razor))
    (intends tiny-ant (on-razor tiny-ant razor)))
  (:goal
    (and (on-razor powerful-man razor)
    (on-razor tiny-ant razor))
  )
)