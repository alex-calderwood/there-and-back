(define (domain zoo-visit)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object)
  (:predicates
    (at ?character - character ?place - place)
    (likes ?character - character ?animal - animal)
    (sees ?character - character ?animal - animal)
    (knows-about ?character - character ?animal - animal)
    (can-touch ?character - character ?animal - animal)
    (is-fish ?animal - animal)
    (is-otter ?animal - animal)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character sees an animal.
  (:action see-animal
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (at ?character ?place)
    :effect
      (sees ?character ?animal)
    :agents
      (?character)
  )

  ;; A character learns about an animal.
  (:action learn-about
    :parameters
      (?character - character ?teacher - character ?animal - animal)
    :precondition
      (and (not (= ?character ?teacher))
      (sees ?character ?animal)
      (knows-about ?teacher ?animal))
    :effect
      (knows-about ?character ?animal)
    :agents
      (?character ?teacher)
  )

  ;; A character decides whether they can touch an animal.
  (:action decide-can-touch
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (knows-about ?character ?animal)
    :effect
      (can-touch ?character ?animal)
    :agents
      (?character)
  )
)