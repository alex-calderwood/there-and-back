(define (domain park-playtime)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at-park ?character - character)
    (on-swing ?character - character)
    (swinging ?character - character)
    (sharing ?character1 - character ?character2 - character)
    (happy ?character - character)
  )

  ;; A character goes to the park.
  (:action go-to-park
    :parameters
      (?character - character)
    :precondition
      (not (at-park ?character))
    :effect
      (at-park ?character)
    :agents
      (?character)
  )

  ;; A character gets on the swing.
  (:action get-on-swing
    :parameters
      (?character - character)
    :precondition
      (and (at-park ?character)
      (not (on-swing ?character)))
    :effect
      (on-swing ?character)
    :agents
      (?character)
  )

  ;; A character starts swinging.
  (:action start-swinging
    :parameters
      (?character - character)
    :precondition
      (and (on-swing ?character)
      (not (swinging ?character)))
    :effect
      (swinging ?character)
    :agents
      (?character)
  )

  ;; Two characters share the swing.
  (:action share-swing
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (swinging ?character1)
      (swinging ?character2))
    :effect
      (sharing ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character gets off the swing.
  (:action get-off-swing
    :parameters
      (?character - character)
    :precondition
      (and (on-swing ?character)
      (swinging ?character))
    :effect
      (and (not (on-swing ?character))
      (not (swinging ?character))
      (happy ?character))
    :agents
      (?character)
  )

  ;; Two characters thank each other.
  (:action thank
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (sharing ?character1 ?character2))
    :effect
      (happy ?character1)
    :agents
      (?character1 ?character2)
  )
)