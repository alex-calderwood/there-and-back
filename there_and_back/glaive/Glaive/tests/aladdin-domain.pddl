;;;
;;; A domain for telling the story of Aladdin from 1001 Nights
;;; Created by Mark O. Riedl for his dissertation
;;; Ported to PDDL 3 and modified to use the 'delegated' modality by Stephen G. Ware
;;;
(define (domain aladdin)
  (:requirements :adl :domain-axioms :expression-variables :intentionality :delegation)
  (:types character thing place - object
          male female monster - character
          knight king - male
          genie dragon - monster
          magic-lamp - thing)
  (:predicates (alive ?character - character)
               (scary ?monster - monster)
               (beautiful ?character - character)
               (confined ?character - character)
               (single ?character - character)
               (married ?character - character)
               (at ?character - character ?place - place)
               (in ?genie - genie ?magic-lamp - magic-lamp)
               (has ?character - character ?thing - thing)
               (loyal-to ?knight - knight ?king - king)
               (controls ?character - character ?genie - genie)
               (loves ?lover - character ?love-interest - character)
               (married-to ?character1 - character ?character2 - character))

  ;; A character moves from one location to another.
  (:action go
    :parameters   (?character - character ?from - place ?to - place)
	:precondition (and (not (= ?from ?to))
                       (alive ?character)
                       (at ?character ?from))
	:effect       (and (not (at ?character ?from))
                       (at ?character ?to))
    :agents       (?character))

  ;; A character slays a monster.
  (:action slay
    :parameters   (?knight - knight ?monster - monster ?place - place)
    :precondition (and (alive ?knight)
                       (at ?knight ?place)
                       (alive ?monster)
                       (at ?monster ?place))
    :effect       (not (alive ?monster))
    :agents       (?knight))

  ;; One character takes an item from the corpse of another.
  (:action pillage
    :parameters   (?pillager - character ?victim - character ?thing - thing ?place - place)
    :precondition (and (alive ?pillager)
                       (at ?pillager ?place)
                       (not (alive ?victim))
                       (at ?victim ?place)
                       (has ?victim ?thing))
    :effect       (and (not (has ?victim ?thing))
                       (has ?pillager ?thing))
    :agents       (?pillager))

  ;; One character gives an item to another.
  (:action give
    :parameters   (?giver - character ?recipient - character ?thing - thing ?place - place)
    :precondition (and (not (= ?giver ?recipient))
                       (alive ?giver)
                       (at ?giver ?place)
                       (has ?giver ?thing)
                       (alive ?recipient)
                       (at ?recipient ?place))
    :effect       (and (not (has ?giver ?thing))
                       (has ?recipient ?thing))
    :agents       (?giver))

  ;; A character summons a genie from a magic lamp.
  (:action summon
    :parameters   (?character - character ?genie - genie ?lamp - magic-lamp ?place - place)
    :precondition (and (alive ?character)
                       (at ?character ?place)
                       (has ?character ?lamp)
                       (alive ?genie)
                       (in ?genie ?lamp))
    :effect       (and (not (confined ?genie))
                       (not (in ?genie ?lamp))
                       (at ?genie ?place)
                       (controls ?character ?genie))
    :agents       (?character))

  ;; A genie causes one character to fall in love with another.
  (:action love-spell
    :parameters   (?genie - genie ?target - character ?lover - character)
    :precondition (and (not (= ?target ?lover))
                       (not (= ?genie ?target))
                       (not (= ?genie ?lover))
                       (alive ?genie)
                       (not (confined ?genie))
                       (alive ?target)
                       (alive ?lover)
                       (not (loves ?target ?lover)))
    :effect       (and (loves ?target ?lover)
                       (intends ?target (married-to ?target ?lover)))
    :agents       (?genie))

  ;; Two characters who are in love get married.
  (:action marry
    :parameters   (?groom - male ?bride - female ?place - place)
    :precondition (and (alive ?groom)
                       (at ?groom ?place)
                       (loves ?groom ?bride)
                       (alive ?bride)
                       (at ?bride ?place)
                       (loves ?bride ?groom))
    :effect       (and (not (single ?groom))
                       (married ?groom)
                       (married-to ?groom ?bride)
                       (not (single ?bride))
                       (married ?bride)
                       (married-to ?bride ?groom))
    :agents       (?groom ?bride))

  ;; One character falls in love with another.
  (:action fall-in-love
    :parameters   (?male - male ?female - female ?place - place)
    :precondition (and (alive ?male)
                       (single ?male)
                       (at ?male ?place)
                       (not (loves ?male ?female))
                       (alive ?female)
                       (beautiful ?female)
                       (single ?female)
                       (at ?female ?place))
    :effect       (and (loves ?male ?female)
                       (intends ?male (married-to ?male ?female))))

  ;; A character delegates a goal to a subordinate.
  (:action order
    :parameters   (?king - king ?knight - knight ?place - place ?objective - expression)
    :precondition (and (alive ?king)
                       (at ?king ?place)
                       (alive ?knight)
                       (at ?knight ?place)
                       (loyal-to ?knight ?king))
    :effect       (and (intends ?knight ?objective)
                       (delegated ?king ?objective ?knight))
    :agents       (?king))

  ;; A character delegates a goal to a genie.
  (:action command
    :parameters   (?character - character ?genie - genie ?lamp - magic-lamp ?objective - expression)
    :precondition (and (not (= ?character ?genie))
                       (alive ?character)
                       (has ?character ?lamp)
                       (controls ?character ?genie)
                       (alive ?genie))
    :effect       (and (intends ?genie ?objective)
                       (delegated ?character ?objective ?genie))
    :agents       (?character))

  ;; A monster appears threatening.
  (:action appear-threatening
    :parameters   (?monster - monster ?character - character ?place - place)
    :precondition (and (not (= ?monster ?character))
                       (scary ?monster)
                       (at ?monster ?place)
                       (at ?character ?place))
    :effect       (intends ?character (not (alive ?monster)))))