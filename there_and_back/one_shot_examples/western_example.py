from there_and_back.one_shot_examples.story_scaffold import StoryScaffold

domain = """
(define (domain western)
  (:requirements :adl :intentionality)
  (:types ; People and animals are living things.
          person animal - living
          ; Animals are items that can be owned.
          animal - item
          ; Some items are valuable.
          valuable - item
          ; Places exist.
          place
          ; Sicknesses exist
          sickness)
  (:constants ; A place to imprison criminals
              jailhouse - place
              ; The "sickness" of being bitten by a poisonous snake
              snakebite - sickness)
  (:predicates ; A person is alive.
               (alive ?person - person)
               ; A person is not restrained.
               (free ?person - person)
               ; A person is the sheriff.
               (sheriff ?person - person)
               ; A person or thing is at a place.
               (at ?object - object ?place - place)
               ; An item belongs to a person.
               (belongsto ?item - item ?person - person)
               ; A person has an item.
               (has ?person - person ?item - item)
               ; A person is sick with some kind of sickness.
               (sick ?person - person ?sickness - sickness)
               ; An item can cure a sickness.
               (cures ?item - item ?sickness - sickness)
               ; One person loves another.
               (loves ?lover - person ?love - person))

  ; A character gets bitten by a rattlesnake and becomes sick.
  (:action snakebite
    :parameters   (?victim - person)
    :precondition (alive ?victim)
    :effect       (and (sick ?victim snakebite)
                       (intends ?victim (not (sick ?victim snakebite)))
                       (forall (?p - person)
                               (when (loves ?p ?victim)
                                     (intends ?p (not (sick ?victim snakebite)))))))

  ; A character dies of dies of some sickness.
  (:action die
    :parameters   (?person - person ?sickness - sickness)
    :precondition (and (alive ?person)
                       (sick ?person ?sickness))
    :effect       (not (alive ?person)))

  ; A character travels from one location to another.
  (:action travel
    :parameters   (?person - person ?from - place ?to - place)
    :precondition (and (alive ?person)
                       (free ?person)
                       (at ?person ?from))
    :effect       (and (at ?person ?to)
                       (not (at ?person ?from)))
    :agents       (?person))

  ; A character forces a tied up character to move from one place to another.
  (:action forcetravel
    :parameters   (?person - person ?victim - person ?from - place ?to - place)
    :precondition (and (alive ?person)
                       (free ?person)
                       (at ?person ?from)
                       (alive ?victim)
                       (not (free ?victim))
                       (at ?victim ?from))
    :effect       (and (at ?person ?to)
                       (not (at ?person ?from))
                       (at ?victim ?to)
                       (not (at ?victim ?from)))
    :agents       (?person))

  ; One character gives an item to another.
  (:action give
    :parameters   (?giver - person ?receiver - person ?item - item ?place - place)
    :consent      (?giver ?receiver)
    :precondition (and (alive ?giver)
                       (free ?giver)
                       (at ?giver ?place)
                       (has ?giver ?item)
                       (alive ?receiver)
                       (free ?receiver)
                       (at ?receiver ?place))
    :effect       (and (has ?receiver ?item)
                       (not (has ?giver ?item))
                       (when (belongsto ?item ?giver)
                             (belongsto ?item ?receiver)))
    :agents       (?giver))

  ; One character ties up another.
  (:action tieup
    :parameters   (?person - person ?victim - person ?place - place)
    :precondition (and (alive ?person)
                       (free ?person)
                       (at ?person ?place)
                       (alive ?victim)
                       (at ?victim ?place))
    :effect       (and (not (free ?victim))
                       (intends ?victim (free ?victim)))
    :agents       (?person))

  ; One character unties another.
  (:action untie
    :parameters   (?person - person ?victim - person ?place - place)
    :precondition (and (alive ?person)
                       (free ?person)
                       (at ?person ?place)
                       (alive ?victim)
                       (not (free ?victim))
                       (at ?victim ?place))
    :effect       (free ?victim)
    :agents       (?person))

  ; One character takes an item from a tied up character.
  (:action take
    :parameters   (?taker - person ?item - item ?victim - person ?place - place)
    :precondition (and (not (= ?taker ?victim))
                       (alive ?taker)
                       (free ?taker)
                       (at ?taker ?place)
                       (alive ?victim)
                       (not (free ?victim))
                       (at ?victim ?place)
                       (has ?victim ?item))
    :effect       (and (has ?taker ?item)
                       (not (has ?victim ?item))
                       (when (belongsto ?item ?victim)
                             (and (intends ?victim (has ?victim ?item))
                                  (forall (?s - person)
                                          (when (sheriff ?s)
                                                (intends ?s (and (at ?taker jailhouse)
                                                                 (not (free ?taker))
                                                                 (has ?victim ?item)
                                                                 (free ?victim))))))))
    :agents       (?taker))

  ; One character uses medicine to heal a sick character.
  (:action heal
    :parameters   (?healer - person ?patient - person ?sickness - sickness ?medicine - item ?place - place)
    :precondition (and (cures ?medicine ?sickness)
                       (alive ?healer)
                       (free ?healer)
                       (at ?healer ?place)
                       (has ?healer ?medicine)
                       (alive ?patient)
                       (at ?patient ?place)
                       (sick ?patient ?sickness))
    :effect       (and (not (sick ?patient ?sickness))
                       (not (has ?healer ?medicine)))
    :agents       (?healer ?patient)))
"""

