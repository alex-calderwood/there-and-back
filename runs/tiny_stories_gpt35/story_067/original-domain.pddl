(define (domain toy-factory)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types worker - object toy - object)
  (:predicates
    (at ?worker - worker ?location - object)
    (clean ?location - object)
    (made ?toy - toy)
    (friend ?worker - worker ?other-worker - worker)
  )

  ;; A worker moves from one location to another.
  (:action move
    :parameters
      (?worker - worker ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?worker ?from))
    :effect
      (and (not (at ?worker ?from))
      (at ?worker ?to))
  )

  ;; A worker cleans a location.
  (:action clean
    :parameters
      (?worker - worker ?location - object)
    :precondition
      (and (at ?worker ?location)
      (not (clean ?location)))
    :effect
      (clean ?location)
  )

  ;; A worker makes a toy.
  (:action make-toy
    :parameters
      (?worker - worker ?toy - toy)
    :precondition
      (and (at ?worker factory)
      (clean factory))
    :effect
      (made ?toy)
  )

  ;; Two workers become friends.
  (:action make-friends
    :parameters
      (?worker1 - worker ?worker2 - worker)
    :precondition
      (and (at ?worker1 factory)
      (at ?worker2 factory)
      (not (= ?worker1 ?worker2)))
    :effect
      (and (friend ?worker1 ?worker2)
      (friend ?worker2 ?worker1))
  )
)