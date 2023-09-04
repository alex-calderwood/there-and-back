(define (problem help-and-bell)
  (:domain
    tim-and-the-bell)
  (:objects
    tim mom man - character
    store home backyard - place
    big-bell small-bell oil bike - item)
  (:init
    (at tim home)
    (at mom home)
    (at man store)
    (at big-bell store)
    (at small-bell backyard)
    (at oil store)
    (at bike store)
    (wants tim big-bell)
    (wants tim small-bell)
    (needs oil man)
    (intends tim (happy tim))
    (intends mom (happy tim))
    (intends mom (proud tim))
    (intends man (working bike))
  )
  (:goal
    (and (has tim small-bell)
    (happy tim)
    (proud tim)
    (working bike))
  )
)