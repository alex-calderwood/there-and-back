;;;
;;; All the actions that characters can take in the interactive narrative adventure game The Best Laid Plans
;;; Created by Stephen G. Ware
;;; Originally used for the automatic planning and replanning of stories in The Best Laid Plans
;;;
(define (domain goblin)
  (:requirements :adl :domain-axioms :intentionality)
  (:types humanoid - character
          predator - character
          protagonist merchant guard - humanoid
          location - object
          money weapon light food poison spell - item
          light_spell alchemy_spell love_spell kill_spell teleport_spell - spell)
  (:predicates (alive ?character - character)
               (armed ?character - character)
               (dark ?location - location)
               (poisoned ?food - food)
               (path ?from - location ?to - location)
               (at ?character - character ?location - location)
               (at ?item - item ?location - location)
               (knows-location ?character - character ?location - location)
               (has ?character - character ?item - item)
               (buying ?merchant - merchant ?item - item)
               (selling ?merchant - merchant ?item - item)
               (summons ?light_spell - light_spell ?light - light)
               (summons ?alchemy_spell - alchemy_spell ?money - money)
               (leads_to ?teleport_spell - teleport_spell ?location - location)
               (hungry ?character)
               (citizen ?character - character)
               (guard ?character - character)
               (criminal ?character - character)
               (owned ?item - item)
               (owns ?character - humanoid ?item - item))

  ;; A character walks from one place to another.
  (:action walk
    :parameters   (?character - character ?from - location ?to - location)
    :precondition (and (not (= ?from ?to))
                       (alive ?character)
                       (at ?character ?from)
                       (path ?from ?to)
                       (knows-location ?character ?to)
                       (or (not (dark ?to))
                           (exists (?l - light)
                                   (has ?character ?l))))
    :effect       (and (not (at ?character ?from))
                       (at ?character ?to))
    :agents       (?character))

  ;; One character attacks another.
  (:action attack
    :parameters   (?character - character ?target - character ?location - location)
    :precondition (and (not (= ?character ?target))
                       (alive ?character)
                       (at ?character ?location)
                       (alive ?target)
                       (at ?target ?location)
                       (or (not (guard ?character))
                           (criminal ?target)))
    :effect       (and (when (and (armed ?character)
                                  (armed ?target))
                             (not (alive ?target)))
                       (when (and (armed ?character)
                                  (not (armed ?target)))
                             (not (alive ?target)))
                       (when (and (not (armed ?character))
                                  (armed ?target))
                             (not (alive ?character)))
                       (when (and (not (armed ?character))
                                  (not (armed ?target)))
                             (not (alive ?target)))
                       (when (citizen ?target)
                             (criminal ?character)))
    :agents       (?character))

  ;; A character poisons some food.
  (:action poison
    :parameters   (?character - protagonist ?poison - poison ?food - food)
    :precondition (and (alive ?character)
                       (has ?character ?poison)
                       (has ?character ?food))
    :effect       (and (not (has ?character ?poison))
                       (poisoned ?food))
    :agents       (?character))

  ;; A character eats some food.
  (:action eat
    :parameters   (?character - humanoid ?food - food)
    :precondition (and (alive ?character)
                       (has ?character ?food))
    :effect       (and (not (has ?character ?food))
                       (not (hungry ?character))
                       (when (poisoned ?food)
                             (not (alive ?character))))
    :agents       (?character))

  ;; A character picks up an item.
  (:action pickup
    :parameters   (?character - humanoid ?item - item ?location - location)
    :precondition (and (alive ?character)
                       (at ?character ?location)
                       (at ?item ?location)
                       (or (not (guard ?character))
                           (not (owned ?item))))
    :effect       (and (not (at ?item ?location))
                       (has ?character ?item))
    :agents       (?character))

  ;; One character trades an item for another item that another character is selling.
  (:action trade
    :parameters   (?character - protagonist ?character_item - item ?seller - merchant ?seller_item - item ?location - location)
    :precondition (and (alive ?character)
                       (at ?character ?location)
                       (has ?character ?character_item)
                       (alive ?seller)
                       (at ?seller ?location)
                       (at ?seller_item ?location)
                       (owns ?seller ?seller_item)
                       (buying ?seller ?character_item)
                       (selling ?seller ?seller_item))
    :effect       (and (not (has ?character ?character_item))
                       (has ?seller ?character_item)
                       (not (at ?seller_item ?location))
                       (has ?character ?seller_item)
                       (not (owns ?seller ?seller_item))
                       (owns ?character ?seller_item)
                       (not (buying ?seller ?character_item))
                       (not (selling ?seller ?seller_item)))
    :agents       (?character))

  ;; One character gives an item to another.
  (:action give
    :parameters   (?character - protagonist ?item - item ?receiver - humanoid ?location - location)
    :precondition (and (not (= ?character ?receiver))
                       (alive ?character)
                       (at ?character ?location)
                       (has ?character ?item)
                       (alive ?receiver)
                       (at ?receiver ?location))
    :effect       (and (not (has ?character ?item))
                       (has ?receiver ?item))
    :agents       (?character))

  ;; A character casts the Light spell.
  (:action cast_light_spell
    :parameters   (?character - protagonist ?spell - light_spell ?light - light)
    :precondition (and (alive ?character)
                       (has ?character ?spell)
                       (summons ?spell ?light))
    :effect       (and (not (has ?character ?spell))
                       (has ?character ?light))
    :agents       (?character))

  ;; A character casts the Alchemy spell.
  (:action cast_alchemy_spell
    :parameters   (?character - protagonist ?spell - alchemy_spell ?item - item ?money - money)
    :precondition (and (alive ?character)
                       (has ?character ?spell)
                       (has ?character ?item)
                       (summons ?spell ?money))
    :effect       (and (not (has ?character ?spell))
                       (not (has ?character ?item))
                       (has ?character ?money))
    :agents       (?character))

  ;; A character casts the Kill spell.
  (:action cast_kill_spell
    :parameters   (?character - humanoid ?spell - kill_spell ?target - character ?location - location)
    :precondition (and (alive ?character)
                       (has ?character ?spell)
                       (at ?character ?location)
                       (alive ?target)
                       (at ?target ?location))
    :effect       (and (not (has ?character ?spell))
                       (not (alive ?target)))
    :agents       (?character))

  ;; A character casts the Teleport spell.
  (:action cast_teleport_spell
    :parameters   (?character - protagonist ?spell - teleport_spell ?from - location ?to - location)
    :precondition (and (alive ?character)
                       (has ?character ?spell)
                       (at ?character ?from)
                       (leads_to ?spell ?to))
    :effect       (and (not (has ?character ?spell))
                       (not (at ?character ?from))
                       (at ?character ?to))
    :agents       (?character))

  ;; When a character dies, they drop all their items.
  (:axiom
    :vars         (?character - humanoid ?item - item ?location - location)
    :context      (and (not (alive ?character))
                       (at ?character ?location)
                       (has ?character ?item))
    :implies      (and (not (has ?character ?item))
                       (at ?item ?location)))

  ;; When a character dies, they no longer own their items.
  (:axiom
    :vars         (?character - humanoid ?item - item)
    :context      (and (not (alive ?character))
                       (owns ?character ?item))
    :implies      (not (owns ?character ?item)))

  ;; When an item is owned by anyone, it is owned.
  (:axiom
    :vars         (?item - item)
    :context      (and (not (owned ?item))
                       (exists (?c - humanoid)
                               (owns ?c ?item)))
    :implies      (owned ?item))

  ;; When an item is not owned by anyone, it is not owned.
  (:axiom
    :vars         (?item - item)
    :context      (and (owned ?item)
                       (forall (?c - humanoid)
                               (not (owns ?c ?item))))
    :implies      (not (owned ?item)))

  ;; When a character has a weapon, they are armed.
  (:axiom
    :vars         (?character - character)
    :context      (and (not (armed ?character))
                       (exists (?w - weapon)
                               (has ?character ?w)))
    :implies      (armed ?character))

  ;; When a character has no weapon, they are not armed.
  (:axiom
    :vars         (?character - character)
    :context      (and (armed ?character)
                       (forall (?w - weapon)
                               (not (has ?character ?w))))
    :implies      (not (armed ?character)))

  ;; When a character has a stolen item, the owner attacks.
  (:axiom
    :vars         (?character - humanoid ?item - item ?owner - humanoid)
    :context      (and (not (= ?character ?owner))
                       (alive ?character)
                       (has ?character ?item)
                       (alive ?owner)
                       (owns ?owner ?item))
    :implies      (and (intends ?owner (not (alive ?character)))
                       (when (citizen ?owner)
                             (criminal ?character))))
	
  ;; A guard wants to kill criminals.
  (:axiom
    :vars         (?character - humanoid ?guard - guard)
    :context      (and (alive ?character)
                       (criminal ?character)
                       (alive ?guard))
    :implies      (intends ?guard (not (alive ?character))))

  ;; A predator wants to attack nearby humans.
  (:axiom
    :vars         (?predator - predator ?character - humanoid ?location - location)
    :context      (and (alive ?predator)
                       (at ?predator ?location)
                       (alive ?character)
                       (at ?character ?location))
    :implies      (intends ?predator (not (alive ?character)))))