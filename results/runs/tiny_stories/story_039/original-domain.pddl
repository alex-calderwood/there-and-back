(define (domain tim-and-cap)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object cap - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?cap - cap)
    (lost ?character - character ?cap - cap)
    (searched ?character - character ?place - place)
    (found ?character - character ?cap - cap)
  )

  ;; A character searches for a cap in a place.
  (:action search
    :parameters
      (?character - character ?cap - cap ?place - place)
    :precondition
      (and (at ?character ?place)
      (lost ?character ?cap))
    :effect
      (searched ?character ?place)
    :agents
      (?character)
  )

  ;; A character finds a cap.
  (:action find
    :parameters
      (?character - character ?cap - cap)
    :precondition
      (and (lost ?character ?cap)
      (forall (?place - place)
      (searched ?character ?place)))
    :effect
      (and (found ?character ?cap)
      (not (lost ?character ?cap))
      (has ?character ?cap))
    :agents
      (?character)
  )

  ;; A character loses a cap.
  (:action lose
    :parameters
      (?character - character ?cap - cap)
    :precondition
      (has ?character ?cap)
    :effect
      (and (lost ?character ?cap)
      (not (has ?character ?cap)))
    :agents
      (?character)
  )

  ;; A character replaces a cap with another cap.
  (:action replace
    :parameters
      (?character - character ?old-cap - cap ?new-cap - cap)
    :precondition
      (and (found ?character ?old-cap)
      (not (has ?character ?old-cap))
      (has ?character ?new-cap))
    :effect
      (and (not (found ?character ?old-cap))
      (has ?character ?old-cap)
      (not (has ?character ?new-cap)))
    :agents
      (?character)
  )
)