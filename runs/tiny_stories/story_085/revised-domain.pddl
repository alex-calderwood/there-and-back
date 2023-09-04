(define (domain tea-party)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object item - object)
  (:predicates
    (broken ?item - item)
    (has ?character - character ?item - item)
    (playing ?character - character ?item - item)
    (apologized ?apologizer - character ?apologizee - character)
    (cleaned ?character - character)
    (forgiven ?forgiver - character ?forgivee - character)
  )

  ;; A character plays with an item.
  (:action play
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (not (broken ?item))
      (has ?character ?item))
    :effect
      (playing ?character ?item)
    :agents
      (?character)
  )

  ;; A character breaks an item.
  (:action break-item
    :parameters
      (?breaker - character ?item - item)
    :precondition
      (and (not (broken ?item))
      (playing ?breaker ?item))
    :effect
      (broken ?item)
    :agents
      (?breaker)
  )

  ;; A character apologizes to another.
  (:action apologize
    :parameters
      (?apologizer - character ?apologizee - character)
    :precondition
      (not (= ?apologizer ?apologizee))
    :effect
      (apologized ?apologizer ?apologizee)
    :agents
      (?apologizer)
  )

  ;; A character cleans up a mess.
  (:action clean
    :parameters
      (?cleaner - character ?item - item)
    :precondition
      (broken ?item)
    :effect
      (cleaned ?cleaner)
    :agents
      (?cleaner)
  )

  ;; A character forgives another.
  (:action forgive
    :parameters
      (?forgiver - character ?forgivee - character)
    :precondition
      (and (not (= ?forgiver ?forgivee))
      (apologized ?forgivee ?forgiver))
    :effect
      (forgiven ?forgiver ?forgivee)
    :agents
      (?forgiver)
  )
)