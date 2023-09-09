(define (problem postal-service-problem)
  (:domain postal-service)
  (:objects
    me - person
    girl - person
    old-man - person
    bicycle - object
    model-t - object
    mailbox - object
    townhouse - object)
  (:init
    (at me living-room)
    (has me envelope)
    (at girl sidewalk)
    (bad-music girl)
    (at old-man model-t)
    (owns old-man model-t)
    (is-related me old-man)
    (at bicycle street-corner)
    (tall bicycle)
    (at cousin home)
    (is-related me cousin)
    (intends me (not (at me living-room)))
    (intends me (not (has me envelope)))
    (intends me (has mailbox envelope))
    (intends me (not (supercell)))
    (intends me (has cousin amazon-gift-card)))
  (:goal
    (and (delivered envelope)
    (not (has me envelope))
    (good-music me)
    (not (tall bicycle))
    (not (alive me))
    (not (supercell)))
  )
)