(define (domain man-shape)
  (:requirements :strips :typing :equality :negative-preconditions)
  (:types man-shape - object)
  (:constants
    bullet - object
    gun - object
  )
  (:predicates
    (alive ?man-shape - man-shape)
    (has ?man-shape - man-shape ?object - object)
    (carries ?man-shape - man-shape ?object - object)
    (enemy ?man-shape - man-shape)
    (damaged ?man-shape - man-shape)
    (blinded ?man-shape - man-shape)
  )

  ;; A man-shape walks forward.
  (:action walk
    :parameters
      (?man-shape - man-shape ?destination - object)
    :precondition
      (and (alive ?man-shape)
      (not (blinded ?man-shape))
      (not (damaged ?man-shape))
      (not (= ?man-shape ?destination)))
    :effect
      (and (not (at ?man-shape ?destination))
      (at ?man-shape ?destination))
  )

  ;; A man-shape fires its gun at another man-shape.
  (:action fire
    :parameters
      (?shooter - man-shape ?target - man-shape ?bullet - object)
    :precondition
      (and (alive ?shooter)
      (not (blinded ?shooter))
      (not (damaged ?shooter))
      (carries ?shooter gun)
      (at ?shooter ?location)
      (at ?target ?location)
      (enemy ?target)
      (alive ?target))
    :effect
      (and (not (alive ?target))
      (not (has ?shooter gun))
      (not (carries ?shooter bullet))
      (has ?location bullet))
  )

  ;; A man-shape is damaged by a bullet.
  (:action damage
    :parameters
      (?man-shape - man-shape ?bullet - object)
    :precondition
      (and (alive ?man-shape)
      (not (blinded ?man-shape))
      (not (damaged ?man-shape))
      (at ?man-shape ?location)
      (has ?location bullet))
    :effect
      (and (damaged ?man-shape)
      (not (has ?location bullet)))
  )

  ;; A man-shape is blinded by a bullet.
  (:action blind
    :parameters
      (?man-shape - man-shape ?bullet - object)
    :precondition
      (and (alive ?man-shape)
      (not (blinded ?man-shape))
      (not (damaged ?man-shape))
      (at ?man-shape ?location)
      (has ?location bullet))
    :effect
      (and (blinded ?man-shape)
      (not (has ?location bullet)))
  )

  ;; A man-shape commits suicide.
  (:action suicide
    :parameters
      (?man-shape - man-shape)
    :precondition
      (and (alive ?man-shape)
      (not (blinded ?man-shape))
      (not (damaged ?man-shape)))
    :effect
      (not (alive ?man-shape))
  )
)