(define (problem lily-and-the-fairy)
  (:domain lily-and-the-fairy)
  (:objects
    lily fairy dog - character
    hat flower - item
    park - place)
  (:init
    (at lily park)
    (has lily hat)
    (at dog park)
    (stuck fairy hat)
    (at fairy park)
    (intends lily (friend fairy lily))
    (intends fairy (friend lily fairy))
    (intends lily (not (stuck fairy hat)))
    (intends lily (has lily flower))
    (intends fairy (not (stuck fairy hat))))
  (:goal
    (and (friend lily fairy)
    (not (stuck fairy hat))
    (has lily flower)))
)