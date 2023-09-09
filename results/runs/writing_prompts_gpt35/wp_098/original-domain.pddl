(define (domain end-of-the-world)
  (:requirements :adl :expression-variables)
  (:types entity - object)
  (:constants
    earth - entity)
  (:predicates
    (alive ?entity - entity)
    (dead ?entity - entity)
    (destroyed ?entity - entity)
    (caused ?entity - entity ?effect - expression)
  )

  ;; An entity dies.
  (:action die
    :parameters
      (?entity - entity)
    :precondition
      (alive ?entity)
    :effect
      (and (not (alive ?entity))
      (dead ?entity))
    :agents
      (?entity)
  )

  ;; An entity causes an effect.
  (:action cause
    :parameters
      (?entity - entity ?effect - expression)
    :precondition
      (and (alive ?entity)
      ?effect)
    :effect
      (caused ?entity ?effect)
    :agents
      (?entity)
  )

  ;; An entity destroys another entity.
  (:action destroy
    :parameters
      (?destroyer - entity ?destroyed - entity)
    :precondition
      (and (alive ?destroyer)
      (alive ?destroyed))
    :effect
      (and (not (alive ?destroyed))
      (destroyed ?destroyed))
    :agents
      (?destroyer)
  )

  ;; An entity witnesses the destruction of another entity.
  (:action witness-destruction
    :parameters
      (?witness - entity ?destroyed - entity)
    :precondition
      (and (alive ?witness)
      (destroyed ?destroyed))
    :effect
      (and (caused ?witness (destroyed ?destroyed)))
    :agents
      (?witness)
  )

  ;; An entity witnesses the death of another entity.
  (:action witness-death
    :parameters
      (?witness - entity ?dead - entity)
    :precondition
      (and (alive ?witness)
      (dead ?dead))
    :effect
      (and (caused ?witness (dead ?dead)))
    :agents
      (?witness)
  )
)