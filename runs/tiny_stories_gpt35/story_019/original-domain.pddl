(define (domain tim-draws)
  (:requirements :strips :typing :equality)
  (:types object - physical-object)
  (:predicates
    (has-color ?object - object)
    (has-paper ?object - object)
    (has-print ?object - object)
    (at ?object - object ?location - object)
  )

  ;; Tim puts his hands in the colors.
  (:action put-hands-in-color
    :parameters
      (?tim - object ?color - object)
    :precondition
      (and (at ?tim ?location)
      (has-color ?color))
    :effect
      (and (not (has-color ?color))
      (has-color ?tim ?color))
    :agents
      (?tim)
  )

  ;; Tim puts his hands on the paper.
  (:action put-hands-on-paper
    :parameters
      (?tim - object ?paper - object ?color - object)
    :precondition
      (and (at ?tim ?location)
      (has-color ?tim ?color)
      (has-paper ?paper)
      (not (has-print ?paper)))
    :effect
      (and (not (has-color ?tim ?color))
      (has-print ?paper))
    :agents
      (?tim)
  )

  ;; Tim shows his parents his big hand print.
  (:action show-print
    :parameters
      (?tim - object ?print - object ?parent - object)
    :precondition
      (and (at ?tim ?location)
      (has-print ?print)
      (at ?parent ?location))
    :effect
      (and (not (has-print ?print))
      (has-print ?parent ?print))
    :agents
      (?tim ?parent)
  )

  ;; Tim's parents celebrate his big hand print.
  (:action celebrate
    :parameters
      (?parent - object ?print - object)
    :precondition
      (and (at ?parent ?location)
      (has-print ?parent ?print))
    :effect
      (and (not (has-print ?parent ?print)))
    :agents
      (?parent)
  )
)