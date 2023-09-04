(define (domain skyrim)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object item - object place - object)
  (:constants dragon - item)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (blessed ?character - character)
    (killed ?character - character ?dragon - item)
    (enchant ?character - character ?item - item)
    (stole ?character - character ?item - item)
    (best-student ?character - character)
    (good-technique ?character - character)
    (contract-stolen ?character - character)
    (true-savior ?character - character)
    (made-weapon ?character - character ?item - item)
    (saved-life ?character - character)
    (intends ?character - character ?predicate - expression)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character kills a dragon and absorbs its soul.
  (:action kill-dragon
    :parameters
      (?character - character ?dragon - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (at ?dragon ?place))
    :effect
      (and (not (at ?dragon ?place))
      (killed ?character ?dragon)
      (intends ?character (has ?character dragon)))
    :agents  (?character)
  )

  ;; A character uses an enchanted item.
  (:action use-enchantment
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item)
      (enchant ?character ?item))
    :effect
      (and (not (enchant ?character ?item)))
    :agents  (?character)
  )

  ;; A character steals an item from another.
  (:action steal
    :parameters
      (?thief - character ?item - item ?victim - character ?place - place)
    :precondition
      (and (not (= ?thief ?victim))
      (alive ?thief)
      (at ?thief ?place)
      (at ?victim ?place)
      (has ?victim ?item))
    :effect
      (and (not (has ?victim ?item))
      (has ?thief ?item)
      (stole ?thief ?item))
    :agents
      (?thief)
  )

  ;; A character becomes blessed by Talos.
  (:action bless
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (blessed ?character)
    :agents  (?character)
  )

  ;; A character becomes the best student.
  (:action become-best-student
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (best-student ?character)
    :agents  (?character)
  )

  ;; A character makes a weapon.
  (:action make-weapon
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item))
    :effect
      (made-weapon ?character ?item)
    :agents  (?character)
  )

  ;; A character saves another character's life.
  (:action save-life
    :parameters
      (?savior - character ?victim - character ?place - place)
    :precondition
      (and (alive ?savior)
      (at ?savior ?place)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (saved-life ?savior)
    :agents
      (?savior)
  )

  ;; A character becomes Skyrim's true savior.
  (:action become-true-savior
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (true-savior ?character)
    :agents  (?character)
  )
)