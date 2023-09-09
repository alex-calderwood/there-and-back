(define (domain greek-lovers)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (lover ?character - character)
    (mother ?character - character)
    (male ?character - character)
    (female ?character - character)
    (traveling ?character - character)
    (at ?character - character ?place - place)
    (ill ?character - character)
    (separated ?character - character)
    (accepted ?character - character)
    (family ?character - character)
    (sentimental ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (not (traveling ?character)))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to)
      (traveling ?character))
    :agents  (?character)
  )

  ;; A character lies about being ill.
  (:action lie-ill
    :parameters
      (?character - character)
    :precondition
      (and (not (ill ?character))
      (lover ?character ?lover)
      (not (accepted ?lover))
      (not (sentimental ?character)))
    :effect
      (ill ?character)
    :agents
      (?character)
  )

  ;; A character is accepted by their lover's family.
  (:action accept
    :parameters
      (?character - character ?lover - character)
    :precondition
      (and (lover ?lover ?character)
      (not (accepted ?character))
      (family ?lover ?character))
    :effect
      (accepted ?character)
    :agents
      (?lover)
  )

  ;; A character is separated from their child.
  (:action separate
    :parameters
      (?character - character ?child - character)
    :precondition
      (and (lover ?character ?child)
      (male ?child)
      (not (separated ?child)))
    :effect
      (separated ?child)
    :agents
      (?character)
  )

  ;; A character leaves their child at the gates.
  (:action leave-child
    :parameters
      (?character - character ?child - character)
    :precondition
      (and (separated ?child)
      (at ?character ?place)
      (not (at ?child ?place)))
    :effect
      (not (at ?child ?place))
    :agents
      (?character)
  )

  ;; A character takes care of their child.
  (:action take-care
    :parameters
      (?character - character ?child - character)
    :precondition
      (and (lover ?character ?child)
      (female ?character)
      (not (separated ?child))
      (at ?character ?place)
      (not (at ?child ?place)))
    :effect
      (at ?child ?place)
    :agents
      (?character)
  )
)