(define (domain light-power)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object lightbox - item)
  (:predicates
    (has ?character - character ?item - item)
    (anchored ?light - lightbox)
    (charged ?light - lightbox)
    (created ?character - character ?light - lightbox)
    (used ?character - character ?light - lightbox)
  )

  ;; A character creates a lightbox.
  (:action create-lightbox
    :parameters
      (?character - character ?lightbox - lightbox)
    :precondition
      (alive ?character)
    :effect
      (and (created ?character ?lightbox)
      (has ?character ?lightbox))
    :agents
      (?character)
  )

  ;; A character anchors a lightbox.
  (:action anchor-light
    :parameters
      (?character - character ?lightbox - lightbox)
    :precondition
      (and (alive ?character)
      (created ?character ?lightbox)
      (has ?character ?lightbox))
    :effect
      (anchored ?lightbox)
    :agents
      (?character)
  )

  ;; A character charges a lightbox.
  (:action charge-lightbox
    :parameters
      (?character - character ?lightbox - lightbox)
    :precondition
      (and (alive ?character)
      (anchored ?lightbox)
      (created ?character ?lightbox))
    :effect
      (charged ?lightbox)
    :agents
      (?character)
  )

  ;; A character uses a charged lightbox.
  (:action use-lightbox
    :parameters
      (?character - character ?lightbox - lightbox)
    :precondition
      (and (alive ?character)
      (charged ?lightbox)
      (created ?character ?lightbox)
      (has ?character ?lightbox))
    :effect
      (and (used ?character ?lightbox)
      (not (charged ?lightbox)))
    :agents
      (?character)
  )
)