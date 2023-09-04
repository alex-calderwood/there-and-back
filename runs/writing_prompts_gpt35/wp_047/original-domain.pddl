(define (domain end-of-the-world)
  (:requirements :adl :domain-axioms)
  (:types idea - object)
  (:predicates
    (discovered ?idea - idea)
    (shared ?idea - idea)
    (valued ?idea - idea)
    (explored ?idea - idea)
    (cut-off ?idea - idea)
    (left-behind ?idea - idea)
  )

  ;; A group of people share an idea.
  (:action share-idea
    :parameters
      (?group - object ?idea - idea)
    :precondition
      (and (not (cut-off ?idea))
      (not (left-behind ?idea)))
    :effect
      (and (shared ?idea)
      (forall (?member - object)
      (when (not (= ?member ?group))
      (shared ?idea))))
    :agents
      (?group)
  )

  ;; An idea is discovered.
  (:action discover-idea
    :parameters
      (?idea - idea)
    :precondition
      (not (discovered ?idea))
    :effect
      (discovered ?idea)
  )

  ;; An idea is valued.
  (:action value-idea
    :parameters
      (?idea - idea)
    :precondition
      (and (discovered ?idea)
      (not (valued ?idea))))
    :effect
      (valued ?idea)
  )

  ;; An idea is explored.
  (:action explore-idea
    :parameters
      (?idea - idea)
    :precondition
      (and (discovered ?idea)
      (valued ?idea)
      (not (explored ?idea))))
    :effect
      (explored ?idea)
  )

  ;; An idea is cut off.
  (:action cut-off-idea
    :parameters
      (?idea - idea)
    :precondition
      (and (discovered ?idea)
      (valued ?idea)
      (not (cut-off ?idea))))
    :effect
      (cut-off ?idea)
  )

  ;; An idea is left behind.
  (:action leave-behind-idea
    :parameters
      (?idea - idea)
    :precondition
      (and (discovered ?idea)
      (valued ?idea)
      (not (left-behind ?idea))))
    :effect
      (left-behind ?idea)
  )
)