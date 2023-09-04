(define (domain toy-cat-story)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (inside ?item - item ?container - item)
    (happy ?character - character)
    (play ?character1 - character ?character2 - character)
    (open ?container - item)
  )

  ;; A character moves an item from one container to another.
  (:action move-item
    :parameters
      (?character - character ?item - item ?from - item ?to - item)
    :precondition
      (and (inside ?item ?from)
      (open ?from)
      (open ?to)
      (at ?character ?place))
    :effect
      (and (not (inside ?item ?from))
      (inside ?item ?to))
    :agents  (?character)
  )

  ;; A character opens a container.
  (:action open-container
    :parameters
      (?character - character ?container - item)
    :precondition
      (and (not (open ?container))
      (at ?character ?place))
    :effect
      (open ?container)
    :agents  (?character)
  )

  ;; A character closes a container.
  (:action close-container
    :parameters
      (?character - character ?container - item)
    :precondition
      (and (open ?container)
      (at ?character ?place))
    :effect
      (not (open ?container))
    :agents  (?character)
  )

  ;; A character plays with another character.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (happy ?character2))
      (not (play ?character1 ?character2))
      (at ?character1 ?place))
    :effect
      (and (happy ?character2)
      (play ?character1 ?character2))
    :agents  (?character1)
  )
)