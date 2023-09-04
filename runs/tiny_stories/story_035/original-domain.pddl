(define (domain tim-and-the-box)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (birthday ?character - character)
    (box-closed)
    (box-open)
    (cake-spoiled)
    (cake-good)
    (listened-to-mom ?character - character)
    (waited-for-birthday ?character - character)
  )

  ;; A character waits for their birthday.
  (:action wait-for-birthday
    :parameters
      (?character - character)
    :precondition
      (and (not (birthday ?character))
      (not (waited-for-birthday ?character)))
    :effect
      (waited-for-birthday ?character)
    :agents
      (?character)
  )

  ;; A character listens to their mom.
  (:action listen-to-mom
    :parameters
      (?character - character)
    :precondition
      (and (not (listened-to-mom ?character))
      (waited-for-birthday ?character))
    :effect
      (listened-to-mom ?character)
    :agents
      (?character)
  )

  ;; A character opens the box.
  (:action open-box
    :parameters
      (?character - character)
    :precondition
      (and (box-closed)
      (birthday ?character))
    :effect
      (and (not (box-closed))
      (box-open))
    :agents
      (?character)
  )

  ;; The cake becomes spoiled.
  (:action spoil-cake
    :precondition
      (and (box-open)
      (not (listened-to-mom tim))
      (cake-good))
    :effect
      (and (not (cake-good))
      (cake-spoiled))
  )

  ;; The cake remains good.
  (:action keep-cake-good
    :precondition
      (and (box-open)
      (listened-to-mom tim)
      (cake-good))
    :effect
      (cake-good)
  )
)