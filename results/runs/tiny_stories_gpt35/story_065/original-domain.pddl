(define (domain mama-and-baby)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (hugged ?character - character)
    (touched-fence)
  )

  ;; Mama moves to a location.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; Mama hugs Baby.
  (:action hug
    :parameters
      (?mama - character ?baby - character)
    :precondition
      (and (at ?mama ?location)
      (at ?baby ?location))
    :effect
      (hugged ?baby)
    :agents
      (?mama ?baby)
  )

  ;; Baby touches the fence.
  (:action touch-fence
    :parameters
      (?baby - character)
    :precondition
      (and (at ?baby ?location)
      (not (touched-fence)))
    :effect
      (touched-fence)
    :agents
      (?baby)
  )
)