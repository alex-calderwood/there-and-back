(define (domain burden)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables :intentionality)
  (:types character - object)
  (:constants narrator - character)
  (:predicates
    (alive ?character - character)
    (intends ?character - character ?predicate - expression)
    (knows ?character - character ?predicate - expression)
    (believes ?character - character ?predicate - expression)
    (burdened ?character - character ?predicate - expression)
    (relieved ?character - character ?predicate - expression)
    (hides ?character - character ?predicate - expression)
    (reveals ?character - character ?predicate - expression)
    (narrates ?predicate - expression)
  )

  ;; A character hides a burden.
  (:action hide
    :parameters
      (?character - character ?predicate - expression)
    :precondition
      (and (alive ?character)
      (intends ?character (hides ?character ?predicate) ?predicate))
    :effect
      (and (not (believes ?character ?predicate))
      (not (burdened ?character ?predicate))
      (hides ?character ?predicate))
    :agents
      (?character)
  )

  ;; A character reveals a burden.
  (:action reveal
    :parameters
      (?character - character ?predicate - expression)
    :precondition
      (and (alive ?character)
      (intends ?character (reveals ?character ?predicate) ?predicate)
      (hides ?character ?predicate))
    :effect
      (and (believes ?character ?predicate)
      (burdened ?character ?predicate)
      (not (hides ?character ?predicate))
      (reveals ?character ?predicate))
    :agents
      (?character)
  )

  ;; A character is relieved of a burden.
  (:action relieve
    :parameters
      (?character - character ?predicate - expression)
    :precondition
      (and (alive ?character)
      (intends ?character (relieved ?character ?predicate) ?predicate)
      (burdened ?character ?predicate)
      (reveals ?character ?predicate))
    :effect
      (and (not (burdened ?character ?predicate))
      (not (reveals ?character ?predicate))
      (relieved ?character ?predicate))
    :agents
      (?character)
  )

  ;; The narrator tells a story.
  (:action narrate
    :parameters
      (?predicate - expression)
    :precondition
      (and (narrates ?predicate))
    :effect
      (narrates ?predicate)
    :agents
      (narrator)
  )

  ;; A character believes a predicate.
  (:action believe
    :parameters
      (?character - character ?predicate - expression)
    :precondition
      (and (alive ?character)
      (intends ?character (believes ?character ?predicate) ?predicate)
      (reveals ?character ?predicate))
    :effect
      (believes ?character ?predicate)
    :agents
      (?character)
  )

  ;; A character is burdened by a predicate.
  (:action burden
    :parameters
      (?character - character ?predicate - expression)
    :precondition
      (and (alive ?character)
      (intends ?character (burdened ?character ?predicate) ?predicate)
      (reveals ?character ?predicate))
    :effect
      (burdened ?character ?predicate)
    :agents
      (?character)
  )
)