(define (problem love-confession-problem)
  (:domain love-confession)
  (:objects
    me crush - person)
  (:init
    (close me crush)
    (intends me (loves crush))
    (intends crush (answered me))
    (intends crush (loves me))
    (intends crush (not (has-obstruction)))
    (intends crush (not (choked))))
  (:goal
    (and (answered me)
    (loves crush me)
    (loves me crush))
  )
)