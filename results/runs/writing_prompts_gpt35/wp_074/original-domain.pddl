(define (domain emotional-manipulation)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants
    mcInleys-cat - object)
  (:predicates
    (alive ?character - character)
    (close-to ?character - character)
    (hates ?character - character)
    (loves ?character - character)
    (manipulated ?character - character)
    (put-in-freezer ?character - character)
    (drowned ?character - character)
    (killed ?character - character)
    (intends ?character - character ?expression - expression)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (close-to ?character ?from))
    :effect
      (and (not (close-to ?character ?from))
      (close-to ?character ?to))
    :agents
      (?character)
  )

  ;; A character puts an object in the freezer.
  (:action put-in-freezer
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (close-to ?character ?object))
    :effect
      (put-in-freezer ?object)
    :agents
      (?character)
  )

  ;; A character drowns an object.
  (:action drown
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (close-to ?character ?object))
    :effect
      (drowned ?object)
    :agents
      (?character)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (close-to ?killer ?victim))
    :effect
      (and (not (alive ?victim))
      (killed ?victim))
    :agents
      (?killer)
  )

  ;; A character expresses their hatred for another character.
  (:action express-hate
    :parameters
      (?hater - character ?hated - character)
    :precondition
      (and (alive ?hater)
      (close-to ?hater ?hated))
    :effect
      (hates ?hated)
    :agents
      (?hater)
  )

  ;; A character expresses their love for another character.
  (:action express-love
    :parameters
      (?lover - character ?loved - character)
    :precondition
      (and (alive ?lover)
      (close-to ?lover ?loved))
    :effect
      (loves ?loved)
    :agents
      (?lover)
  )

  ;; A character manipulates another character.
  (:action manipulate
    :parameters
      (?manipulator - character ?manipulated - character)
    :precondition
      (and (alive ?manipulator)
      (close-to ?manipulator ?manipulated))
    :effect
      (manipulated ?manipulated)
    :agents
      (?manipulator)
  )

  ;; A character intends to perform an expression.
  (:action intend
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (alive ?character)
    :effect
      (intends ?character ?expression)
    :agents
      (?character)
  )

  ;; A character performs an expression.
  (:action perform-expression
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (and (alive ?character)
      ?expression)
    :effect
      (and ?expression
      (not (intends ?character ?expression)))
    :agents
      (?character)
  )

  ;; A character performs an expression and manipulates another character.
  (:action perform-expression-and-manipulate
    :parameters
      (?manipulator - character ?manipulated - character ?expression - expression)
    :precondition
      (and (alive ?manipulator)
      (alive ?manipulated)
      (close-to ?manipulator ?manipulated)
      ?expression)
    :effect
      (and ?expression
      (not (intends ?manipulator ?expression))
      (manipulated ?manipulated))
    :agents
      (?manipulator)
  )
)