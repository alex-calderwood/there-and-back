(define (domain spot-and-fluffy)
  (:requirements :strips :typing :equality)
  (:types object - object toy - object)
  (:predicates
    (stacked ?object - object)
    (on ?object - object ?support - object)
    (toy ?object - object)
  )

  ;; Spot stacks a toy on top of another toy.
  (:action stack
    :parameters
      (?top - toy ?bottom - toy)
    :precondition
      (and (toy ?top)
      (toy ?bottom)
      (not (= ?top ?bottom))
      (or (not (stacked ?bottom))
      (on ?bottom ?support))
      (not (on ?top ?bottom)))
    :effect
      (and (stacked ?top)
      (on ?top ?bottom)
      (not (on ?top ?support)))
  )

  ;; Spot removes a toy from the top of a stack.
  (:action unstack
    :parameters
      (?top - toy ?bottom - toy)
    :precondition
      (and (stacked ?top)
      (on ?top ?bottom))
    :effect
      (and (not (stacked ?top))
      (not (on ?top ?bottom))
      (on ?top ?support))
  )
)