(define (domain ant-and-bird)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (in-tree ?character - character)
    (wants-to-eat ?character - character ?object - object)
    (hard ?object - object)
    (broken ?object - object)
    (eaten ?object - object)
    (helping ?helper - character ?helpee - character)
  )

  ;; A character climbs a tree.
  (:action climb-tree
    :parameters
      (?character - character)
    :precondition
      (not (in-tree ?character))
    :effect
      (in-tree ?character)
    :agents
      (?character)
  )

  ;; A character wants to eat an object.
  (:action want-to-eat
    :parameters
      (?character - character ?object - object)
    :effect
      (wants-to-eat ?character ?object)
    :agents
      (?character)
  )

  ;; A character tries to eat an object but fails.
  (:action try-to-eat
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (wants-to-eat ?character ?object)
      (hard ?object))
    :effect
      (not (eaten ?object))
    :agents
      (?character)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :effect
      (helping ?helper ?helpee)
    :agents
      (?helper)
  )

  ;; A character breaks an object.
  (:action break-object
    :parameters
      (?character - character ?object - object ?helpee - character)
    :precondition
      (and (hard ?object)
      (helping ?character ?helpee))
    :effect
      (broken ?object)
    :agents
      (?character)
  )

  ;; Characters eat an object together.
  (:action eat-together
    :parameters
      (?character1 - character ?character2 - character ?object - object)
    :precondition
      (and (broken ?object)
      (helping ?character1 ?character2))
    :effect
      (eaten ?object)
    :agents
      (?character1 ?character2)
  )
)