(define (domain new-granada-empire)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character nation - object)
  (:predicates
    (alive ?character - character)
    (ruler ?character - character ?nation - nation)
    (capital ?nation - nation ?place - object)
    (at-war ?nation1 - nation ?nation2 - nation)
    (navy-defeated ?nation1 - nation ?nation2 - nation)
    (settled ?nation - nation ?place - object)
    (built ?character - character ?structure - object ?place - object)
    (trading ?nation - nation)
    (plantation ?nation - nation ?place - object)
    (farm-estate ?nation - nation ?place - object)
    (slave-trade ?nation - nation)
  )

  ;; A character becomes the ruler of a nation.
  (:action become-ruler
    :parameters
      (?character - character ?nation - nation)
    :precondition
      (alive ?character)
    :effect
      (ruler ?character ?nation)
    :agents
      (?character)
  )

  ;; A nation declares war on another nation.
  (:action declare-war
    :parameters
      (?nation1 - nation ?nation2 - nation)
    :precondition
      (not (= ?nation1 ?nation2))
    :effect
      (at-war ?nation1 ?nation2)
    :agents
      (?nation1)
  )

  ;; A nation defeats another nation's navy.
  (:action defeat-navy
    :parameters
      (?nation1 - nation ?nation2 - nation)
    :precondition
      (and (not (= ?nation1 ?nation2))
      (at-war ?nation1 ?nation2))
    :effect
      (navy-defeated ?nation1 ?nation2)
    :agents
      (?nation1)
  )

  ;; A nation settles a new place.
  (:action settle
    :parameters
      (?nation - nation ?place - object)
    :effect
      (settled ?nation ?place)
    :agents
      (?nation)
  )

  ;; A character builds a structure in a place.
  (:action build
    :parameters
      (?character - character ?structure - object ?place - object)
    :precondition
      (alive ?character)
    :effect
      (built ?character ?structure ?place)
    :agents
      (?character)
  )

  ;; A nation establishes a trading system.
  (:action establish-trading
    :parameters
      (?nation - nation)
    :effect
      (trading ?nation)
    :agents
      (?nation)
  )

  ;; A nation establishes a plantation in a place.
  (:action establish-plantation
    :parameters
      (?nation - nation ?place - object)
    :effect
      (plantation ?nation ?place)
    :agents
      (?nation)
  )

  ;; A nation establishes a farm estate in a place.
  (:action establish-farm-estate
    :parameters
      (?nation - nation ?place - object)
    :effect
      (farm-estate ?nation ?place)
    :agents
      (?nation)
  )

  ;; A nation engages in the slave trade.
  (:action engage-slave-trade
    :parameters
      (?nation - nation)
    :effect
      (slave-trade ?nation)
    :agents
      (?nation)
  )
)