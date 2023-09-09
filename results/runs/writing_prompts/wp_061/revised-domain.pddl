(define (domain burden-story)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (fan ?character - character ?idol - character)
    (read ?character - character ?story - object)
    (vote ?character - character ?story - object)
    (win ?story - object)
  )

  ;; A character reads a story.
  (:action read-story
    :parameters
      (?reader - character ?story - object)
    :precondition
      (alive ?reader)
    :effect
      (read ?reader ?story)
    :agents
      (?reader)
  )

  ;; A character votes for a story.
  (:action vote-for-story
    :parameters
      (?voter - character ?story - object)
    :precondition
      (and (alive ?voter)
      (read ?voter ?story))
    :effect
      (vote ?voter ?story)
    :agents
      (?voter)
  )

  ;; A story wins.
  (:action story-wins
    :parameters
      (?story - object)
    :precondition
      (exists (?voter - character)
      (vote ?voter ?story))
    :effect
      (win ?story)
  )

  ;; A character becomes a fan of another character.
  (:action become-fan
    :parameters
      (?fan - character ?idol - character)
    :precondition
      (and (alive ?fan)
      (alive ?idol)
      (not (= ?fan ?idol)))
    :effect
      (fan ?fan ?idol)
    :agents
      (?fan)
  )
)