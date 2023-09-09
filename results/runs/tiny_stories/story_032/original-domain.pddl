(define (domain volcano-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (laughing-at ?laugher - character ?target - character)
    (angry ?character - character)
    (apologized ?apologizer - character ?target - character)
    (learned-lesson ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
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

  ;; A character laughs at another character.
  (:action laugh-at
    :parameters
      (?laugher - character ?target - character)
    :precondition
      (and (not (laughing-at ?laugher ?target))
      (not (= ?laugher ?target)))
    :effect
      (laughing-at ?laugher ?target)
    :agents
      (?laugher)
  )

  ;; A character gets angry at another character.
  (:action get-angry
    :parameters
      (?angry-character - character ?target - character)
    :precondition
      (and (not (angry ?angry-character))
      (laughing-at ?target ?angry-character))
    :effect
      (angry ?angry-character)
    :agents
      (?angry-character)
  )

  ;; A character apologizes to another character.
  (:action apologize
    :parameters
      (?apologizer - character ?target - character)
    :precondition
      (and (not (apologized ?apologizer ?target))
      (angry ?target))
    :effect
      (and (apologized ?apologizer ?target)
      (not (angry ?target)))
    :agents
      (?apologizer)
  )

  ;; A character learns a lesson.
  (:action learn-lesson
    :parameters
      (?character - character)
    :precondition
      (not (learned-lesson ?character))
    :effect
      (learned-lesson ?character)
    :agents
      (?character)
  )
)