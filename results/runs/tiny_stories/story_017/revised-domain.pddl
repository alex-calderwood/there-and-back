(define (domain tv-sharing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (watches-tv ?character - character)
    (happy ?character - character)
    (rude ?character - character)
    (nice ?character - character)
    (wants-to-watch-tv ?character - character)
  )

  ;; A character starts watching TV.
  (:action start-watching-tv
    :parameters
      (?character - character)
    :precondition
      (wants-to-watch-tv ?character)
    :effect
      (watches-tv ?character)
    :agents
      (?character)
  )

  ;; A character stops watching TV.
  (:action stop-watching-tv
    :parameters
      (?character - character)
    :precondition
      (watches-tv ?character)
    :effect
      (not (watches-tv ?character))
    :agents
      (?character)
  )

  ;; A character becomes nice.
  (:action become-nice
    :parameters
      (?character - character)
    :precondition
      (rude ?character)
    :effect
      (and (not (rude ?character))
      (nice ?character))
    :agents
      (?character)
  )

  ;; A character becomes rude.
  (:action become-rude
    :parameters
      (?character - character)
    :precondition
      (nice ?character)
    :effect
      (and (not (nice ?character))
      (rude ?character))
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes unhappy.
  (:action become-unhappy
    :parameters
      (?character - character)
    :precondition
      (happy ?character)
    :effect
      (not (happy ?character))
    :agents
      (?character)
  )
)