(define (domain poem-life)
  (:requirements :adl :domain-axioms :intentionality)
  (:types reader poem - object)
  (:predicates
    (read ?reader - reader ?poem - poem)
    (alive ?poem - poem)
    (dead ?poem - poem)
    (echo ?reader - reader ?poem - poem)
  )

  ;; A reader reads a poem.
  (:action read-poem
    :parameters
      (?reader - reader ?poem - poem)
    :precondition
      (and (not (read ?reader ?poem))
      (alive ?poem))
    :effect
      (and (read ?reader ?poem)
      (echo ?reader ?poem))
    :agents
      (?reader)
  )

  ;; A poem dies.
  (:action poem-dies
    :parameters
      (?poem - poem)
    :precondition
      (alive ?poem)
    :effect
      (and (not (alive ?poem))
      (dead ?poem))
  )

  ;; A poem is echoed by a reader.
  (:action echo-poem
    :parameters
      (?reader - reader ?poem - poem)
    :precondition
      (and (read ?reader ?poem)
      (not (echo ?reader ?poem)))
    :effect
      (echo ?reader ?poem)
    :agents
      (?reader)
  )
)