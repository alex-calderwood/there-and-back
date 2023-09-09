(define (domain human-chop-shop)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object key - object)
  (:predicates
    (at ?person - person ?location - object)
    (locked ?location - object)
    (unlocked ?key - key ?location - object)
    (has ?person - person ?key - key)
    (alive ?person - person)
    (evidence-found)
  )

  ;; A person unlocks a location with a key.
  (:action unlock
    :parameters
      (?person - person ?key - key ?location - object)
    :precondition
      (and (at ?person ?location)
      (has ?person ?key)
      (locked ?location)
      (unlocked ?key ?location)
      (alive ?person))
    :effect
      (and (not (locked ?location))
      (not (unlocked ?key ?location)))
    :agents
      (?person)
  )

  ;; A person opens a door.
  (:action open-door
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (at ?person ?location)
      (not (locked ?location))
      (alive ?person))
    :effect
      (and (not (closed ?location)))
    :agents
      (?person)
  )

  ;; A person closes a door.
  (:action close-door
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (at ?person ?location)
      (not (locked ?location))
      (not (closed ?location))
      (alive ?person))
    :effect
      (and (closed ?location))
    :agents
      (?person)
  )

  ;; A person finds evidence.
  (:action find-evidence
    :parameters
      (?person - person)
    :precondition
      (and (at ?person ?location)
      (alive ?person))
    :effect
      (evidence-found)
    :agents
      (?person)
  )

  ;; A person dies.
  (:action die
    :parameters
      (?person - person)
    :precondition
      (alive ?person)
    :effect
      (not (alive ?person))
    :agents
      (?person)
  )
)