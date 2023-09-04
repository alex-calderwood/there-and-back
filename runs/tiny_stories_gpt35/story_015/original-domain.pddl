(define (domain dog-race)
  (:requirements :strips :typing :equality)
  (:types dog toy - object)
  (:predicates
    (at ?dog - dog ?location - object)
    (holding ?dog - dog ?toy - toy)
    (stacked ?toy - toy)
    (knocked-down ?toy - toy)
    (racing ?dog - dog)
    (won ?dog - dog)
  )

  ;; A dog picks up a toy.
  (:action pick-up
    :parameters
      (?dog - dog ?toy - toy ?location - object)
    :precondition
      (and (at ?dog ?location)
      (at ?toy ?location)
      (stacked ?toy))
    :effect
      (and (not (at ?toy ?location))
      (not (stacked ?toy))
      (holding ?dog ?toy))
    :agents
      (?dog)
  )

  ;; A dog puts down a toy.
  (:action put-down
    :parameters
      (?dog - dog ?toy - toy ?location - object)
    :precondition
      (and (at ?dog ?location)
      (holding ?dog ?toy))
    :effect
      (and (at ?toy ?location)
      (stacked ?toy)
      (not (holding ?dog ?toy)))
    :agents
      (?dog)
  )

  ;; A dog knocks down a toy.
  (:action knock-down
    :parameters
      (?dog - dog ?toy - toy ?location - object)
    :precondition
      (and (at ?dog ?location)
      (holding ?dog ?toy)
      (stacked ?toy))
    :effect
      (and (not (stacked ?toy))
      (knocked-down ?toy))
    :agents
      (?dog)
  )

  ;; A dog builds up a toy stack.
  (:action build-stack
    :parameters
      (?dog - dog ?toy - toy ?location - object)
    :precondition
      (and (at ?dog ?location)
      (holding ?dog ?toy)
      (knocked-down ?toy))
    :effect
      (and (stacked ?toy)
      (not (knocked-down ?toy)))
    :agents
      (?dog)
  )

  ;; A dog races.
  (:action race
    :parameters
      (?dog - dog ?location - object)
    :precondition
      (and (at ?dog ?location)
      (not (racing ?dog)))
    :effect
      (racing ?dog)
    :agents
      (?dog)
  )

  ;; A dog wins the race.
  (:action win-race
    :parameters
      (?dog - dog ?location - object)
    :precondition
      (and (at ?dog ?location)
      (racing ?dog))
    :effect
      (and (won ?dog)
      (not (racing ?dog)))
    :agents
      (?dog)
  )
)