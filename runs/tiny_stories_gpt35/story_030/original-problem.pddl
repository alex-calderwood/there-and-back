(define (problem dark-woods)
  (:domain dark-woods)
  (:objects
    tim bear mystery-tree - character
    big-tree - object
    dark-woods - place)
  (:init
    (at tim dark-woods)
    (at bear dark-woods)
    (intends tim (friend bear))
    (intends bear (friend tim))
    (intends bear (hungry bear))
    (intends tim (search-for-food tim))
    (intends tim (walk tim dark-woods big-tree))
    (intends tim (walk tim big-tree dark-woods))
    (intends tim (find-food tim))
    (intends bear (eat bear tim))
    (intends mystery-tree (watch)))
  (:goal
    (and (not (alive tim))
    (ate bear)))
)