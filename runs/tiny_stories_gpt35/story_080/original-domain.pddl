(define (domain lily-books)
  (:requirements :strips :typing)
  (:types book teddybear - object)
  (:predicates
    (on-shelf ?book - book)
    (on-floor ?book - book)
    (held ?teddybear - teddybear)
  )

  ;; Lily sneezes and knocks books off the shelf.
  (:action sneeze
    :parameters
      ()
    :precondition
      (and (not (held ?teddybear))
      (exists (?book - book)
      (on-shelf ?book)))
    :effect
      (and (forall (?book - book)
      (when (on-shelf ?book)
      (and (not (on-shelf ?book))
      (on-floor ?book))))
      (not (held ?teddybear)))
    :agents
      ()
  )

  ;; Lily runs to her mom.
  (:action run-to-mom
    :parameters
      ()
    :precondition
      (and (not (held ?teddybear))
      (exists (?book - book)
      (on-floor ?book)))
    :effect
      (and (forall (?book - book)
      (when (on-floor ?book)
      (not (on-floor ?book))))
      (held ?teddybear))
    :agents
      ()
  )

  ;; Lily and her mom pick up the books.
  (:action pick-up-books
    :parameters
      ()
    :precondition
      (held ?teddybear)
    :effect
      (and (forall (?book - book)
      (when (on-floor ?book)
      (and (not (on-floor ?book))
      (on-shelf ?book))))
      (not (held ?teddybear)))
    :agents
      ()
  )
)