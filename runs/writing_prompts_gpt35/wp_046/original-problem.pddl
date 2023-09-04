(define (problem frederick-and-me-problem)
  (:domain frederick-and-me)
  (:objects
    me frederick - person
    balls food bed - object
    clicking-sound - language)
  (:init
    (not (= me frederick))
    (not (= me balls))
    (not (= frederick me))
    (not (= frederick balls))
    (speaks frederick clicking-sound)
    (comfortable frederick me)
    (offers frederick food)