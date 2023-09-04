(define (domain mixy-the-mixer)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types object - object)
  (:constants mommy - object)
  (:predicates
    (at ?object - object ?location - object)
    (scared ?object - object)
    (has ?object - object ?item - object)
    (intends ?object - object ?predicate - predicate)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - object ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character catches a spider.
  (:action catch-spider
    :parameters
      (?character - object ?spider - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (at ?spider ?location)
      (not (has ?character ?spider)))
    :effect
      (and (not (at ?spider ?location))
      (not (scared ?character))
      (has ?character ?spider))
    :agents
      (?character)
  )

  ;; A character releases a spider.
  (:action release-spider
    :parameters
      (?character - object ?spider - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (has ?character ?spider))
    :effect
      (and (at ?spider ?location)
      (not (has ?character ?spider)))
    :agents
      (?character)
  )

  ;; A character finishes making a cake.
  (:action finish-cake
    :parameters
      (?character - object ?cake - object ?location - object)
    :precondition
      (and (at ?character ?location)
      (has ?character ?cake))
    :effect
      (and (not (has ?character ?cake)))
    :agents
      (?character)
  )
)