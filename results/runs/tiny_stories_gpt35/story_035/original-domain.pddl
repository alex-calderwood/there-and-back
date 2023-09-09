(define (domain tim-birthday)
  (:requirements :strips :typing :equality)
  (:types human - object)
  (:predicates
    (has-surprise)
    (opened-box)
    (spoiled-cake)
    (alive ?human - human)
  )

  ;; A human opens a box.
  (:action open-box
    :parameters
      (?human - human)
    :precondition
      (and (alive ?human)
      (not (opened-box)))
    :effect
      (opened-box)
    :agents
      (?human)
  )

  ;; A human has a surprise.
  (:action have-surprise
    :parameters
      (?human - human)
    :precondition
      (and (alive ?human)
      (opened-box))
    :effect
      (has-surprise)
    :agents
      (?human)
  )

  ;; A human spoils a cake.
  (:action spoil-cake
    :parameters
      (?human - human)
    :precondition
      (and (alive ?human)
      (has-surprise))
    :effect
      (spoiled-cake)
    :agents
      (?human)
  )
)