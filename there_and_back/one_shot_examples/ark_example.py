from there_and_back.one_shot_examples.story_scaffold import StoryScaffold

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
The Nazis, in their holy quest for world domination, were looking for the Ark of the Covenant. They believed that it would grant them supernatural powers and help them win the war.

The U.S., with spies everywhere, got wind of this and turned to Indiana Jones, renowned professor of archaeology, who happened to know the location of the ark in Tanis.

Indiana, after very little convincing, started his journey with the Army from the U.S. to Tanis. They quickly pinpointed the location of the ark (exactly where Indy had predicted), and began to dig. Nazi influence in that region was already quite strong, and it quickly got back through their network. Indiana, unearthing an ancient cask from an inconspicuous burial site, felt confident that the mission was nearly complete. He was casual in travelling back to the U.S. and didn't take the necessary precautions to avoid being followed.

The Nazis, with their own spies, were on the tarmac by the time he landed, out of place on American soil. They took the ark from him at gunpoint, and took it to a secret location. They opened it, and were immediately killed by the wrath of God. The ark was then taken by the Army, and stored in a warehouse, where it probably sits to this day (unless it was stolen by aliens).
"""

prompt = """
This story takes place in 1936. Indiana is an archaelogist and adventurer at a college in the U.S.. Indy knows the location of the Ark of the Covenant in Tanis. He wants the army to have the ark. the Army is also in the U.S. and wants to obtain the ark in order to stop the Nazis from aquiring it. The Nazis believe its holy power will help them win the war. The Nazis are already in Tanis but do not know the location of the ark. The Nazis have a gun. They want to open it, not knowing that whoever is at the location it is opened will be killed.

The key events in the story should consist of the following: characters can travel from one location to another, characters can excavate buried objects if they know their location, characters can give items from one to another, characters can kill one another if the killer is armed and they are colocated, an armed character can take an item from a colocated character, a character can open the ark if they have it (at which point all characters at that location will die), and the ark can close by itself.
"""

ark_example = StoryScaffold(
  domain=domain, problem=problem, solution=solution,
  story=story, conditions_prompt=prompt
)

