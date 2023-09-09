(define (domain bill-clinton)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (is-president ?character - character)
    (is-bill ?character - character)
    (is-william-jefferson ?character - character)
    (is-john-james-smith ?character - character)
    (searching-for ?character - character ?target - character)
    (found ?character - character ?target - character)
  )

  ;; A character changes their identity.
  (:action change-identity
    :parameters
      (?character - character ?old-identity - character ?new-identity - character)
    :precondition
      (and (alive ?character)
      (is-?old-identity ?character))
    :effect
      (and (not (is-?old-identity ?character))
      (is-?new-identity ?character))
    :agents  (?character)
  )

  ;; A character searches for another character.
  (:action search
    :parameters
      (?searcher - character ?target - character)
    :precondition
      (and (alive ?searcher)
      (searching-for ?searcher ?target))
    :effect
      (found ?searcher ?target)
    :agents  (?searcher)
  )

  ;; Death kills a character.
  (:action kill
    :parameters
      (?victim - character)
    :precondition
      (alive ?victim)
    :effect
      (not (alive ?victim))
    :agents  (death)
  )
)