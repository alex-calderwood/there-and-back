(define (domain fox-and-mouse)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (stuck ?character - character ?place - place)
    (helped ?character - character ?helper - character)
    (best-friends ?character - character ?friend - character)
  )

  ;; A character walks from one place to another.
  (:action walk
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character gets stuck in a place.
  (:action get-stuck
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (stuck ?character ?place)
  )

  ;; A character gets unstuck with the help of another character.
  (:action get-unstuck
    :parameters
      (?character - character ?helper - character ?place - place)
    :precondition
      (and (stuck ?character ?place)
      (at ?helper ?place))
    :effect
      (and (not (stuck ?character ?place))
      (helped ?character ?helper))
    :agents
      (?helper)
  )

  ;; Two characters become best friends.
  (:action become-best-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (helped ?character1 ?character2)
      (helped ?character2 ?character1))
    :effect
      (and (best-friends ?character1 ?character2)
      (best-friends ?character2 ?character1))
  )
)