(define (domain truck-driver)
  (:requirements :strips :typing :equality :expression-variables)
  (:types character - object)
  (:constants
    peterbuilt - expression
    skynyrd - expression
    seger - expression
    papst - expression
  )
  (:predicates
    (drives ?character - character ?vehicle - expression)
    (has ?character - character ?item - expression)
    (listens-to ?character - character ?music - expression)
    (intends ?character - character ?goal - expression)
  )

  ;; A character takes an item.
  (:action take
    :parameters
      (?character - character ?item - expression)
    :precondition
      (and (not (has ?character ?item)))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character drives a vehicle.
  (:action drive
    :parameters
      (?character - character ?vehicle - expression)
    :precondition
      (and (not (drives ?character ?vehicle)))
    :effect
      (drives ?character ?vehicle)
    :agents
      (?character)
  )

  ;; A character listens to music.
  (:action listen-to-music
    :parameters
      (?character - character ?music - expression)
    :precondition
      (and (not (listens-to ?character ?music)))
    :effect
      (listens-to ?character ?music)
    :agents
      (?character)
  )

  ;; A character intends to achieve a goal.
  (:action intend
    :parameters
      (?character - character ?goal - expression)
    :precondition
      (not (intends ?character ?goal))
    :effect
      (intends ?character ?goal)
    :agents
      (?character)
  )
)