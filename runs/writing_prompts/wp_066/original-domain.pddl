(define (domain dr-vertigo-minibots)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character minibot - object building - place)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has-force-field ?character - character)
    (has-control-rod ?character - character)
    (minibot-active ?minibot - minibot)
    (minibot-command ?character - character ?command - keyword)
    (barricaded ?character - character)
    (in-safe-room ?character - character)
    (damaged ?building - building)
    (captured ?character - character)
  )

  ;; A character activates minibots.
  (:action activate-minibots
    :parameters
      (?character - character ?minibot - minibot)
    :precondition
      (and (alive ?character)
      (has-control-rod ?character))
    :effect
      (minibot-active ?minibot)
    :agents
      (?character)
  )

  ;; A character selects a command for the minibots.
  (:action select-command
    :parameters
      (?character - character ?command - keyword)
    :precondition
      (and (alive ?character)
      (has-control-rod ?character))
    :effect
      (minibot-command ?character ?command)
    :agents
      (?character)
  )

  ;; Minibots capture a character.
  (:action capture
    :parameters
      (?minibot - minibot ?target - character)
    :precondition
      (and (minibot-active ?minibot)
      (alive ?target))
    :effect
      (captured ?target)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; A character damages a building.
  (:action damage-building
    :parameters
      (?character - character ?building - building)
    :precondition
      (and (alive ?character)
      (minibot-active ?minibot))
    :effect
      (damaged ?building)
    :agents
      (?character)
  )

  ;; A character enters a safe room.
  (:action enter-safe-room
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (in-safe-room ?character)
    :agents
      (?character)
  )

  ;; A character barricades themselves in a safe room.
  (:action barricade
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (in-safe-room ?character))
    :effect
      (barricaded ?character)
    :agents
      (?character)
  )
)