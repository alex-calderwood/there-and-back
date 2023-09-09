(define (domain city-support)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object project - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (happy ?character - character)
    (amazed ?character - character)
    (supports ?character - character ?project - project)
    (persistent ?character - character)
    (completed ?project - project)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character becomes amazed.
  (:action become-amazed
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (amazed ?character)
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character supports a project.
  (:action support-project
    :parameters
      (?character - character ?project - project)
    :precondition
      (alive ?character)
    :effect
      (supports ?character ?project)
    :agents
      (?character)
  )

  ;; A character becomes persistent.
  (:action become-persistent
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (persistent ?character)
    :agents
      (?character)
  )

  ;; A character completes a project.
  (:action complete-project
    :parameters
      (?character - character ?project - project)
    :precondition
      (and (alive ?character)
      (supports ?character ?project)
      (persistent ?character))
    :effect
      (completed ?project)
    :agents
      (?character)
  )
)