(define (domain motorcycle-ride)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (riding ?character - character)
    (has ?character - character ?item - object)
    (demon ?character - character)
    (illuminated ?place - place)
    (speaks ?creature - object ?message - object)
    (trusts ?character - character ?creature - object)
    (relaxed ?character - character)
    (enveloped ?character - character)
    (lifted ?character - character)
    (going-to-heaven ?character - character)
    (going-to-hell ?character - character)
    (helped ?character - character)
  )

  ;; A character travels from one place to another on a motorcycle.
  (:action ride
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (riding ?character))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character acquires an item.
  (:action acquire
    :parameters
      (?character - character ?item - object ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (has ?character ?item)))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character speaks a message.
  (:action speak
    :parameters
      (?character - character ?creature - object ?message - object ?place - place)
    :precondition
      (and (at ?character ?place)
      (trusts ?character ?creature)
      (speaks ?creature ?message))
    :effect
      (speaks ?character ?message)
    :agents
      (?character)
  )

  ;; A character is enveloped and lifted.
  (:action envelop-lift
    :parameters
      (?character - character ?creature - object)
    :precondition
      (and (at ?character ?place)
      (trusts ?character ?creature))
    :effect
      (and (enveloped ?character)
      (lifted ?character))
    :agents
      (?character)
  )

  ;; A character is helped.
  (:action help
    :parameters
      (?character - character)
    :precondition
      (at ?character ?place)
    :effect
      (helped ?character)
    :agents
      (?character)
  )

  ;; A character is going to heaven.
  (:action go-to-heaven
    :parameters
      (?character - character)
    :precondition
      (and (at ?character ?place)
      (enveloped ?character))
    :effect
      (going-to-heaven ?character)
    :agents
      (?character)
  )

  ;; A character is going to hell.
  (:action go-to-hell
    :parameters
      (?character - character)
    :precondition
      (and (at ?character ?place)
      (enveloped ?character))
    :effect
      (going-to-hell ?character)
    :agents
      (?character)
  )

  ;; A character is relaxed.
  (:action relax
    :parameters
      (?character - character)
    :precondition
      (at ?character ?place)
    :effect
      (relaxed ?character)
    :agents
      (?character)
  )
)