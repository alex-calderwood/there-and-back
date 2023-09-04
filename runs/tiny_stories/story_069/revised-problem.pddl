(define (problem toy-box-adventure)
  (:domain
    toy-box)
  (:objects
    tim stranger mom - character
    toy-car - item)
  (:init
    (alive tim)
    (has tim toy-car)
    (intends tim (with-mom tim mom))
    (alive stranger)
    (intends stranger (opened-box stranger))
    (intends stranger (forall (?t - toy) (fighting ?t)))
    (alive mom))
  (:goal
    (and (with-mom tim mom)
    (forall (?t - toy) (not (fighting ?t)))))
)