(define (domain mask-fun)
  (:requirements :strips :typing :equality)
  (:types character - object)
  (:predicates
    (has-mask ?character - character)
    (at ?character - character ?location - object)
    (knows ?character - character ?other - character)
    (same-friends)
  )

  ;; A character puts on a mask.
  (:action put-on-mask
    :parameters
      (?character - character)
    :precondition
      (and (not (has-mask ?character)))
    :effect
      (has-mask ?character)
  )

  ;; A character takes off a mask.
  (:action take-off-mask
    :parameters
      (?character - character)
    :precondition
      (has-mask ?character)
    :effect
      (not (has-mask ?character))
  )

  ;; Two characters meet and get to know each other.
  (:action meet
    :parameters
      (?character1 - character ?character2 - character ?location - object)
    :precondition
      (and (not (= ?character1 ?character2))
      (at ?character1 ?location)
      (at ?character2 ?location)
      (not (knows ?character1 ?character2))
      (not (knows ?character2 ?character1)))
    :effect
      (and (knows ?character1 ?character2)
      (knows ?character2 ?character1))
  )

  ;; Two characters realize they are friends.
  (:action realize-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (knows ?character1 ?character2)
      (knows ?character2 ?character1)
      (has-mask ?character1)
      (has-mask ?character2))
    :effect
      (same-friends)
  )
)