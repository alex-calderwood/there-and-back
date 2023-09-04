(define (domain spot-and-cat)
  (:requirements :strips :typing :equality)
  (:types animal - object)
  (:predicates
    (scared ?animal - animal)
    (friendly ?animal - animal)
    (playing ?animal - animal)
    (sneezing ?animal - animal)
  )

  ;; An animal approaches another animal.
  (:action approach
    :parameters
      (?approacher - animal ?approachee - animal)
    :precondition
      (and (not (= ?approacher ?approachee))
      (not (playing ?approacher))
      (not (playing ?approachee))
      (not (scared ?approacher))
      (not (scared ?approachee)))
    :effect
      (and (friendly ?approacher)
      (friendly ?approachee))
    :agents
      (?approacher)
  )

  ;; An animal plays with another animal.
  (:action play
    :parameters
      (?player - animal ?playmate - animal)
    :precondition
      (and (friendly ?player)
      (friendly ?playmate))
    :effect
      (and (playing ?player)
      (playing ?playmate))
    :agents
      (?player)
  )

  ;; An animal sneezes.
  (:action sneeze
    :parameters
      (?sneezer - animal)
    :precondition
      (not (sneezing ?sneezer))
    :effect
      (sneezing ?sneezer)
    :agents
      (?sneezer)
  )
)