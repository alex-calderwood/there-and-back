(define (problem dr-vertigo-attack)
  (:domain
    dr-vertigo-minibots)
  (:objects
    dr-vertigo secretary-general - character
    minibots - minibot
    un-building - building
    capture-command damage-command - keyword)
  (:init
    (at dr-vertigo un-building)
    (alive dr-vertigo)
    (has-force-field dr-vertigo)
    (has-control-rod dr-vertigo)
    (intends dr-vertigo (captured secretary-general))
    (intends dr-vertigo (damaged un-building))
    (at secretary-general un-building)
    (alive secretary-general)
    (intends secretary-general (alive secretary-general))
    (intends secretary-general (barricaded secretary-general))
  )
  (:goal
    (and (captured secretary-general)
    (damaged un-building))
  )
)