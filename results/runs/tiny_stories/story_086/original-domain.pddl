(define (domain mixy-and-mommy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (helping ?helper - character ?helpee - character)
    (scared ?character - character)
    (spider-on-wall)
    (happy ?character - character)
    (cake-made)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :precondition
      (and (not (= ?helper ?helpee))
      (scared ?helpee))
    :effect
      (and (not (scared ?helpee))
      (happy ?helpee)
      (helping ?helper ?helpee))
    :agents
      (?helper)
  )

  ;; A character makes a cake.
  (:action make-cake
    :parameters
      (?character - character)
    :precondition
      (and (not (cake-made))
      (happy ?character))
    :effect
      (cake-made)
    :agents
      (?character)
  )

  ;; A character sees a spider on the wall.
  (:action see-spider
    :parameters
      (?character - character)
    :precondition
      (and (not (scared ?character))
      (not (spider-on-wall)))
    :effect
      (and (scared ?character)
      (spider-on-wall))
    :agents
      (?character)
  )

  ;; A character removes the spider from the wall.
  (:action remove-spider
    :parameters
      (?character - character)
    :precondition
      (and (spider-on-wall)
      (helping ?character ?helpee - character))
    :effect
      (not (spider-on-wall))
    :agents
      (?character)
  )
)