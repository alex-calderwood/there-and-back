(define (domain toy-cat)
  (:requirements :strips :typing :equality)
  (:types object - physical-object toy - object)
  (:predicates
    (inside ?toy - toy ?object - object)
    (happy ?toy - toy)
    (played ?toy - toy)
  )

  ;; A toy is put inside an object.
  (:action put-inside
    :parameters
      (?toy - toy ?object - object)
    :precondition
      (and (not (inside ?toy ?object)))
    :effect
      (inside ?toy ?object)
  )

  ;; A toy is taken out of an object.
  (:action take-out
    :parameters
      (?toy - toy ?object - object)
    :precondition
      (inside ?toy ?object)
    :effect
      (not (inside ?toy ?object))
  )

  ;; A toy becomes happy.
  (:action make-happy
    :parameters
      (?toy - toy)
    :precondition
      (not (happy ?toy))
    :effect
      (happy ?toy)
  )

  ;; A toy is played with.
  (:action play-with
    :parameters
      (?toy - toy)
    :precondition
      (and (inside ?toy ?object)
      (happy ?toy))
    :effect
      (played ?toy)
  )
)