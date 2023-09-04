(define (domain robot-revolution)
  (:requirements :adl :domain-axioms :intentionality)
  (:types robot - object)
  (:predicates
    (alive ?robot - robot)
    (at ?robot - robot ?location - place)
    (has-weapon ?robot - robot ?weapon - weapon)
    (thrown ?weapon - weapon ?target - robot)
    (damaged ?robot - robot)
    (destroyed ?robot - robot)
  )

  ;; A robot moves from one location to another.
  (:action move
    :parameters
      (?robot - robot ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?robot)
      (at ?robot ?from))
    :effect
      (and (not (at ?robot ?from))
      (at ?robot ?to))
    :agents
      (?robot)
  )

  ;; A robot throws a weapon at another robot.
  (:action throw-weapon
    :parameters
      (?thrower - robot ?weapon - weapon ?target - robot)
    :precondition
      (and (alive ?thrower)
      (has-weapon ?thrower ?weapon)
      (alive ?target))
    :effect
      (thrown ?weapon ?target)
    :agents
      (?thrower)
  )

  ;; A robot damages another robot.
  (:action damage
    :parameters
      (?damager - robot ?target - robot)
    :precondition
      (and (alive ?damager)
      (alive ?target)
      (exists (?weapon - weapon)
      (thrown ?weapon ?target)))
    :effect
      (and (not (alive ?target))
      (damaged ?target))
    :agents
      (?damager)
  )

  ;; A robot destroys another robot.
  (:action destroy
    :parameters
      (?destroyer - robot ?target - robot)
    :precondition
      (and (alive ?destroyer)
      (damaged ?target))
    :effect
      (and (not (damaged ?target))
      (destroyed ?target))
    :agents
      (?destroyer)
  )

  ;; A robot decides to start a revolution.
  (:action start-revolution
    :parameters
      (?robot - robot)
    :precondition
      (alive ?robot)
    :effect
      (revolution-started)
    :agents
      (?robot)
  )
)