(define (domain tim-penny-candy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character store - object item - object)
  (:predicates
    (has ?character - character ?item - item)
    (at ?character - character ?store - store)
    (accepts ?store - store ?item - item)
    (special ?item - item)
    (happy ?character - character)
    (succeeded ?character - character)
  )

  ;; A character goes to a store.
  (:action go-to-store
    :parameters
      (?character - character ?store - store)
    :precondition
      (not (at ?character ?store))
    :effect
      (at ?character ?store)
    :agents
      (?character)
  )

  ;; A character buys an item with another item.
  (:action buy
    :parameters
      (?buyer - character ?item1 - item ?item2 - item ?store - store)
    :precondition
      (and (at ?buyer ?store)
      (has ?buyer ?item1)
      (accepts ?store ?item1))
    :effect
      (and (not (has ?buyer ?item1))
      (has ?buyer ?item2))
    :agents
      (?buyer)
  )

  ;; A character exchanges items with another character.
  (:action exchange
    :parameters
      (?giver - character ?item1 - item ?receiver - character ?item2 - item ?store - store)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver ?store)
      (has ?giver ?item1)
      (at ?receiver ?store)
      (has ?receiver ?item2))
    :effect
      (and (not (has ?giver ?item1))
      (has ?giver ?item2)
      (not (has ?receiver ?item2))
      (has ?receiver ?item1))
    :agents
      (?giver ?receiver)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character succeeds.
  (:action succeed
    :parameters
      (?character - character)
    :effect
      (succeeded ?character)
    :agents
      (?character)
  )
)