from there_and_back.one_shot_examples.story_scaffold import StoryScaffold


# ark-example with a more declarative story, for use with decompose

domain = """
(define (domain indiana-jones-ark)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object weapon - item)
  (:constants ark - item)
  (:predicates
    (open ark)
    (alive ?character - character)
    (armed ?character - character)
    (buried ?item - item ?place - place)
    (knows-location ?character - character ?item - item ?place - place)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
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

  ;; A character excavates an item.
  (:action excavate
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (buried ?item ?place)
      (knows-location ?character ?item ?place))
    :effect
      (and (not (buried ?item ?place))
      (has ?character ?item))
    :agents  (?character)
  )

  ;; One character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (at ?giver ?place)
      (has ?giver ?item)
      (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; One character kills another.
  (:action kill
    :parameters
      (?killer - character ?weapon - weapon ?victim - character ?place - place)
    :precondition
      (and (alive ?killer)
      (at ?killer ?place)
      (has ?killer ?weapon)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; One character takes an item from another at weapon-point.
  (:action take
    :parameters
      (?taker - character ?item - item ?victim - character ?place - place)
    :precondition
      (and (not (= ?taker ?victim))
      (alive ?taker)
      (at ?taker ?place)
      (or (not (alive ?victim))
      (and (armed ?taker)
      (not (armed ?victim))))
      (at ?victim ?place)
      (has ?victim ?item))
    :effect
      (and (not (has ?victim ?item))
      (has ?taker ?item))
    :agents
      (?taker)
  )

  ;; A character opens the Ark.
  (:action open-ark
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has ?character ark))
    :effect
      (and (open ark)
      (not (alive ?character)))
    :agents
      (?character)
  )

  ;; The Ark closes.
  (:action close-ark
    :precondition
      (open ark)
    :effect
      (not (open ark))
  )

  ;; When a character has a weapon, they are armed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (armed ?character))
      (exists (?w - weapon)
      (has ?character ?w)))
    :implies
      (armed ?character)
  )

  ;; When a character does not have a weapon, they are unarmed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (armed ?character)
      (forall (?w - weapon)
      (not (has ?character ?w))))
    :implies
      (not (armed ?character))
  )
)
"""

problem = """
(define (problem get-ark)
  (:domain
    indiana-jones-ark)
  (:objects
    indiana nazis army - character
    usa tanis - place
    gun - weapon)
  (:init
    (buried ark tanis)
    (alive indiana)
    (at indiana usa)
    (knows-location indiana ark tanis)
    (intends indiana (alive indiana))
    (intends indiana (has army ark))
    (alive army)
    (at army usa)
    (intends army (alive army))
    (intends army (has army ark))
    (alive nazis)
    (at nazis tanis)
    (intends nazis (alive nazis))
    (intends nazis (open ark))
    (has nazis gun))
  (:goal
    (and (at army usa)
    (has army ark)
    (not (alive nazis)))
  )
)
"""

solution = """
(define (plan get-ark-solution)
(:problem get-ark)
  (:steps
    (start)
    (travel indiana usa tanis)
    (excavate indiana ark tanis)
    (travel indiana tanis usa)
    (non-executed (give indiana ark army usa))
    (travel nazis tanis usa)
    (take nazis ark indiana usa)
    (open-ark nazis)
    (take army ark nazis usa)
    (end)
  )
)
"""

story = """
Once upon a time, Indiana Jones was on a mission from the army to retrieve the Ark of the Covenant. They were up against the Nazis who were also after the Ark.

Indiana and the army started their journey from the United States and traveled to Tanis. Indiana was able to excavate the priceless artifact. However, they were not alone. The Nazis had also arrived at the site and were waiting for the right moment to strike.

Indiana and the army quickly left Tanis and headed back to the United States with the Ark. He insisted on carrying the ark with him on the flight, and as he was about to hand it over, they were ambushed by the Nazis who had followed them back. The Nazis demanded that Indiana hand over the Ark, but he refused.

A fight broke out between the two groups, and the Nazis, using their weapons and wiles, managed to wrestle Indiana to the ground and wrangle the Ark from his hands. Immediately, they unlock the Ark and open it.

The power of the Ark was unleashed, and the Nazis were destroyed. The Army took possession of the Ark. The mission was a success, and the Ark was now in the hands of the good guys. Indiana and Army had saved the world from the evil intentions of the Nazis, and they were hailed as heroes.
"""

ark_example = StoryScaffold(
  domain=domain, problem=problem, solution=solution,
  story=story
)

