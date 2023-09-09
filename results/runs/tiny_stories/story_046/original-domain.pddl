(define (domain spot-the-dog)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (impatient ?character - character)
    (has-ball ?character - character)
    (has-perfume ?character - character)
    (on-table ?object - object)
    (smells-nice ?character - character)
    (playing-with-ball ?character - character)
  )

  ;; A character tries to get an object from the table.
  (:action try-get
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (impatient ?character)
      (on-table ?object))
    :effect
      (and (not (on-table ?object))
      (has ?character ?object))
    :agents
      (?character)
  )

  ;; A character smells nice after getting the perfume.
  (:action smell-nice
    :parameters
      (?character - character)
    :precondition
      (has-perfume ?character)
    :effect
      (smells-nice ?character)
    :agents
      (?character)
  )

  ;; A character plays with their ball.
  (:action play-with-ball
    :parameters
      (?character - character)
    :precondition
      (has-ball ?character)
    :effect
      (playing-with-ball ?character)
    :agents
      (?character)
  )
)