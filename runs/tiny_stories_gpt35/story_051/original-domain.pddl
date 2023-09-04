(define (domain magical-tree)
  (:requirements :adl :expression-variables :intentionality)
  (:types character animal - object)
  (:constants tree - object)
  (:predicates
    (inside ?character - character ?object - object)
    (happy ?animal - animal)
    (friendly ?animal - animal)
    (hugged ?animal - animal)
    (visited ?character - character)
  )

  ;; A character moves from one object to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (inside ?character ?from)
      (not (inside ?character ?to)))
    :effect
      (and (not (inside ?character ?from))
      (inside ?character ?to))
    :agents
      (?character)
  )

  ;; A character hugs an animal.
  (:action hug
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (and (inside ?character tree)
      (inside ?animal tree)
      (friendly ?animal)
      (not (hugged ?animal)))
    :effect
      (and (hugged ?animal))
    :agents
      (?character)
  )

  ;; A character leaves the tree.
  (:action leave-tree
    :parameters
      (?character - character)
    :precondition
      (inside ?character tree)
    :effect
      (and (not (inside ?character tree))
      (visited ?character))
    :agents
      (?character)
  )

  ;; A character intends to visit the tree again.
  (:action intend-to-visit
    :parameters
      (?character - character)
    :precondition
      (visited ?character)
    :effect
      (and (not (visited ?character)))
    :agents
      (?character)
  )

  ;; An animal becomes happy when hugged.
  (:axiom
    :vars
      (?animal - animal)
    :context
      (hugged ?animal)
    :implies
      (happy ?animal)
  )
)