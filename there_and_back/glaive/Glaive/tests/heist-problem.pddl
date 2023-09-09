;;;
;;; A problem for telling a story about an evil bank robber in the Wild West
;;; Originally created by James Niehaus for his dissertation
;;; Adapted and corrected by Stephen G. Ware
;;;
(define (problem do-heist)
  (:domain heist)
  (:objects ;; People
            robbie - evil
            tom - sheriff
            sally - mobile
            barney - guard
            horse-seller - seller
            pawn-broker - pawn-broker
            jill - person
            anne - person
            child - person
            ;; Places
            bank - bank
            main-street - place
            saloon - bar
            dress-shop - place
            sheriffs-office - place
            sallys-home - place
            dark-alley - alley
            barber-shop - place
            barneys-room - place
            general-store - store
            out-of-town - place
            ;; Things
            mother-lode - mother-lode
            six-shooter - gun
            dress-money - money
            tomato-money - money
            poker-money - money
            locket-money - big-money
            brown-horse - horse
            white-horse - horse
            locket - valuable
            handcuffs - cuffs
            tomatoes - small-goods
            blue-dress - valuable
            poker-game - poker-game)
  (:init ;; Map
         (connected bank main-street)
         (connected main-street bank)
         (connected saloon main-street)
         (connected main-street saloon)
         (connected dress-shop main-street)
         (connected main-street dress-shop)
         (connected sheriffs-office main-street)
         (connected main-street sheriffs-office)
         (connected sallys-home main-street)
         (connected main-street sallys-home)
         (connected dark-alley main-street)
         (connected main-street dark-alley)
         (alley-of dark-alley main-street)
         (connected barber-shop main-street)
         (connected main-street barber-shop)
         (connected sheriffs-office barber-shop)
         (connected barber-shop sheriffs-office)
         (connected barneys-room saloon)
         (connected general-store main-street)
         (connected main-street general-store)
         (connected barber-shop out-of-town)
         (connected bank out-of-town)
         ;; Where things are.
         (has bank mother-lode)
         (has bank dress-money)
         (has barney six-shooter)
         (has horse-seller brown-horse)
         (has tom white-horse)
         (at white-horse barber-shop)
         (has pawn-broker locket-money)
         (has robbie locket)
         (at handcuffs sheriffs-office)
         (has sally tomatoes)
         (has anne tomato-money)
         (forsale blue-dress general-store)
         (at poker-game saloon)
         (bet-at poker-money poker-game)
         ;; Locations
         (at robbie main-street)
         (at sally main-street)
         (at tom sheriffs-office)
         (at barney barneys-room)
         (at horse-seller main-street)
         (at brown-horse main-street)
         (at pawn-broker main-street)
         (at jill general-store)
         (at anne main-street)
         (at child main-street)
         ;; Misc.
         (guard-of barney bank)
         (blocking child dark-alley)
         ;; Intentions
         (intends robbie (has robbie poker-money))
         (intends sally (has sally blue-dress))
         (intends barney (at barney saloon)))
  (:goal (arrested tom robbie)))