(define (problem mixy-helps-mommy)
  (:domain mixy-the-mixer)
  (:objects
    mixy spider cake - object)
  (:init
    (at mixy kitchen)
    (intends mixy (not (scared mixy)))
    (intends mixy (has mixy cake))
    (at mommy kitchen)
    (intends mommy (not (scared mommy)))
    (intends mommy (not (at spider kitchen)))
    (intends mommy (has mommy spider)))
  (:goal
    (and (not (scared mixy))
    (not (at spider kitchen))
    (not (has mommy spider))
    (not (has mixy spider))
    (not (has mixy cake))))