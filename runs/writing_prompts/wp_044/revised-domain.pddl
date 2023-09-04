(define (domain longevity-serum)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (imprisoned ?character - character)
    (served-sentence ?character - character)
    (has-serum ?character - character)
    (religious ?character - character)
  )

  ;; A character takes the serum.
  (:action take-serum
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (has-serum ?character)))
    :effect
      (has-serum ?character)
    :agents
      (?character)
  )

  ;; A character serves their sentence.
  (:action serve-sentence
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (imprisoned ?character)
      (not (served-sentence ?character)))
    :effect
      (served-sentence ?character)
    :agents
      (?character)
  )

  ;; A character is released from prison.
  (:action release
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (imprisoned ?character)
      (served-sentence ?character))
    :effect
      (not (imprisoned ?character))
    :agents
      (?character)
  )

  ;; A character converts to religion.
  (:action convert
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (religious ?character)))
    :effect
      (religious ?character)
    :agents
      (?character)
  )

  ;; A character abandons religion.
  (:action abandon-religion
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (religious ?character))
    :effect
      (not (religious ?character))
    :agents
      (?character)
  )
)