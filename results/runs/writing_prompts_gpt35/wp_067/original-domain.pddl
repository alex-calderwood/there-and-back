(define (domain dreamscape)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants
    dreamer - character
    monster - character
    box - object
    material - object
  )
  (:predicates
    (in-dream ?character - character)
    (alive ?character - character)
    (has-power ?character - character)
    (trapped ?character - character)
    (loves ?character - character ?other - character)
    (face ?character - character ?face - object)
    (crying ?character - character)
    (holding ?character - character ?other - character)
  )

  ;; A character changes the dreamscape to trap the monster in a box.
  (:action trap-monster
    :parameters
      (?character - character ?monster - character ?box - object ?material - object)
    :precondition
      (and (in-dream ?character)
      (alive ?character)
      (has-power ?character)
      (alive ?monster)
      (in-dream ?monster)
      (not (trapped ?monster))
      (has ?material ?box)
      (face ?monster ?face)
      (not (face ?character ?face)))
    :effect
      (and (trapped ?monster)
      (not (holding ?character ?monster))
      (not (face ?monster ?face))
      (not (crying ?monster)))
    :agents
      (?character)
  )

  ;; A character frees the monster from the box.
  (:action free-monster
    :parameters
      (?character - character ?monster - character ?box - object)
    :precondition
      (and (in-dream ?character)
      (alive ?character)
      (has-power ?character)
      (alive ?monster)
      (in-dream ?monster)
      (trapped ?monster)
      (has ?box ?monster))
    :effect
      (not (trapped ?monster))
    :agents
      (?character)
  )

  ;; A character changes the dreamscape to create a cheerful world.
  (:action change-dreamscape
    :parameters
      (?character - character)
    :precondition
      (and (in-dream ?character)
      (alive ?character)
      (has-power ?character))
    :effect
      (not (face dreamer ?face))
    :agents
      (?character)
  )

  ;; A character holds another character.
  (:action hold
    :parameters
      (?holder - character ?other - character)
    :precondition
      (and (in-dream ?holder)
      (alive ?holder)
      (in-dream ?other)
      (alive ?other)
      (loves ?holder ?other)
      (not (holding ?other ?holder))))
    :effect
      (holding ?holder ?other)
    :agents
      (?holder)
  )

  ;; A character stops holding another character.
  (:action release
    :parameters
      (?holder - character ?other - character)
    :precondition
      (and (in-dream ?holder)
      (alive ?holder)
      (in-dream ?other)
      (alive ?other)
      (holding ?holder ?other))
    :effect
      (not (holding ?holder ?other))
    :agents
      (?holder)
  )

  ;; A character cries.
  (:action cry
    :parameters
      (?character - character)
    :precondition
      (and (in-dream ?character)
      (alive ?character)
      (has-power ?character)
      (face ?character ?face)
      (not (crying ?character))))
    :effect
      (crying ?character)
    :agents
      (?character)
  )
)