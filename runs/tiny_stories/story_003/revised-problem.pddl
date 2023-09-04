(define (problem fix-bike)
  (:domain
    flying-bike)
  (:objects
    amy amys-mom shop-man - character
    bike - object)
  (:init
    (broken-pedal bike)
    (has amy bike)
    (intends amy (fixed-pedal bike))
    (intends amy (happy amy))
    (intends amys-mom (fixed-pedal bike))
    (intends amys-mom (happy amy))
    (intends shop-man (fixed-pedal bike))
  )
  (:goal
    (and (happy amy)
    (flying bike))
  )
)