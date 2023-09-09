(define (domain sue-and-cat)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object toy - object)
  (:predicates
    (at ?character - character ?place - place)
    (dark ?place - place)
    (under ?object1 - object ?object2 - object)
    (sad ?character - character)
    (lost ?character - character ?toy - toy)
    (found ?character - character ?toy - toy)
    (in ?toy - toy ?container - object)
    (open ?container - object)
    (happy ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character opens a container.
  (:action open-container
    :parameters
      (?character - character ?container - object)
    :precondition
      (and (at ?character (location ?container))
      (not (open ?container)))
    :effect
      (open ?container)
    :agents
      (?character)
  )

  ;; A character finds a toy.
  (:action find-toy
    :parameters
      (?character - character ?toy - toy ?container - object)
    :precondition
      (and (open ?container)
      (in ?toy ?container)
      (at ?character (location ?container))
      (lost ?character ?toy))
    :effect
      (and (found ?character ?toy)
      (not (lost ?character ?toy)))
    :agents
      (?character)
  )

  ;; A character cheers up another character.
  (:action cheer-up
    :parameters
      (?cheerer - character ?cheered - character)
    :precondition
      (and (not (= ?cheerer ?cheered))
      (sad ?cheered))
    :effect
      (happy ?cheered)
    :agents
      (?cheerer)
  )
)