(define (domain frederick-and-me)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person animal - object)
  (:predicates
    (speaks ?person - person ?language - object)
    (comfortable ?person - person ?animal - animal)
    (offers ?person - person ?food - object)
    (eats ?animal - animal ?food - object)
    (invites ?person - person ?guest - person)
    (stays ?person - person ?guest - person)
    (communicates ?person - person ?guest - person)
    (trusts ?person - person ?guest - person)
    (cuddles ?person - person ?animal - animal)
    (takes ?person - person ?animal - animal ?place - object)
    (holds ?person - person ?animal - animal ?place - object)
    (awakens ?person - person ?animal - animal)
    (scratches ?person - person ?animal - animal)
  )

  ;; A person speaks a language.
  (:action speak
    :parameters
      (?person - person ?language - object)
    :precondition
      (and (not (= ?language nil))
      (not (speaks ?person ?language)))
    :effect
      (speaks ?person ?language)
  )

  ;; A person makes an animal comfortable.
  (:action make-comfortable
    :parameters
      (?person - person ?animal - animal)
    :precondition
      (and (not (comfortable ?person ?animal)))
    :effect
      (comfortable ?person ?animal)
  )

  ;; A person offers food to an animal.
  (:action offer-food
    :parameters
      (?person - person ?food - object ?animal - animal)
    :precondition
      (and (not (offers ?person ?food))
      (comfortable ?person ?animal))
    :effect
      (and (offers ?person ?food)
      (eats ?animal ?food))
  )

  ;; A person invites another person to stay the night.
  (:action invite-to-stay
    :parameters
      (?person - person ?guest - person)
    :precondition
      (and (not (invites ?person ?guest))
      (comfortable ?person ?guest))
    :effect
      (invites ?person ?guest)
  )

  ;; A person stays the night with another person.
  (:action stay-the-night
    :parameters
      (?person - person ?guest - person)
    :precondition
      (and (invites ?person ?guest)
      (not (stays ?person ?guest))))
    :effect
      (stays ?person ?guest)
  
  ;; Two people communicate with each other.
  (:action communicate
    :parameters
      (?person - person ?guest - person)
    :precondition
      (and (speaks ?person ?language)
      (speaks ?guest ?language)
      (comfortable ?person ?guest)
      (not (communicates ?person ?guest))))
    :effect
      (communicates ?person ?guest)
  
  ;; A person trusts another person.
  (:action trust
    :parameters
      (?person - person ?guest - person)
    :precondition
      (and (comfortable ?person ?guest)
      (not (trusts ?person ?guest))))
    :effect
      (trusts ?person ?guest)
  
  ;; A person cuddles with an animal.
  (:action cuddle
    :parameters
      (?person - person ?animal - animal)
    :precondition
      (and (comfortable ?person ?animal)
      (not (cuddles ?person ?animal))))
    :effect
      (cuddles ?person ?animal)
  
  ;; A person takes an animal to a place.
  (:action take-to-place
    :parameters
      (?person - person ?animal - animal ?place - object)
    :precondition
      (and (comfortable ?person ?animal)
      (not (takes ?person ?animal ?place))
      (not (holds ?person ?animal ?place))))
    :effect
      (takes ?person ?animal ?place)
  
  ;; A person holds an animal in a place.
  (:action hold-in-place
    :parameters
      (?person - person ?animal - animal ?place - object)
    :precondition
      (and (takes ?person ?animal ?place)
      (not (holds ?person ?animal ?place))))
    :effect
      (holds ?person ?animal ?place)
  
  ;; An animal awakens.
  (:action awaken
    :parameters
      (?person - person ?animal - animal)
    :precondition
      (and (holds ?person ?animal ?place)
      (not (awakens ?person ?animal))))
    :effect
      (awakens ?person ?animal)
  
  ;; A person scratches an animal.
  (:action scratch
    :parameters
      (?person - person ?animal - animal)
    :precondition
      (and (comfortable ?person ?animal)
      (not (scratches ?person ?animal))))
    :effect
      (scratches ?person ?animal)
)