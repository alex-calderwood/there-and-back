(define (domain find-cap)
  (:requirements :strips :typing :equality)
  (:types object - physical-object)
  (:predicates
    (has-cap ?object - object)
    (has-new-cap ?object - object)
  )

  ;; A character searches for a cap.
  (:action search
    :parameters
      (?character - object ?place - object)
    :precondition
      (and (not (has-cap ?character))
      (not (has-new-cap ?character))
      (at ?character ?place))
    :effect
      (has-cap ?character)
    :agents
      (?character)
  )

  ;; A dog finds a cap.
  (:action find
    :parameters
      (?dog - object ?cap - object ?place - object)
    :precondition
      (and (not (has-cap ?dog))
      (at ?dog ?place)
      (has-cap ?cap)
      (at ?cap ?place))
    :effect
      (and (not (has-cap ?cap))
      (has-cap ?dog)
      (not (at ?cap ?place))
      (at ?dog ?place))
    :agents
      (?dog)
  )

  ;; A character takes a cap from a dog.
  (:action take
    :parameters
      (?character - object ?cap - object ?dog - object ?place - object)
    :precondition
      (and (has-cap ?dog)
      (at ?dog ?place)
      (at ?cap ?place)
      (not (has-cap ?character))
      (not (= ?character ?dog))
      (at ?character ?place))
    :effect
      (and (not (has-cap ?dog))
      (has-cap ?character)
      (not (at ?cap ?place))
      (at ?character ?place))
    :agents
      (?character)
  )

  ;; A character puts on a cap.
  (:action put-on
    :parameters
      (?character - object ?cap - object ?place - object)
    :precondition
      (and (has-cap ?character)
      (at ?character ?place)
      (at ?cap ?place)
      (not (has-new-cap ?character)))
    :effect
      (and (not (has-cap ?character))
      (has-new-cap ?character)
      (not (at ?cap ?place))
      (at ?character ?place))
    :agents
      (?character)
  )
)