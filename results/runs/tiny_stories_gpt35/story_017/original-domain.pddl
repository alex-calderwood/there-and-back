(define (domain watching-tv)
  (:requirements :strips :typing :equality :negative-preconditions :intentionality)
  (:types character - object)
  (:predicates
    (watching-tv)
    (at ?character - character ?location - object)
    (rude ?character - character)
    (nice ?character - character)
    (crying ?character - character)
    (has-intention ?character - character ?intention - expression)
  )

  ;; A character moves to a location.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character starts watching TV.
  (:action start-watching-tv
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (not (watching-tv))
      (at ?character ?location)
      (not (has-intention ?character (not (watching-tv))))) ;; character must not have intention to not watch TV
    :effect
      (and (watching-tv)
      (not (has-intention ?character (not (watching-tv))))) ;; character cannot have intention to not watch TV
    :agents
      (?character)
  )

  ;; A character stops watching TV.
  (:action stop-watching-tv
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (watching-tv)
      (at ?character ?location)
      (not (has-intention ?character watching-tv))) ;; character must not have intention to watch TV
    :effect
      (and (not (watching-tv))
      (not (has-intention ?character watching-tv))) ;; character cannot have intention to watch TV
    :agents
      (?character)
  )

  ;; A character is rude to another character.
  (:action be-rude
    :parameters
      (?rude-character - character ?nice-character - character ?location - object)
    :precondition
      (and (watching-tv)
      (at ?rude-character ?location)
      (at ?nice-character ?location)
      (not (has-intention ?rude-character (not (rude ?rude-character))))) ;; character must not have intention to not be rude
    :effect
      (and (rude ?rude-character)
      (not (has-intention ?rude-character (not (rude ?rude-character)))))
    :agents
      (?rude-character)
  )

  ;; A character is nice to another character.
  (:action be-nice
    :parameters
      (?nice-character - character ?rude-character - character ?location - object)
    :precondition
      (and (watching-tv)
      (at ?nice-character ?location)
      (at ?rude-character ?location)
      (rude ?rude-character)
      (not (has-intention ?nice-character (not (nice ?nice-character))))) ;; character must not have intention to not be nice
    :effect
      (and (not (rude ?rude-character))
      (nice ?nice-character)
      (not (has-intention ?nice-character (not (nice ?nice-character))))
      (crying ?rude-character))
    :agents
      (?nice-character)
  )

  ;; A character stops crying.
  (:action stop-crying
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (crying ?character)
      (at ?character ?location)
      (not (has-intention ?character (not (crying ?character))))) ;; character must not have intention to not stop crying
    :effect
      (and (not (crying ?character))
      (not (has-intention ?character (not (crying ?character)))))
    :agents
      (?character)
  )
)