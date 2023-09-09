(define (domain lily-goes-to-zoo)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables :intentionality)
  (:types animal - object)
  (:constants otter - animal)
  (:predicates
    (at ?animal - animal ?place - object)
    (likes ?person - object ?animal - animal)
    (wild ?animal - animal)
    (pet ?animal - animal)
    (has-hair ?animal - animal)
    (eats ?animal1 - animal ?animal2 - animal)
    (plays-with-rocks ?animal - animal)
    (funny ?animal - animal)
    (happy ?person - object)
    (surprised ?person - object)
    (interested ?person - object)
    (asked ?person - object ?question - expression)
    (answered ?person - object ?question - expression ?answer - expression)
    (said ?person - object ?sentence - expression)
    (intends ?person - object ?predicate - expression)
  )

  ;; A person travels from one place to another.
  (:action travel
    :parameters
      (?person - object ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
    :agents  (?person)
  )

  ;; A person looks at an animal.
  (:action look-at
    :parameters
      (?person - object ?animal - animal ?place - object)
    :precondition
      (and (at ?person ?place)
      (at ?animal ?place))
    :effect
      (and (interested ?person)
      (intends ?person (said ?person ?sentence))
      (not (intends ?person (asked ?person ?question)))
      (not (intends ?person (answered ?person ?question ?answer))))
    :agents
      (?person)
  )

  ;; A person asks a question.
  (:action ask
    :parameters
      (?asker - object ?askee - object ?question - expression ?place - object)
    :precondition
      (and (at ?asker ?place)
      (at ?askee ?place)
      (intends ?asker (said ?asker ?question)))
    :effect
      (and (intends ?askee (asked ?asker ?question))
      (not (intends ?asker (said ?asker ?question))))
    :agents
      (?asker ?askee)
  )

  ;; A person answers a question.
  (:action answer
    :parameters
      (?answerer - object ?asker - object ?question - expression ?answer - expression ?place - object)
    :precondition
      (and (at ?answerer ?place)
      (at ?asker ?place)
      (intends ?answerer (asked ?asker ?question)))
    :effect
      (and (intends ?asker (answered ?answerer ?question ?answer))
      (not (intends ?answerer (asked ?asker ?question))))
    :agents
      (?answerer ?asker)
  )

  ;; A person says a sentence.
  (:action say
    :parameters
      (?speaker - object ?sentence - expression ?place - object)
    :precondition
      (and (at ?speaker ?place)
      (intends ?speaker (said ?speaker ?sentence)))
    :effect
      (and (not (intends ?speaker (said ?speaker ?sentence))))
    :agents
      (?speaker)
  )

  ;; A person becomes happy.
  (:action make-happy
    :parameters
      (?person - object)
    :precondition
      (and (not (happy ?person)))
    :effect
      (happy ?person)
    :agents
      (?person)
  )

  ;; A person becomes surprised.
  (:action make-surprised
    :parameters
      (?person - object)
    :precondition
      (and (not (surprised ?person)))
    :effect
      (surprised ?person)
    :agents
      (?person)
  )

  ;; A person becomes interested.
  (:action make-interested
    :parameters
      (?person - object)
    :precondition
      (and (not (interested ?person)))
    :effect
      (interested ?person)
    :agents
      (?person)
  )

  ;; A person intends to do something.
  (:action intend
    :parameters
      (?person - object ?predicate - expression)
    :precondition
      (and (not (intends ?person ?predicate)))
    :effect
      (intends ?person ?predicate)
    :agents
      (?person)
  )
)