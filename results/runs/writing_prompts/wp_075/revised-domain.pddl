(define (domain state-of-the-union)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character organization - object)
  (:predicates
    (president ?character - character)
    (speaker ?character - character)
    (vice-president ?character - character)
    (belongs-to ?character - character ?organization - organization)
    (economy-collapsed)
    (real-estate-monopoly)
    (planned-parenthood-defunded)
    (planned-parenthood-shutdown)
    (planned-parenthood-criminalized)
    (prison-population-increased)
    (political-prisoner ?character - character)
  )

  ;; The president announces the state of the union.
  (:action announce-state-of-the-union
    :parameters
      (?president - character)
    :precondition
      (president ?president)
    :effect
      (and)
    :agents
      (?president)
  )

  ;; The speaker introduces the president.
  (:action introduce-president
    :parameters
      (?speaker - character ?president - character)
    :precondition
      (and (speaker ?speaker)
      (president ?president))
    :effect
      (and)
    :agents
      (?speaker)
  )

  ;; The vice-president attends the state of the union.
  (:action attend-state-of-the-union
    :parameters
      (?vice-president - character)
    :precondition
      (vice-president ?vice-president)
    :effect
      (and)
    :agents
      (?vice-president)
  )
)