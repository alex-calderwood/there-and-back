(define (domain alien-liberation)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (liberated ?character - character)
    (defeated-illuminati)
    (alien-exists ?character - character)
    (alien-gone ?character - character)
  )

  ;; An alien character liberates a human character.
  (:action liberate
    :parameters
      (?alien - character ?human - character)
    :precondition
      (and (alien-exists ?alien)
      (not (liberated ?human)))
    :effect
      (liberated ?human)
    :agents
      (?alien)
  )

  ;; An alien character defeats the Illuminati.
  (:action defeat-illuminati
    :parameters
      (?alien - character)
    :precondition
      (and (alien-exists ?alien)
      (not (defeated-illuminati)))
    :effect
      (defeated-illuminati)
    :agents
      (?alien)
  )

  ;; An alien character disappears.
  (:action disappear
    :parameters
      (?alien - character)
    :precondition
      (alien-exists ?alien)
    :effect
      (alien-gone ?alien)
    :agents
      (?alien)
  )

  ;; An alien character reappears.
  (:action reappear
    :parameters
      (?alien - character)
    :precondition
      (alien-gone ?alien)
    :effect
      (alien-exists ?alien)
    :agents
      (?alien)
  )
)