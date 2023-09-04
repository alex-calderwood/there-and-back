(define (domain cat-dog-wrap)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object item - object)
  (:predicates
    (has ?character - character ?item - item)
    (friends ?character1 - character ?character2 - character)
    (clean ?item - item)
    (steal-intention ?character - character ?item - item)
  )

  ;; A character apologizes to another character.
  (:action apologize
    :parameters
      (?apologizer - character ?apologized - character)
    :precondition
      (and (not (= ?apologizer ?apologized))
      (not (friends ?apologizer ?apologized)))
    :effect
      (friends ?apologizer ?apologized)
    :agents
      (?apologizer)
  )

  ;; A character tries to steal an item from another character.
  (:action try-steal
    :parameters
      (?stealer - character ?item - item ?owner - character)
    :precondition
      (and (not (= ?stealer ?owner))
      (has ?owner ?item)
      (steal-intention ?stealer ?item))
    :effect
      (and (not (steal-intention ?stealer ?item))
      (not (friends ?stealer ?owner)))
    :agents
      (?stealer)
  )

  ;; A character cleans an item.
  (:action clean-item
    :parameters
      (?cleaner - character ?item - item)
    :precondition
      (and (not (clean ?item))
      (has ?cleaner ?item))
    :effect
      (clean ?item)
    :agents
      (?cleaner)
  )

  ;; A character drops an item into a puddle.
  (:action drop-in-puddle
    :parameters
      (?dropper - character ?item - item)
    :precondition
      (and (has ?dropper ?item)
      (clean ?item))
    :effect
      (not (clean ?item))
    :agents
      (?dropper)
  )
)