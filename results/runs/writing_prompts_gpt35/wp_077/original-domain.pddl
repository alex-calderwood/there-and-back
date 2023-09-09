(define (domain poem)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types word - object)
  (:constants
    reader - object
    poem - object)
  (:predicates
    (word ?word - word)
    (act ?word - word)
    (kill ?word - word)
    (heard ?word - word)
    (alive ?word - word)
    (peruse ?word - word)
    (question ?word - word)
    (accuracy ?word - word)
    (right ?word - word)
    (wrong ?word - word)
    (feel ?word - word)
    (worry ?word - word)
    (race ?word - word)
    (hurry ?word - word)
    (echo ?word - word)
    (tempo ?word - word)
    (song ?word - word)
    (confess ?word - word)
    (know ?word - word)
    (gone ?word - word)
    (love ?word - word)
  )

  ;; Reader peruses the poem.
  (:action peruse
    :parameters
      (?reader - object ?word - word)
    :precondition
      (and
        (alive ?reader)
        (word ?word)
        (not (peruse ?word ?reader)))
    :effect
      (and
        (peruse ?word ?reader)
        (heard ?word))
    :agents
      (?reader)
  )

  ;; Reader questions the poem's accuracy.
  (:action question-accuracy
    :parameters
      (?reader - object ?word - word)
    :precondition
      (and
        (alive ?reader)
        (word ?word)
        (peruse ?word ?reader)
        (not (question ?word ?reader)))
    :effect
      (and
        (question ?word ?reader)
        (not (accuracy ?word)))
    :agents
      (?reader)
  )

  ;; Reader kills the poem.
  (:action kill-poem
    :parameters
      (?reader - object ?word - word)
    :precondition
      (and
        (alive ?reader)
        (word ?word)
        (peruse ?word ?reader)
        (not (kill ?word ?reader)))
    :effect
      (and
        (kill ?word ?reader)
        (not (alive ?word)))
    :agents
      (?reader)
  )

  ;; Poem confesses its thoughts.
  (:action confess-thoughts
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (not (confess ?word)))
    :effect
      (confess ?word)
    :agents
      (poem)
  )

  ;; Poem acknowledges its mortality.
  (:action acknowledge-mortality
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (confess ?word)
        (not (gone ?word)))
    :effect
      (gone ?word)
    :agents
      (poem)
  )

  ;; Poem declares its love for the reader.
  (:action declare-love
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (gone ?word)
        (not (love ?word)))
    :effect
      (love ?word)
    :agents
      (poem)
  )

  ;; Poem becomes an echo.
  (:action become-echo
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (love ?word)
        (not (echo ?word)))
    :effect
      (echo ?word)
    :agents
      (poem)
  )

  ;; Poem becomes a tempo.
  (:action become-tempo
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (echo ?word)
        (not (tempo ?word)))
    :effect
      (tempo ?word)
    :agents
      (poem)
  )

  ;; Poem becomes a song.
  (:action become-song
    :parameters
      (?word - word)
    :precondition
      (and
        (word ?word)
        (tempo ?word)
        (not (song ?word)))
    :effect
      (song ?word)
    :agents
      (poem)
  )
)