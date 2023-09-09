(define (domain animal-friends)
  (:requirements :strips :typing :equality)
  (:types animal - object)
  (:predicates
    (friend ?animal1 - animal ?animal2 - animal)
    (sad ?animal - animal)
    (ready ?animal - animal)
    (pulling ?animal - animal)
  )

  ;; An animal greets another animal.
  (:action greet
    :parameters
      (?greeted - animal ?greeter - animal)
    :precondition
      (and (not (= ?greeted ?greeter))
      (not (friend ?greeted ?greeter)))
    :effect
      (and (friend ?greeted ?greeter)
      (friend ?greeter ?greeted))
  )

  ;; An animal helps another animal practice.
  (:action practice
    :parameters
      (?helper - animal ?helpee - animal)
    :precondition
      (and (friend ?helper ?helpee)
      (sad ?helpee)
      (not (pulling ?helpee)))
    :effect
      (and (not (sad ?helpee))
      (ready ?helpee))
  )

  ;; An animal pulls a cart.
  (:action pull
    :parameters
      (?puller - animal)
    :precondition
      (and (friend ?puller ?helpee)
      (ready ?puller))
    :effect
      (pulling ?puller)
  )
)