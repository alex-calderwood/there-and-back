(define (domain prank-message)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (pranked ?pranker - character ?target - character)
  )

  (:action prank
    :parameters
      (?pranker - character ?target - character)
    :effect
      (pranked ?pranker ?target)
    :agents
      (?pranker)
  )
)