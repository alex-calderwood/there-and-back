(define (problem story-contest)
  (:domain
    burden-story)
  (:objects
    voter idol - character
    afterlife-on-mars by-the-light-of-my-cigarette burden - object)
  (:init
    (alive voter)
    (intends voter (read voter afterlife-on-mars))
    (intends voter (read voter by-the-light-of-my-cigarette))
    (intends voter (read voter burden))
    (intends voter (vote voter burden))
    (alive idol)
    (intends idol (win afterlife-on-mars))
    (intends idol (win by-the-light-of-my-cigarette))
  )
  (:goal
    (and (read voter afterlife-on-mars)
    (read voter by-the-light-of-my-cigarette)
    (read voter burden)
    (vote voter burden)
    (win burden)
    (fan voter idol))
  )
)