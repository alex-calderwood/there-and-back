(define (domain prank-message)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (appalled ?character - character)
    (worked-at ?character - character)
    (mailed ?character - character)
    (read ?character - character)
    (told ?character - character)
    (called-police ?character - character)
    (talked-public ?character - character)
    (shot-up-drugs ?character - character)
    (let-walls-down ?character - character)
    (back-stabbed ?character - character)
    (insulted ?character - character)
    (found-attorney ?character - character)
    (turned-up ?character - character)
    (around-bend ?character - character)
    (deserted-attitude ?character - character)
    (took-seriously ?character - character)
    (pranked ?character - character)
  )

  (:action appalled
    :parameters
      (?character - character)
    :effect
      (appalled ?character)
    :agents
      (?character)
  )

  (:action worked-at
    :parameters
      (?character - character)
    :effect
      (worked-at ?character)
    :agents
      (?character)
  )

  (:action mailed
    :parameters
      (?character - character)
    :effect
      (mailed ?character)
    :agents
      (?character)
  )

  (:action read
    :parameters
      (?character - character)
    :effect
      (read ?character)
    :agents
      (?character)
  )

  (:action told
    :parameters
      (?character - character)
    :effect
      (told ?character)
    :agents
      (?character)
  )

  (:action called-police
    :parameters
      (?character - character)
    :effect
      (called-police ?character)
    :agents
      (?character)
  )

  (:action talked-public
    :parameters
      (?character - character)
    :effect
      (talked-public ?character)
    :agents
      (?character)
  )

  (:action shot-up-drugs
    :parameters
      (?character - character)
    :effect
      (shot-up-drugs ?character)
    :agents
      (?character)
  )

  (:action let-walls-down
    :parameters
      (?character - character)
    :effect
      (let-walls-down ?character)
    :agents
      (?character)
  )

  (:action back-stabbed
    :parameters
      (?character - character)
    :effect
      (back-stabbed ?character)
    :agents
      (?character)
  )

  (:action insulted
    :parameters
      (?character - character)
    :effect
      (insulted ?character)
    :agents
      (?character)
  )

  (:action found-attorney
    :parameters
      (?character - character)
    :effect
      (found-attorney ?character)
    :agents
      (?character)
  )

  (:action turned-up
    :parameters
      (?character - character)
    :effect
      (turned-up ?character)
    :agents
      (?character)
  )

  (:action around-bend
    :parameters
      (?character - character)
    :effect
      (around-bend ?character)
    :agents
      (?character)
  )

  (:action deserted-attitude
    :parameters
      (?character - character)
    :effect
      (deserted-attitude ?character)
    :agents
      (?character)
  )

  (:action took-seriously
    :parameters
      (?character - character)
    :effect
      (took-seriously ?character)
    :agents
      (?character)
  )

  (:action pranked
    :parameters
      (?character - character)
    :effect
      (pranked ?character)
    :agents
      (?character)
  )
)