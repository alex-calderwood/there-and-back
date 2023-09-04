(define (problem office-life-story)
  (:domain
    office-life)
  (:objects
    pat candice david - character
    office restaurant - place
    pat-outfit candice-outfit - object
    uncertainty - object)
  (:init
    (at pat office)
    (at candice office)
    (at david office)
    (hungry pat)
    (hungry candice)
    (hungry david)
    (wearing pat pat-outfit)
    (wearing candice candice-outfit)
    (intends pat (knows pat candice))
    (intends pat (knows pat david))
    (intends pat (not (hungry pat)))
    (intends pat (feels pat uncertainty))
    (intends candice (knows candice pat))
    (intends candice (not (hungry candice)))
    (intends david (knows david pat))
    (intends david (not (hungry david)))
  )
  (:goal
    (and (knows pat candice)
         (knows pat david)
         (knows candice pat)
         (knows david pat)
         (not (hungry pat))
         (not (hungry candice))
         (not (hungry david))
         (feels pat uncertainty))
  )
)