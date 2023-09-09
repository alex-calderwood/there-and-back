(define (problem dark-woods-story)
  (:domain
    dark-woods)
  (:objects
    tim bear mystery-tree - character)
  (:init
    (alive tim)
    (intends tim (friend tim bear))
    (intends tim (friend tim mystery-tree))
    (alive bear)
    (hungry bear)
    (intends bear (friend bear tim))
    (intends bear (not (hungry bear)))
    (alive mystery-tree))
  (:goal
    (and (not (alive tim))
    (friend tim bear)
    (not (hungry bear))))
  (:intentionality
    (intends bear (alive bear))
    (intends tim (alive tim))
    (intends mystery-tree (alive mystery-tree))
  )
)