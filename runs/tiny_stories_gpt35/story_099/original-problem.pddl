(define (problem lily-sees-otter)
  (:domain
    lily-goes-to-zoo)
  (:objects
    lily mom - object
    zoo tank red-fish blue-fish yellow-fish green-fish - object
    striped-fish spotted-fish dotted-fish - object
    long-tailed-fish short-tailed-fish tailless-fish - object
    fast-swimming-fish slow-swimming-fish circling-fish - object)
  (:init
    (at lily zoo)
    (at mom zoo)
    (at otter tank)
    (likes lily monkeys)
    (likes lily lions)
    (likes lily birds)
    (likes lily fish)
    (funny otter)
    (has-hair otter)
    (eats otter fish)
    (plays-with-rocks otter)
    (wild otter))
  (:goal
    (and (happy lily)
    (not (intends lily (asked lily ?question)))
    (not (intends lily (answered lily ?question ?answer)))
    (intends lily (said lily ?sentence))
    (intends lily (look-at lily otter zoo))
    (intends lily (make-happy lily))
    (not (intends lily (asked lily ?question)))
    (not (intends lily (answered lily ?question ?answer)))
    (intends