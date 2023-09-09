(define (domain magic-bird)
  (:requirements :strips :typing :equality :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables)
  (:types person - object)
  (:constants bird - object)
  (:predicates
    (has-snack ?person - person)
    (shared-snack ?person - person)
    (magic-bird ?bird - object)
    (big ?bird - object)
    (small ?bird - object)
    (wish-granted)
  )

  ;; A person shares their snack with the bird.
  (:action share-snack
    :parameters
      (?person - person ?bird - object)
    :precondition
      (and (not (shared-snack ?person))
      (has-snack ?person)
      (small ?bird))
    :effect
      (and (shared-snack ?person)
      (not (small ?bird))
      (big ?bird))
  )

  ;; The magic bird grants a wish.
  (:action grant-wish
    :parameters
      (?person - person ?bird - object)
    :precondition
      (and (shared-snack ?person)
      (big ?bird)
      (not (wish-granted)))
    :effect
      (and (wish-granted))
  )
)