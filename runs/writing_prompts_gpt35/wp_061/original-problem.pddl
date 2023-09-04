(define (problem burden-problem)
  (:domain burden)
  (:objects
    narrator nate - character
    (storyteller) - expression
    (burdened storyteller) - expression
    (relieved storyteller) - expression
    (hides storyteller) - expression
    (reveals storyteller) - expression
    (believes storyteller) - expression
    (narrates storyteller) - expression
    (knows storyteller) - expression
  )
  (:init
    (alive narrator)
    (alive nate)
    (intends narrator (alive narrator) (alive narrator))
    (intends nate (alive nate) (alive nate))
    (intends narrator (narrates (storyteller)) (narrates (storyteller)))
    (intends nate (believes (storyteller)) (narrates (storyteller)))
    (intends nate (burdened (storyteller)) (narrates (storyteller)))
    (intends nate (hides (storyteller)) (narrates (storyteller)))
    (intends nate (reveals (storyteller)) (narrates (storyteller)))
    (intends nate (relieved (storyteller)) (narrates (storyteller)))
    (intends nate (knows nate (burdened (storyteller))) (narrates (storyteller)))
    (intends nate (knows nate (relieved (storyteller))) (narrates (storyteller)))
    (intends nate (knows nate (hides (storyteller))) (narrates (storyteller)))
    (intends nate (knows nate (reveals (storyteller))) (narrates (storyteller)))
    (narrates (storyteller))
    (not (believes nate (burdened (storyteller))))
    (not (burdened nate (burdened (storyteller))))
    (not (hides nate (burdened (storyteller))))
    (not (reveals nate (burdened (storyteller))))
    (not (relieved nate (burdened (storyteller))))
    (not (believes nate (relieved (storyteller))))
    (not (burdened nate (relieved (storyteller))))
    (not (hides nate (relieved (storyteller))))
    (not (reveals nate (relieved (storyteller))))
    (not (relieved nate (relieved (storyteller))))
    (not (believes nate (hides (storyteller))))
    (not (burdened nate (hides (storyteller))))
    (not (hides nate (hides (storyteller))))
    (not (reveals nate (hides (storyteller))))
    (not (relieved nate (hides (storyteller))))
    (not (believes nate (reveals (storyteller))))
    (not (burdened nate (reveals (storyteller))))
    (not (hides nate (reveals (storyteller))))
    (not (reveals nate (reveals (storyteller))))
    (not (relieved nate (reveals (storyteller))))
  )
  (:goal
    (and (believes nate