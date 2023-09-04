(define (problem tim-finds-secret-room)
  (:domain
    tim-and-secret-room)
  (:objects
    tim - character
    home park tree - place
    big-red-hat small-box shiny-key - item)
  (:init
    (has tim big-red-hat)
    (has tim spade)
    (at tim home)
    (intends tim (at tim park))
    (intends tim (digging tim))
    (intends tim (found tim small-box))
    (intends tim (opened tim small-box))
    (intends tim (found tim shiny-key))
    (intends tim (opened tim tree))
    (intends tim (playing tim)))
  (:goal
    (playing tim)
  )
)