(define (problem emma-birthday)
  (:domain
    emma-birthday-party)
  (:objects
    emma mom dad - person
    balloons cake candles - object)
  (:init
    (at emma home)
    (at mom home)
    (at dad home)
    (at balloons home)
    (at cake home)
    (at candles home)
    (intends emma (happy emma))
    (intends mom (give mom toy emma))
    (intends dad (make-happy dad))
  )
  (:goal
    (and (has emma toy)
    (happy emma)
    (happy mom)
    (happy dad))
  )
)