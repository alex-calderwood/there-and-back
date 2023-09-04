(define (domain skyrim-dragonborn)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (dragon-soul-absorbed ?character - character)
    (blessed-by-talos ?character - character)
    (enchanted-goods-sold ?character - character)
    (relics-sold ?character - character)
    (werewolf ?character - character)
    (married ?character1 - character ?character2 - character)
    (weapon-crafted ?character - character)
    (saved ?savior - character ?saved - character)
  )

  ;; A character kills a dragon.
  (:action kill-dragon
    :parameters
      (?character - character ?dragon - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (alive ?dragon)
      (at ?dragon ?place))
    :effect
      (and (not (alive ?dragon))
      (dragon-soul-absorbed ?character))
    :agents
      (?character)
  )

  ;; A character gets blessed by Talos.
  (:action get-blessed
    :parameters
      (?character - character ?priest - character)
    :precondition
      (and (alive ?character)
      (alive ?priest))
    :effect
      (blessed-by-talos ?character)
    :agents
      (?character ?priest)
  )

  ;; A character sells enchanted goods.
  (:action sell-enchanted-goods
    :parameters
      (?seller - character ?buyer - character ?place - place)
    :precondition
      (and (alive ?seller)
      (at ?seller ?place)
      (alive ?buyer)
      (at ?buyer ?place))
    :effect
      (enchanted-goods-sold ?seller)
    :agents
      (?seller ?buyer)
  )

  ;; A character sells relics.
  (:action sell-relics
    :parameters
      (?seller - character ?buyer - character ?place - place)
    :precondition
      (and (alive ?seller)
      (at ?seller ?place)
      (alive ?buyer)
      (at ?buyer ?place))
    :effect
      (relics-sold ?seller)
    :agents
      (?seller ?buyer)
  )

  ;; A character becomes a werewolf.
  (:action become-werewolf
    :parameters
      (?character - character)
    :effect
      (werewolf ?character)
    :agents
      (?character)
  )

  ;; A character marries another character.
  (:action marry
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (married ?character1 ?character2)))
    :effect
      (married ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character crafts a weapon.
  (:action craft-weapon
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (weapon-crafted ?character)
    :agents
      (?character)
  )

  ;; A character saves another character.
  (:action save
    :parameters
      (?savior - character ?saved - character ?place - place)
    :precondition
      (and (alive ?savior)
      (at ?savior ?place)
      (alive ?saved)
      (at ?saved ?place))
    :effect
      (saved ?savior ?saved)
    :agents
      (?savior)
  )
)