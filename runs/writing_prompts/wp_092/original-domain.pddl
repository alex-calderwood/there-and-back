(define (domain family-meeting)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (ready ?character - character)
    (has-lover ?character - character)
    (has-child ?character - character)
    (is-grandmother ?character - character)
    (is-ill ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (ready ?character))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character gets ready for the journey.
  (:action get-ready
    :parameters
      (?character - character)
    :precondition
      (not (ready ?character))
    :effect
      (ready ?character)
    :agents
      (?character)
  )

  ;; A character becomes a grandmother.
  (:action become-grandmother
    :parameters
      (?character - character)
    :precondition
      (and (not (is-grandmother ?character))
      (exists (?child - character)
        (has-child ?character ?child)))
    :effect
      (is-grandmother ?character)
    :agents
      (?character)
  )

  ;; A character becomes ill.
  (:action become-ill
    :parameters
      (?character - character)
    :precondition
      (not (is-ill ?character))
    :effect
      (is-ill ?character)
    :agents
      (?character)
  )

  ;; A character recovers from illness.
  (:action recover
    :parameters
      (?character - character)
    :precondition
      (is-ill ?character)
    :effect
      (not (is-ill ?character))
    :agents
      (?character)
  )
)