(define (problem toy-box-problem)
  (:domain toy-box)
  (:objects
    tim stranger - character
    car box toy1 toy2 - toy
    home - object)
  (:init
    (alive tim)
    (at tim home)
    (intends tim (alive tim))
    (intends tim (has tim car))
    (alive stranger)
    (at stranger home)
    (intends stranger (alive stranger))
    (intends stranger (has stranger box))
    (at car home)
    (at box home)
    (intends toy1 (alive toy1))
    (intends toy2 (alive toy2)))
  (:goal
    (and (not (intends tim (has stranger box)))
    (intends tim (alive tim))))
)