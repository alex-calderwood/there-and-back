(define (domain painting-friends)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (has ?character - character ?item - item)
    (at ?character - character ?place - place)
    (painting ?character - character)
    (happy ?character - character)
    (likes ?character - character ?item - item)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character starts painting.
  (:action start-painting
    :parameters
      (?character - character)
    :precondition
      (and (happy ?character)
      (not (painting ?character)))
    :effect
      (painting ?character)
    :agents
      (?character)
  )

  ;; A character stops painting.
  (:action stop-painting
    :parameters
      (?character - character)
    :precondition
      (painting ?character)
    :effect
      (not (painting ?character))
    :agents
      (?character)
  )

  ;; A character compliments another character's item.
  (:action compliment
    :parameters
      (?complimenter - character ?complimented - character ?item - item)
    :precondition
      (and (not (= ?complimenter ?complimented))
      (has ?complimented ?item))
    :effect
      (likes ?complimenter ?item)
    :agents
      (?complimenter)
  )

  ;; A character invites another character to paint.
  (:action invite-to-paint
    :parameters
      (?inviter - character ?invitee - character)
    :precondition
      (and (not (= ?inviter ?invitee))
      (happy ?inviter)
      (happy ?invitee))
    :effect
      (and (painting ?inviter)
      (painting ?invitee))
    :agents
      (?inviter ?invitee)
  )
)