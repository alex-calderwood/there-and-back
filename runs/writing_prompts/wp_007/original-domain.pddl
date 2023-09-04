(define (domain bachelor-pad)
  (:requirements :adl :domain-axioms :intentionality)
  (:types room item - object)
  (:predicates
    (in ?item - item ?room - room)
    (occupied ?item - item)
    (plugged-in ?item - item)
    (connected ?item - item)
    (well-lit ?room - room)
    (morning)
  )

  ;; An item is moved from one room to another.
  (:action move-item
    :parameters
      (?item - item ?from - room ?to - room)
    :precondition
      (and (not (= ?from ?to))
      (in ?item ?from))
    :effect
      (and (not (in ?item ?from))
      (in ?item ?to))
  )

  ;; An item is plugged in.
  (:action plug-in
    :parameters
      (?item - item)
    :precondition
      (not (plugged-in ?item))
    :effect
      (plugged-in ?item)
  )

  ;; An item is connected to another item.
  (:action connect
    :parameters
      (?item1 - item ?item2 - item)
    :precondition
      (and (not (connected ?item1 ?item2))
      (not (= ?item1 ?item2)))
    :effect
      (connected ?item1 ?item2)
  )

  ;; The room becomes well-lit in the morning.
  (:action morning-comes
    :parameters
      (?room - room)
    :precondition
      (and (not (well-lit ?room))
      (morning))
    :effect
      (well-lit ?room)
  )

  ;; The room becomes dark when it's not morning.
  (:action night-falls
    :parameters
      (?room - room)
    :precondition
      (and (well-lit ?room)
      (not (morning)))
    :effect
      (not (well-lit ?room))
  )

  ;; An item is occupied.
  (:action occupy
    :parameters
      (?item - item)
    :precondition
      (not (occupied ?item))
    :effect
      (occupied ?item)
  )

  ;; An item is unoccupied.
  (:action unoccupy
    :parameters
      (?item - item)
    :precondition
      (occupied ?item)
    :effect
      (not (occupied ?item))
  )
)