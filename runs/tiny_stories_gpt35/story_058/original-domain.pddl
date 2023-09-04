(define (domain balancing-act)
  (:requirements :strips :typing)
  (:types person ant - object)
  (:predicates
    (on-razor ?object - object)
    (at ?object - object ?location - object)
  )

  ;; A person moves to a location.
  (:action move
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; An ant moves to a location.
  (:action ant-move
    :parameters
      (?ant - ant ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?ant ?from))
    :effect
      (and (not (at ?ant ?from))
      (at ?ant ?to))
  )

  ;; A person balances on a razor.
  (:action balance
    :parameters
      (?person - person ?razor - object)
    :precondition
      (and (at ?person ?razor))
    :effect
      (on-razor ?person ?razor)
  )

  ;; An ant balances on a razor.
  (:action ant-balance
    :parameters
      (?ant - ant ?razor - object)
    :precondition
      (and (at ?ant ?razor))
    :effect
      (on-razor ?ant ?razor)
  )
)