(define (domain magician-show)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (performing ?character - character)
    (applause)
    (satisfied ?character - character)
    (disappeared ?character - character)
    (trick-performed)
  )

  ;; A character performs a magic show.
  (:action perform-show
    :parameters
      (?magician - character)
    :precondition
      (not (performing ?magician))
    :effect
      (and (performing ?magician)
           (applause))
    :agents
      (?magician)
  )

  ;; A character performs the final trick.
  (:action perform-final-trick
    :parameters
      (?magician - character)
    :precondition
      (and (performing ?magician)
           (not (trick-performed)))
    :effect
      (and (trick-performed)
           (disappeared ?magician))
    :agents
      (?magician)
  )

  ;; A character becomes satisfied.
  (:action become-satisfied
    :parameters
      (?character - character)
    :precondition
      (and (performing ?character)
           (trick-performed)
           (applause)
           (not (satisfied ?character)))
    :effect
      (satisfied ?character)
    :agents
      (?character)
  )

  ;; The applause stops.
  (:action stop-applause
    :precondition
      (applause)
    :effect
      (not (applause))
  )
)