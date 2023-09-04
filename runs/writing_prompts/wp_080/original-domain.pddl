(define (domain centaur-mines)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?item - item)
    (working ?character - character)
    (trusts ?character1 - character ?character2 - character)
    (in-revolution ?character - character)
    (extra-arms ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character starts working in the mines.
  (:action start-working
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (working ?character)
    :agents
      (?character)
  )

  ;; A character stops working in the mines.
  (:action stop-working
    :parameters
      (?character - character)
    :precondition
      (working ?character)
    :effect
      (not (working ?character))
    :agents
      (?character)
  )

  ;; A character trusts another character.
  (:action trust
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (= ?character1 ?character2)))
    :effect
      (trusts ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character loses trust in another character.
  (:action lose-trust
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (trusts ?character1 ?character2)
    :effect
      (not (trusts ?character1 ?character2))
    :agents
      (?character1)
  )

  ;; A character joins the revolution.
  (:action join-revolution
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (in-revolution ?character)
    :agents
      (?character)
  )

  ;; A character gets extra arms.
  (:action get-extra-arms
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (extra-arms ?character)))
    :effect
      (extra-arms ?character)
    :agents
      (?character)
  )

  ;; A character loses extra arms.
  (:action lose-extra-arms
    :parameters
      (?character - character)
    :precondition
      (extra-arms ?character)
    :effect
      (not (extra-arms ?character))
    :agents
      (?character)
  )
)