problem = """
(define (problem robbery)
  (:domain western)
  ; All the people, places, and things in the problem
  (:objects
     ; A saloon
     saloon - place
     ; Hank's ranch
     ranch - place
     ; The town general store
     generalstore - place
     ; Hank, a cattle rancher
     hank - person
     ; Timmy, Hank's son.
     timmy - person
     ; Will, the sheriff
     will - person
     ; Carl, the shopkeeper.
     carl - person
     ; Antivenom to cure a snakebite
     antivenom - item)
  ; Initial state of the world
  (:init
     ; Hank lives on his ranch and loves his son.
     (alive hank)
     (free hank)
     (at hank ranch)
     (loves hank timmy)
     ; Timmy is Hank's son, and also lives at the ranch.
     (alive timmy)
     (free timmy)
     (at timmy ranch)
     (loves timmy hank)
     ; Will is the sheriff.  He is waiting at the saloon, plotting the downfall of all lawbreakers.
     (alive will)
     (free will)
     (at will saloon)
     (sheriff will)
     ; Carl is the manager of the town general store.
     (alive carl)
     (free carl)
     (at carl generalstore)
     (has carl antivenom)
     (intends carl (has carl antivenom))
     ; Antivenom cures a snakebite.
     (cures antivenom snakebite)
   )
  ; Goal state: Timmy is dead even though Hank has the antivenom.
  (:goal (and
            (not (alive timmy))
            (has hank antivenom))))
"""


solution = """
(define (plan robbery-solution)
  (:problem robbery)
  (:steps (snakebite timmy)
          (travel hank ranch generalstore)
          (tieup hank carl generalstore)
          (take hank antivenom carl generalstore)
          (die timmy snakebite)
          (non-executed (travel timmy ranch generalstore))
          (snakebite hank)
          (non-executed (heal hank timmy snakebite antivenom generalstore))))
"""

story = """
Hank didn't have a lot of money, but he had a lot of love for his son Timmy. They lived together on their ranch, where they raised cattle.  Hank was a good father, and Timmy a good son. So when, late one evening under the rising harvest moon, Timmy was bitten by a rattlesnake, Hank was very worried. He knew that Timmy would die if he didn't get some antivenom soon. But the nearest antivenom was at the general store, and Hank didn't have enough money to buy it.  He knew that Carl, the shopkeeper, would never give it to him for free. So Hank decided to steal it.

He told Timmy to stay put, and tasked one of his farmhands with his comfort. Then he saddled up his best horse and rode to town. He wasted no time, with a father's instinct he blew open the door to the general store where Carl, an old rival of his, was drinking whiskey. "Carl!" he yelled to confuse him. "I'm here to rob you!" With a quick draw, he shot Carl in the leg. Carl fell to the ground, and Hank tied him up.  He took the antivenom and set off back to the ranch.

When he got back, a stillness hung in the air, told him all he needed to know. Timmy was dead.  He had been bitten by the snake too long ago, and the antivenom had come too late. He dropped to the floor weeping, and as he lay there, a snake slithered out, glistening in the moon. It bared it's fangs with a dutifull hiss and sunk them into Hank's leg.
"""

prompt = """
The story takes place in a western setting. Hank, Timmy, Will, and Carl all live in a small town with a general store and saloon. Timmy is Hank's son and they love each other a lot. They live together on their ranch. Will is at his general store, where they sell goods like antivenom, which can cure a snake bite. Carl is at the saloon.

The key events in the story should consist of the following: characters can get poisoned from snake bite, die from sickness, travel between places, force each other to travel, give and take items from each other, tie each other up, and untie each other. Characters that are tied up are not free.

The story should end with Timmy dead, but Hank in posession of the antivenom.
"""

western_example = StoryScaffold(
    domain=domain,
    problem=problem,
    solution=solution,
    story=story,
    conditions_prompt=prompt
)