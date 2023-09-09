(define (domain conquistadors-elder-gods)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (land-nearby ?place - place)
    (spotted-vegetation ?character - character)
    (spotted-bird ?character - character)
    (prepared-for-landing ?character - character)
    (landed ?character - character)
    (converted ?character - character)
  )

  ;; A character spots a bird.
  (:action spot-bird
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (spotted-bird ?character)))
    :effect
      (spotted-bird ?character)
    :agents
      (?character)
  )

  ;; A character spots vegetation.
  (:action spot-vegetation
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (spotted-vegetation ?character)))
    :effect
      (spotted-vegetation ?character)
    :agents
      (?character)
  )

  ;; A character prepares for landing.
  (:action prepare-for-landing
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (land-nearby ?place)
      (spotted-bird ?character)
      (spotted-vegetation ?character))
    :effect
      (prepared-for-landing ?character)
    :agents
      (?character)
  )

  ;; A character lands on the shore.
  (:action land
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (prepared-for-landing ?character))
    :effect
      (landed ?character)
    :agents
      (?character)
  )

  ;; A character converts another character.
  (:action convert
    :parameters
      (?converter - character ?convert - character)
    :precondition
      (and (alive ?converter)
      (landed ?converter)
      (alive ?convert)
      (not (converted ?convert)))
    :effect
      (converted ?convert)
    :agents
      (?converter)
  )
)