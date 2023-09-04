(define (domain lily-and-books)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object bookshelf book - item)
  (:predicates
    (has ?character - character ?item - item)
    (on-shelf ?book - book ?bookshelf - bookshelf)
    (fell-down ?book - book)
    (sneezed ?character - character)
    (scared ?character - character)
    (in-room ?character - character)
    (in-kitchen ?character - character)
    (likes ?character - character ?item - item)
  )

  ;; A character reads a book.
  (:action read
    :parameters
      (?character - character ?book - book)
    :precondition
      (and (has ?character ?book)
      (not (fell-down ?book)))
    :effect
      (intends ?character (likes ?character ?book))
    :agents  (?character)
  )

  ;; A character sneezes.
  (:action sneeze
    :parameters
      (?character - character)
    :effect
      (sneezed ?character)
    :agents  (?character)
  )

  ;; A book falls down from the bookshelf.
  (:action book-fall
    :parameters
      (?book - book ?bookshelf - bookshelf)
    :precondition
      (on-shelf ?book ?bookshelf)
    :effect
      (and (fell-down ?book)
      (not (on-shelf ?book ?bookshelf)))
  )

  ;; A character gets scared.
  (:action get-scared
    :parameters
      (?character - character)
    :precondition
      (sneezed ?character)
    :effect
      (scared ?character)
    :agents  (?character)
  )

  ;; A character moves from the room to the kitchen.
  (:action move-to-kitchen
    :parameters
      (?character - character)
    :precondition
      (in-room ?character)
    :effect
      (and (not (in-room ?character))
      (in-kitchen ?character))
    :agents  (?character)
  )

  ;; A character moves from the kitchen to the room.
  (:action move-to-room
    :parameters
      (?character - character)
    :precondition
      (in-kitchen ?character)
    :effect
      (and (not (in-kitchen ?character))
      (in-room ?character))
    :agents  (?character)
  )
)