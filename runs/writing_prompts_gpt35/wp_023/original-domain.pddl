(define (domain death-wish)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (dead ?character - character)
    (shot-with-arrows ?character - character)
    (playing ?character - character ?song - song)
    (at-wedding ?character - character)
    (has ?character - character ?item - item)
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

  ;; A character is shot with arrows.
  (:action shoot-with-arrows
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (at-wedding ?character)
      (playing ?character "The Rains of Castamere"))
    :effect
      (and (shot-with-arrows ?character)
      (not (alive ?character)))
    :agents
      (?character)
  )

  ;; A character plays a song.
  (:action play-song
    :parameters
      (?character - character ?song - song)
    :precondition
      (and (alive ?character))
    :effect
      (playing ?character ?song)
    :agents
      (?character)
  )

  ;; A character attends a wedding.
  (:action attend-wedding
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (at-wedding ?character)
    :agents
      (?character)
  )

  ;; One character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (at ?giver ?place)
      (has ?giver ?item)
      (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; One character kills another.
  (:action kill
    :parameters
      (?killer - character ?victim - character ?place - place)
    :precondition
      (and (alive ?killer)
      (at ?killer ?place)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (and (dead ?character)
      (not (alive ?character)))
    :agents
      (?character)
  )
)