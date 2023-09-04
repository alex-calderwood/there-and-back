(define (domain spot-and-fluffy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (playing-with-toys ?character - character)
    (found-blocks ?character - character)
    (stacking-blocks ?character - character)
    (stack-tall ?character - character)
    (stack-strong ?character - character)
    (happy ?character - character)
    (helping ?helper - character ?helpee - character)
  )

  ;; A character starts playing with toys.
  (:action play-with-toys
    :parameters
      (?character - character)
    :effect
      (playing-with-toys ?character)
    :agents
      (?character)
  )

  ;; A character finds blocks.
  (:action find-blocks
    :parameters
      (?character - character)
    :precondition
      (playing-with-toys ?character)
    :effect
      (found-blocks ?character)
    :agents
      (?character)
  )

  ;; A character starts stacking blocks.
  (:action stack-blocks
    :parameters
      (?character - character)
    :precondition
      (found-blocks ?character)
    :effect
      (stacking-blocks ?character)
    :agents
      (?character)
  )

  ;; A character makes the stack tall.
  (:action make-stack-tall
    :parameters
      (?character - character)
    :precondition
      (stacking-blocks ?character)
    :effect
      (stack-tall ?character)
    :agents
      (?character)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :precondition
      (and (not (= ?helper ?helpee))
      (stack-tall ?helpee))
    :effect
      (helping ?helper ?helpee)
    :agents
      (?helper)
  )

  ;; A character makes the stack strong.
  (:action make-stack-strong
    :parameters
      (?character - character)
    :precondition
      (and (stack-tall ?character)
      (helping ?character ?character))
    :effect
      (stack-strong ?character)
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (stack-strong ?character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )
)