(define (domain end-of-humanity)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (feeling ?character - character)
    (last-soul ?character - character)
    (understand ?character - character)
    (witness ?character - character)
    (end ?character - character)
  )

  ;; A character starts feeling.
  (:action start-feeling
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (feeling ?character)))
    :effect
      (feeling ?character)
    :agents
      (?character)
  )

  ;; A character witnesses the end.
  (:action witness-end
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (witness ?character)))
    :effect
      (witness ?character)
    :agents
      (?character)
  )

  ;; A character understands the end.
  (:action understand-end
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (witness ?character)
      (not (understand ?character)))
    :effect
      (understand ?character)
    :agents
      (?character)
  )

  ;; The last soul fades away.
  (:action last-soul-fades
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (last-soul ?character)
      (understand ?character))
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )

  ;; The end of humanity.
  (:action humanity-ends
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (understand ?character)
      (not (end ?character)))
    :effect
      (end ?character)
    :agents
      (?character)
  )
)