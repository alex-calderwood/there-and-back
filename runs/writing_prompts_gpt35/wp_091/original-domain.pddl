(define (domain breakup)
  (:requirements :strips :typing)
  (:types person - object)
  (:predicates
    (broken-up)
    (feels-awful ?person - person)
    (thinking-about-breakup ?person - person)
    (tried-to-change ?person - person)
    (picks-wrong-partner ?person - person)
    (learns-from-mistakes ?person - person)
    (forgives-self ?person - person)
    (moves-on ?person - person)
  )

  ;; A person tries to change their partner.
  (:action try-to-change
    :parameters
      (?person - person)
    :precondition
      (and (not (broken-up))
      (not (learns-from-mistakes ?person))
      (picks-wrong-partner ?person))
    :effect
      (tried-to-change ?person)
  )

  ;; A person learns from their mistakes.
  (:action learn-from-mistakes
    :parameters
      (?person - person)
    :precondition
      (and (not (broken-up))
      (tried-to-change ?person))
    :effect
      (learns-from-mistakes ?person)
  )

  ;; A person forgives themselves.
  (:action forgive-self
    :parameters
      (?person - person)
    :precondition
      (and (not (broken-up))
      (learns-from-mistakes ?person))
    :effect
      (forgives-self ?person)
  )

  ;; A person moves on.
  (:action move-on
    :parameters
      (?person - person)
    :precondition
      (and (not (broken-up))
      (forgives-self ?person))
    :effect
      (moves-on ?person)
  )
)