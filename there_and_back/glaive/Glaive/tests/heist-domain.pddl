;;;
;;; A domain for telling a story about an evil bank robber in the Wild West
;;; Originally created by James Niehaus for his dissertation
;;; Adapted and corrected by Stephen G. Ware
;;;
(define (domain heist)
  (:requirements :adl :intentionality)
  (:types mobile bystanders seller pawn-broker - person
          evil sheriff guard - mobile
          bank bar store alley - place
          big-money mother-lode - money
          gun cuffs small-goods valuable money - thing
		  horse - valuable
          poker-game)
  (:predicates (connected ?from - place ?to - place)
               (alley-of ?alley - alley ?place - place)
               (at ?thing - thing ?place - place)
               (at ?person - person ?place - place)
               (at ?poker-game - poker-game ?place - place)
               (has ?person - person ?thing - thing)
               (has ?bank - bank ?money - money)
               (open ?store - store)
               (forsale ?thing - thing ?store - store)
               (hidden ?person - person)
               (drunk ?person - person)
               (sleeping ?person - person)
               (in-cuffs ?person - person ?cuffs - cuffs)
               (free-with-money ?person - person)
               (friendly ?friend - person ?person - person)
               (blocking ?person - person ?alley - alley)
               (guard-of ?person - person ?place - place)
               (guarded ?place - place)
               (bet-at ?money - money ?poker-game - poker-game)
               (held-up ?person - person ?bank - bank)
               (arrested ?sheriff - sheriff ?person - person))

  ;; Pick something up.
  (:action pick-up
    :parameters   (?person - person ?thing - thing ?place - place)
    :precondition (and (at ?person ?place)
                       (at ?thing ?place))
    :effect       (and (not (at ?thing ?place))
                       (has ?person ?thing))
    :agents       (?person))

  ;; Pick up and holster a gun.
  (:action holster-gun
    :parameters   (?person - person ?gun - gun ?place - place)
    :precondition (and (at ?person ?place)
                       (at ?gun ?place))
    :effect       (and (not (at ?gun ?place))
                       (has ?person ?gun))
    :agents       (?person))

  ;; Withdraw some money from the bank.
  (:action withdraw-money
    :parameters   (?person - person ?bank - bank ?money - money)
    :precondition (and (at ?person ?bank)
                       (has ?bank ?money))
    :effect       (and (not (has ?bank ?money))
                       (has ?person ?money))
    :agents       (?person))

  ;; Open a store for business.
  (:action open
    :parameters   (?person - person ?store - store)
    :precondition (at ?person ?store)
    :effect       (open ?store))

  ;; Sell some small goods.
  (:action sell
    :parameters   (?person - person ?buyer - person ?thing - small-goods ?money - money ?place - place)
    :precondition (and (at ?person ?place)
                       (has ?person ?thing)
                       (at ?buyer ?place)
                       (has ?buyer ?money))
    :effect       (and (not (has ?person ?thing))
                       (has ?person ?money)
                       (not (has ?buyer ?money))
                       (has ?buyer ?thing))
    :agents       (?person))

  ;; Buy a dress (or other good) from a store.
  (:action buy-dress
    :parameters   (?person - person ?thing - valuable ?store - store ?money - money)
    :precondition (and (open ?store)
                       (forsale ?thing ?store)
                       (at ?person ?store)
                       (has ?person ?money))
    :effect       (and (has ?person ?thing)
                       (not (forsale ?thing ?store))
                       (not (has ?person ?money)))
    :agents       (?person))

  ;; Fail to buy a dress (or other good) from a store because of no money.
  (:action fail-buy-dress
    :parameters   (?person - person ?thing - valuable ?store - store ?money - money)
    :precondition (and (open ?store)
                       (forsale ?thing ?store)
                       (at ?person ?store)
                       (not (has ?person ?money)))
    :agents       (?person))

  ;; kick someone out of the way.
  (:action kick-out-of-way
    :parameters   (?person - evil ?roadblock - person ?alley - alley ?place - place)
    :precondition (and (at ?person ?place)
                       (at ?roadblock ?place)
                       (blocking ?roadblock ?alley))
    :effect       (not (blocking ?roadblock ?alley))
    :agents       (?person))

  ;; Hatch a plan to rob the bank.
  (:action hatch-plan
    :parameters   (?person - evil ?gun - gun ?horse - horse ?bank - bank ?mother-lode - mother-lode)
    :precondition (has ?bank ?mother-lode)
    :effect       (and (not (has ?person ?mother-lode))
                       (intends ?person (has ?person ?gun))
                       (intends ?person (has ?person ?horse))
                       (intends ?person (has ?person ?mother-lode))
                       (intends ?person (free-with-money ?person))))

  ;; Hide in an alley.
  (:action hide-in-dark-alley
    :parameters   (?person - evil ?alley - alley)
    :precondition (at ?person ?alley)
    :effect       (hidden ?person)
    :agents       (?person))

  ;; Pickpocket.
  (:action pickpocket
    :parameters   (?person - evil ?mark - person ?money - money ?place - place ?alley - alley)
    :precondition (and (alley-of ?alley ?place)
                       (at ?person ?alley)
                       (at ?mark ?place)
                       (hidden ?person)
                       (has ?mark ?money))
    :effect       (and (has ?person ?money)
                       (not (has ?mark ?money))
                       (not (hidden ?person)))
    :agents       (?person))

  ;; Move.
  (:action move-once
    :parameters   (?person - mobile ?from - place ?to - place)
    :precondition (and (connected ?from ?to)
                       (at ?person ?from))
    :effect       (and (at ?person ?to)
                       (not (at ?person ?from)))
    :agents       (?person))

  ;; Buy drinks for (and get drunk).
  (:action buy-drinks-for
    :parameters   (?person - person ?drinker - person ?money - money ?place - bar)
    :precondition (and (at ?person ?place)
                       (at ?drinker ?place)
                       (has ?person ?money))
    :effect       (and (friendly ?drinker ?person)
                       (drunk ?drinker))
    :agents       (?person))

  ;; Cheat at a poker game (put up some money).
  (:action cheat-at-poker
    :parameters   (?person - evil ?poker - poker-game ?money - money ?winnings - money ?place - place)
    :precondition (and (at ?person ?place)
                       (at ?poker ?place)
                       (has ?person ?money)
                       (bet-at ?winnings ?poker))
    :effect       (has ?person ?winnings)
    :agents       (?person))

  ;; Leave with.
  (:action escort-drunk-friend
    :parameters   (?person - person ?friend - person ?from - place ?to - place)
    :precondition (and (connected ?from ?to)
                       (at ?person ?from)
                       (at ?friend ?from)
                       (drunk ?friend)
                       (friendly ?friend ?person))
    :effect       (and (not (at ?person ?from))
                       (at ?person ?to)
                       (not (at ?friend ?from))
                       (at ?friend ?to))
    :agents       (?person))

  ;; Lay to rest in alley.
  (:action lay-to-rest-in-alley
    :parameters   (?person - person ?friend - guard ?place - alley ?bank - bank)
    :precondition (and (at ?person ?place)
                       (at ?friend ?place)
                       (drunk ?friend)
                       (friendly ?friend ?person)
                       (guard-of ?friend ?bank))
    :effect       (and (sleeping ?friend)
                       (not (guarded ?bank)))
    :agents       (?person))

  ;; Take item off sleeping person,
  (:action take-thing-off-sleeper
    :parameters   (?person - person ?sleeper - person ?thing - thing ?place - alley)
    :precondition (and (at ?person ?place)
                       (at ?sleeper ?place)
                       (sleeping ?sleeper)
                       (has ?sleeper ?thing))
    :effect       (and (has ?person ?thing)
                       (not (has ?sleeper ?thing)))
    :agents       (?person))

  ;; Pawn a valuable for money.
  (:action pawn-valuable
    :parameters   (?person - person ?pawn-broker - pawn-broker ?thing - valuable ?place - place ?big-money - big-money)
    :precondition (and (at ?person ?place)
                       (at ?pawn-broker ?place)
                       (has ?person ?thing)
                       (has ?pawn-broker ?big-money))
    :effect       (and (not (has ?person ?thing))
                       (has ?pawn-broker ?thing)
                       (has ?person ?big-money))
    :agents       (?person))

  ;; Buy a horse.
  (:action buy-valuable
    :parameters   (?person - person ?seller - seller ?thing - valuable ?place - place ?big-money - big-money)
    :precondition (and (has ?seller ?thing)
                       (at ?person ?place)
                       (at ?seller ?place)
                       (has ?person ?big-money))
    :effect       (and (has ?person ?thing)
                       (not (has ?seller ?thing))
                       (not (has ?person ?big-money)))
    :agents       (?person))

  ;; Ride a horse to a location.
  (:action ride-horse-to
    :parameters   (?person - mobile ?horse - horse ?from - place ?to - place)
    :precondition (and (connected ?from ?to)
                       (at ?person ?from)
                       (at ?horse ?from)
                       (has ?person ?horse))
    :effect       (and (at ?person ?to)
                       (not (at ?person ?from))
                       (at ?horse ?to)
                       (not (at ?horse ?from)))
    :agents       (?person))

  ;; Hold up a bank.
  (:action hold-up-bank
    :parameters   (?person - evil ?gun - gun ?bank - bank ?sheriff - sheriff)
    :precondition (and (at ?person ?bank)
                       (has ?person ?gun)
                       (not (guarded ?bank)))
    :effect       (and (held-up ?person ?bank)
                       (intends ?sheriff (arrested ?sheriff ?person)))
    :agents       (?person))

  ;; Collect money.
  (:action collect-money-from-heist
    :parameters   (?person - evil ?bank - bank ?mother-lode - mother-lode)
    :precondition (and (at ?person ?bank)
                       (held-up ?person ?bank)
                       (has ?bank ?mother-lode))
    :effect       (and (has ?person ?mother-lode)
                       (not (held-up ?person ?bank))
                       (not (has ?bank ?mother-lode)))
    :agents       (?person))

  ;; Getaway with stolen money.
  (:action getaway-with-money
    :parameters   (?person - evil ?mother-lode - mother-lode ?horse - horse ?place - place ?dest - place)
    :precondition (and (connected ?place ?dest)
                       (at ?person ?place)
                       (at ?horse ?place)
                       (has ?person ?mother-lode))
    :effect       (and (not (at ?person ?place))
                       (not (at ?horse ?place))
                       (free-with-money ?person)
                       (at ?person ?dest))
    :agents       (?person))

;  ;; Bystanders sound alarm.
;  (:action alert-sheriff
;    :parameters   (?person - evil ?bystanders - bystanders ?sheriff - sheriff ?bank - bank)
;    :precondition (and (at ?person ?bank)
;                       (held-up ?person ?bank))
;    :effect       (knows ?sheriff (held-up ?person ?bank)))

  ;; Arrest.
  (:action arrest
    :parameters   (?criminal - evil ?sheriff - sheriff ?place - place ?cuffs - cuffs ?money - money)
    :precondition (and (at ?sheriff ?place)
                       (at ?criminal ?place)
                       (has ?sheriff ?cuffs)
                       (has ?criminal ?money))
    :effect       (and (arrested ?sheriff ?criminal)
                       (in-cuffs ?criminal ?cuffs)
                       (has ?sheriff ?money)
                       (not (has ?criminal ?money)))
    :agents       (?sheriff)))