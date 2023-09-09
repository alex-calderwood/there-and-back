(define (domain jen-birthday-cards)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object milestone - item)
  (:constants
    cancer - milestone
    birch-box - object
  )
  (:predicates
    (has-card ?character - character ?milestone - milestone)
    (alive ?character - character)
    (at ?character - character ?place - place)
    (intends ?character - character ?predicate - predicate)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character receives a card for a milestone.
  (:action receive-card
    :parameters
      (?receiver - character ?milestone - milestone)
    :precondition
      (and (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (has-card ?receiver ?milestone)
    :agents
      (?receiver)
  )

  ;; A character reads a card for a milestone.
  (:action read-card
    :parameters
      (?reader - character ?milestone - milestone)
    :precondition
      (and (alive ?reader)
      (at ?reader ?place)
      (has-card ?reader ?milestone))
    :effect
      (not (has-card ?reader ?milestone))
    :agents
      (?reader)
  )

  ;; A character stores a card in the birch box.
  (:action store-card
    :parameters
      (?character - character ?milestone - milestone)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (has-card ?character ?milestone))))
    :effect
      (has-card birch-box ?milestone)
    :agents
      (?character)
  )

  ;; A character opens the birch box.
  (:action open-box
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (and (not (has-card birch-box ?milestone))
      (intends ?character (has-card ?character ?milestone)))
    :agents
      (?character)
  )

  ;; A character closes the birch box.
  (:action close-box
    :precondition
      (intends ?character (has-card ?character ?milestone))
    :effect
      (has-card birch-box ?milestone)
  )

  ;; A character receives chemotherapy treatment.
  (:action chemotherapy
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )

  ;; When a character has a card for a milestone, they intend to read it.
  (:axiom
    :vars
      (?character - character ?milestone - milestone)
    :context
      (has-card ?character ?milestone)
    :implies
      (intends ?character (has-card ?character ?milestone))
  )
)