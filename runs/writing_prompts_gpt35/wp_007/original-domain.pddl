(define (domain bachelor-pad)
  (:requirements :strips :typing)
  (:types object - physical-object place - object)
  (:predicates
    (in ?object - physical-object ?place - place)
    (occupied ?place - place)
    (clean ?object - physical-object)
    (charged ?object - physical-object)
    (connected ?object - physical-object)
    (lit ?place - place)
    (has ?object - physical-object ?property - property)
    (real ?object - physical-object)
  )

  ;; A physical object is moved from one place to another.
  (:action move
    :parameters
      (?object - physical-object ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (in ?object ?from)
      (occupied ?from)
      (clean ?object))
    :effect
      (and (not (in ?object ?from))
      (in ?object ?to))
  )

  ;; A physical object is plugged into a power source.
  (:action plug-in
    :parameters
      (?object - physical-object ?power-source - physical-object)
    :precondition
      (and (not (connected ?object))
      (in ?object ?power-source)
      (occupied ?power-source)
      (clean ?object)
      (clean ?power-source))
    :effect
      (connected ?object)
  )

  ;; A physical object is unplugged from a power source.
  (:action unplug
    :parameters
      (?object - physical-object ?power-source - physical-object)
    :precondition
      (and (connected ?object)
      (in ?object ?power-source)
      (occupied ?power-source)
      (clean ?object)
      (clean ?power-source))
    :effect
      (not (connected ?object))
  )

  ;; A physical object is charged.
  (:action charge
    :parameters
      (?object - physical-object ?power-source - physical-object)
    :precondition
      (and (connected ?object)
      (in ?object ?power-source)
      (occupied ?power-source)
      (clean ?object)
      (clean ?power-source))
    :effect
      (charged ?object)
  )

  ;; A physical object is cleaned.
  (:action clean
    :parameters
      (?object - physical-object)
    :precondition
      (not (clean ?object))
    :effect
      (clean ?object)
  )

  ;; A physical object is placed in a location.
  (:action place
    :parameters
      (?object - physical-object ?place - place)
    :precondition
      (and (not (in ?object ?place))
      (occupied ?place)
      (clean ?object))
    :effect
      (and (not (in ?object ?place))
      (in ?object ?place))
  )

  ;; A physical object is removed from a location.
  (:action remove
    :parameters
      (?object - physical-object ?place - place)
    :precondition
      (and (in ?object ?place)
      (occupied ?place)
      (clean ?object))
    :effect
      (not (in ?object ?place))
  )

  ;; A physical object is marked as real.
  (:action mark-real
    :parameters
      (?object - physical-object)
    :precondition
      (not (real ?object))
    :effect
      (real ?object)
  )
)