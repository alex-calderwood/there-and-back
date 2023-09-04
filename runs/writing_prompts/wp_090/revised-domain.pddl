(define (domain presidential-election)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (famous ?character - character)
    (wears-earmuffs ?character - character)
    (filled-with-ice ?character - character)
    (candidate ?character - character)
    (president ?character - character)
    (endured-pain ?character - character)
  )

  ;; A character becomes famous.
  (:action become-famous
    :parameters
      (?character - character)
    :precondition
      (not (famous ?character))
    :effect
      (famous ?character)
    :agents
      (?character)
  )

  ;; A character wears earmuffs.
  (:action wear-earmuffs
    :parameters
      (?character - character)
    :precondition
      (and (famous ?character)
      (not (wears-earmuffs ?character)))
    :effect
      (wears-earmuffs ?character)
    :agents
      (?character)
  )

  ;; A character fills earmuffs with ice.
  (:action fill-earmuffs-with-ice
    :parameters
      (?character - character)
    :precondition
      (and (famous ?character)
      (wears-earmuffs ?character)
      (not (filled-with-ice ?character)))
    :effect
      (filled-with-ice ?character)
    :agents
      (?character)
  )

  ;; A character becomes a candidate.
  (:action become-candidate
    :parameters
      (?character - character)
    :precondition
      (and (famous ?character)
      (not (candidate ?character)))
    :effect
      (candidate ?character)
    :agents
      (?character)
  )

  ;; A character becomes president.
  (:action become-president
    :parameters
      (?character - character)
    :precondition
      (and (candidate ?character)
      (not (president ?character)))
    :effect
      (president ?character)
    :agents
      (?character)
  )

  ;; A character endures pain.
  (:action endure-pain
    :parameters
      (?character - character)
    :precondition
      (and (famous ?character)
      (filled-with-ice ?character)
      (not (endured-pain ?character)))
    :effect
      (endured-pain ?character)
    :agents
      (?character)
  )
)