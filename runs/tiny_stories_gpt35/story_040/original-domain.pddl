(define (domain mountain-adventure)
  (:requirements :strips :typing :equality :existential-preconditions)
  (:types object - physical-object place - object character - object)
  (:predicates
    (at ?character - character ?place - place)
    (toy ?object - object)
    (lost ?object - object)
    (happy ?character - character)
    (scared ?character - character)
    (helped ?character - character)
    (friend ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character loses an object.
  (:action lose
    :parameters
      (?character - character ?object - object ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (lost ?object))
      (not (at ?object ?place)))
    :effect
      (and (lost ?object)
      (not (at ?object ?place)))
    :agents  (?character)
  )

  ;; A character finds a lost object.
  (:action find
    :parameters
      (?character - character ?object - object ?place - place)
    :precondition
      (and (at ?character ?place)
      (lost ?object)
      (at ?object ?place))
    :effect
      (and (not (lost ?object))
      (at ?object ?place))
    :agents  (?character)
  )

  ;; A character becomes happy.
  (:action make-happy
    :parameters
      (?character - character)
    :precondition
      (scared ?character)
    :effect
      (and (not (scared ?character))
      (happy ?character))
    :agents  (?character)
  )

  ;; A character becomes scared.
  (:action make-scared
    :parameters
      (?character - character)
    :precondition
      (not (scared ?character))
    :effect
      (and (not (happy ?character))
      (scared ?character))
    :agents  (?character)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :precondition
      (and (not (= ?helper ?helpee))
      (at ?helper ?place)
      (at ?helpee ?place)
      (scared ?helpee))
    :effect
      (and (not (scared ?helpee))
      (helped ?helpee)
      (friend ?helper ?helpee))
    :agents
      (?helper)
  )

  ;; A character is carried by another character.
  (:action carry
    :parameters
      (?carrier - character ?carried - character ?place - place)
    :precondition
      (and (not (= ?carrier ?carried))
      (at ?carrier ?place)
      (at ?carried ?place)
      (happy ?carried))
    :effect
      (and (not (at ?carried ?place))
      (at ?carried ?carrier))
    :agents
      (?carrier)
  )
)