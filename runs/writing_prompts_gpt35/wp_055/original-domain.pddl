(define (domain zombie-apocalypse)
  (:requirements :strips :negative-preconditions :typing :equality :quantified-preconditions :existential-preconditions :universal-preconditions :universal-effects :conditional-effects :expression-variables)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (zombie ?character - character)
    (has ?character - character ?item - object)
    (at ?character - character ?location - object)
    (clogged ?object - object)
    (inconvenient ?object - object)
    (smell ?object - object)
    (hear ?object - object)
    (stocked ?object - object)
    (electricity ?object - object)
    (run ?object - object)
    (amused ?object - object)
    (vent ?object - object)
    (sneak ?object - object)
    (book-it ?object - object)
    (venture-out ?object - object)
    (find ?object - object ?item - object)
    (burn ?object - object)
    (wait ?object - object)
    (leave ?object - object)
    (disturb ?object - object)
    (visit ?object - object)
    (run-well ?object - object)
    (stop ?object - object)
    (have-sex ?object - object)
    (talk ?object - object)
    (eat ?object - object)
    (drink ?object - object)
    (play ?object - object)
    (read ?object - object)
    (use ?object - object)
    (kill ?character - character)
    (zombie-attack ?character - character)
    (zombie-bite ?character - character)
    (zombie-transformation ?character - character)
    (zombie-infection ?character - character)
    (zombie-apocalypse)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
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

  ;; A character searches for an item.
  (:action search
    :parameters
      (?character - character ?location - object ?item - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (inconvenient ?item)
      (find ?location ?item))
    :effect
      (and (not (inconvenient ?item))
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character burns an object.
  (:action burn
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (at ?character ?object)
      (inconvenient ?object))
    :effect
      (and (not (inconvenient ?object))
      (burn ?character ?object))
    :agents
      (?character)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (at ?killer ?location)
      (alive ?victim)
      (at ?victim ?location))
    :effect
      (and (not (alive ?victim))
      (kill ?killer ?victim))
    :agents
      (?killer)
  )

  ;; A character is attacked by a zombie.
  (:action zombie-attack
    :parameters
      (?zombie - character ?victim - character)
    :precondition
      (and (zombie ?zombie)
      (at ?zombie ?location)
      (alive ?victim)
      (at ?victim ?location))
    :effect
      (and (not (alive ?victim))
      (zombie-attack ?zombie ?victim))
    :agents
      (?zombie)
  )

  ;; A character is bitten by a zombie.
  (:action zombie-bite
    :parameters
      (?zombie - character ?victim - character)
    :precondition
      (and (zombie ?zombie)
      (at ?zombie ?location)
      (alive ?victim)
      (at ?victim ?location))
    :effect
      (and (zombie-bite ?zombie ?victim))
    :agents
      (?zombie)
  )

  ;; A character transforms into a zombie.
  (:action zombie-transformation
    :parameters
      (?character - character)
    :precondition
      (and (zombie-bite ?zombie ?character)
      (alive ?character))
    :effect
      (and (not (alive ?character))
      (zombie ?character)
      (zombie-infection ?zombie ?character))
  )

  ;; The zombie apocalypse begins.
  (:action zombie-apocalypse
    :precondition
      (and (not (zombie-apocalypse))
      (exists (?zombie - character)
      (at ?zombie ?location)))
    :effect
      (zombie-apocalypse)
  )
)