(define (domain bill-and-narrator)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (influenced ?character - character)
    (isolated ?character - character)
    (hates ?character1 - character ?character2 - character)
    (manipulates ?character1 - character ?character2 - character)
    (despises ?character1 - character ?character2 - character)
    (apologizes ?character - character)
  )

  ;; A character influences another character.
  (:action influence
    :parameters
      (?influencer - character ?influenced - character)
    :precondition
      (and (not (= ?influencer ?influenced))
      (not (influenced ?influenced)))
    :effect
      (influenced ?influenced)
    :agents
      (?influencer)
  )

  ;; A character isolates another character.
  (:action isolate
    :parameters
      (?isolator - character ?isolated - character)
    :precondition
      (and (not (= ?isolator ?isolated))
      (not (isolated ?isolated)))
    :effect
      (isolated ?isolated)
    :agents
      (?isolator)
  )

  ;; A character manipulates another character.
  (:action manipulate
    :parameters
      (?manipulator - character ?manipulated - character)
    :precondition
      (and (not (= ?manipulator ?manipulated))
      (not (manipulates ?manipulator ?manipulated)))
    :effect
      (manipulates ?manipulator ?manipulated)
    :agents
      (?manipulator)
  )

  ;; A character hates another character.
  (:action hate
    :parameters
      (?hater - character ?hated - character)
    :precondition
      (and (not (= ?hater ?hated))
      (not (hates ?hater ?hated)))
    :effect
      (hates ?hater ?hated)
    :agents
      (?hater)
  )

  ;; A character despises another character.
  (:action despise
    :parameters
      (?despiser - character ?despised - character)
    :precondition
      (and (not (= ?despiser ?despised))
      (not (despises ?despiser ?despised)))
    :effect
      (despises ?despiser ?despised)
    :agents
      (?despiser)
  )

  ;; A character apologizes to another character.
  (:action apologize
    :parameters
      (?apologizer - character ?apologized - character)
    :precondition
      (and (not (= ?apologizer ?apologized))
      (not (apologizes ?apologizer ?apologized)))
    :effect
      (apologizes ?apologizer ?apologized)
    :agents
      (?apologizer)
  )
)