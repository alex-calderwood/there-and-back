(define (domain archaeological-dig)
  (:requirements :strips :negative-preconditions :typing :equality :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables)
  (:types character - object item - object place - object)
  (:constants journal - item)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (alive ?character - character)
    (knows ?character - character ?fact - expression)
    (intends ?character - character ?goal - expression)
    (destroyed ?place - place)
    (destroyed ?item - item)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character destroys an item.
  (:action destroy
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item)
      (knows ?character (destroyed ?item)))
    :effect
      (and (not (has ?character ?item))
      (destroyed ?item))
    :agents  (?character)
  )

  ;; A character knows a fact.
  (:action know
    :parameters
      (?character - character ?fact - expression)
    :precondition
      (alive ?character)
    :effect
      (knows ?character ?fact)
    :agents  (?character)
  )

  ;; A character intends a goal.
  (:action intend
    :parameters
      (?character - character ?goal - expression)
    :precondition
      (alive ?character)
    :effect
      (intends ?character ?goal)
    :agents  (?character)
  )

  ;; A character waits for a certain amount of time.
  (:action wait
    :parameters
      (?character - character ?time - expression)
    :precondition
      (alive ?character)
    :effect
      (and (knows ?character (time-passed ?time))
      (not (knows ?character (time-passed (- ?time)))))
    :agents  (?character)
  )

  ;; A character moves an item from one place to another.
  (:action move-item
    :parameters
      (?character - character ?item - item ?from - place ?to - place)
    :precondition
      (and (alive ?character)
      (at ?character ?from)
      (has ?character ?item)
      (not (= ?from ?to)))
    :effect
      (and (not (at ?character ?from))
      (not (has ?character ?item))
      (at ?item ?to))
    :agents  (?character)
  )

  ;; A character fakes being sick.
  (:action fake-sick
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (knows ?character (sick ?character))
    :agents  (?character)
  )

  ;; A character presses a button that triggers an explosion.
  (:action trigger-explosion
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (knows ?character (button ?place)))
    :effect
      (and (knows ?character (explosion ?place))
      (destroyed ?place))
    :agents  (?character)
  )

  ;; A character laughs in glee.
  (:action laugh
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (knows ?character (glee ?character))
    :agents  (?character)
  )

  ;; A character lights a flame to destroy an item.
  (:action light-flame
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item)
      (knows ?character (flame ?item))))
    :effect
      (and (not (has ?character ?item))
      (destroyed ?item))
    :agents  (?character)
  )

  ;; Time passes.
  (:action time-passes
    :parameters
      (?time - expression)
    :precondition
      (and (not (= ?time 0))
      (knows ?character (time-passed (- ?time))))
    :effect
      (and (knows ?character (time-passed ?time))
      (not (knows ?character (time-passed (- ?time))))))
)