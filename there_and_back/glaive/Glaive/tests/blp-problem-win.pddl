;;;
;;; The characters, objects, and things in the interactive narrative adventure game The Best Laid Plans
;;; Goal: goblin gets the tonic and returns to the tower
;;; Created by Stephen G. Ware
;;;
(define (problem win)
  (:domain goblin)
  (:objects ; Characters
            goblin - protagonist
            bandit - humanoid
            guard - guard
            merchant - merchant
            chemist - merchant
            barkeep - merchant
            crocodile - predator
            witch - merchant
            troll - humanoid
            wolf - predator
            ; Locations
            tower - location
            crossroads - location
            bridge - location
            junction - location
            camp - location
            town - location
            shop - location
            tavern - location
            alley - location
            sewer - location
            bog - location
            clearing - location
            caveLedge - location
            cave - location
            forest - location
            ; Items
            tonic - item
            ; Money
            money_1 - money
            money_2 - money
            spell_money - money
            ; Weapons
            sword_1 - weapon
            sword_2 - weapon
            sword_3 - weapon
            ; Lights
            torch - light
            spell_torch_1 - light
            spell_torch_2 - light
            ; Food
            ale - food
            ; Poison
            nightshade - poison
            ; Spells
            light_spell_1 - light_spell
            light_spell_2 - light_spell
            alchemy_spell_1 - alchemy_spell
            kill_spell_1 - kill_spell
            teleport_spell_1 - teleport_spell)
  (:init ; Map
         (path tower crossroads) (path crossroads tower)
         (path crossroads bridge) (path bridge crossroads)
         (path bridge junction) (path junction bridge)
         (path junction camp) (path camp junction)
         (path junction town) (path town junction)
         (path town shop) (path shop town)
         (path town tavern) (path tavern town)
         (path town alley) (path alley town)
         (dark sewer)
         (path alley sewer) (path sewer alley)
         (path sewer bog) (path bog sewer)
         (path bog clearing) (path clearing bog)
         (path clearing caveLedge) (path caveLedge clearing)
         (dark cave)
         (path caveLedge cave) (path cave caveLedge)
         (path clearing forest) (path forest clearing)
         (path forest crossroads) (path crossroads forest)
         ; Goblin
         (alive goblin)
         (knows-location goblin tower)
         (knows-location goblin crossroads)
         (knows-location goblin bridge)
         (knows-location goblin junction)
         (knows-location goblin camp)
         (knows-location goblin town)
         (knows-location goblin shop)
         (knows-location goblin tavern)
         (knows-location goblin alley)
         (knows-location goblin sewer)
         (knows-location goblin bog)
         (knows-location goblin clearing)
         (knows-location goblin caveLedge)
         (knows-location goblin cave)
         (knows-location goblin forest)
         (at goblin tower)
         (has goblin money_1)
         (intends goblin (alive goblin))
         (intends goblin (and (at goblin tower)
                              (has goblin tonic)))
         ; Bandit
         (alive bandit)
         (knows-location bandit camp)
         (knows-location bandit junction)
         (knows-location bandit bridge)
         (knows-location bandit town)
         (at bandit camp)
         (has bandit sword_1)
         (owns bandit sword_1)
         (at money_2 camp)
         (owns bandit money_2)
         (criminal bandit)
         (intends bandit (alive bandit))
         (intends bandit (has bandit tonic))
         ; Guard
         (alive guard)
         (knows-location guard town)
         (knows-location guard shop)
         (at guard town)
         (has guard sword_2)
         (owns guard sword_2)
         (citizen guard)
         (guard guard)
         (hungry guard)
         (intends guard (alive guard))
         (intends guard (not (hungry guard)))
         ; Merchant
         (alive merchant)
         (knows-location merchant town)
         (at merchant town)
         (buying merchant money_1)
         (buying merchant money_2)
         (buying merchant spell_money)
         (selling merchant sword_3)
         (at sword_3 town)
         (owns merchant sword_3)
         (citizen merchant)
         (intends merchant (alive merchant))
         ; Chemist
         (alive chemist)
         (knows-location chemist shop)
         (at chemist shop)
         (buying chemist money_1)
         (buying chemist money_2)
         (buying chemist spell_money)
         (selling chemist tonic)
         (owns chemist tonic)
         (at tonic shop)
         (selling chemist light_spell_1)
         (owns chemist light_spell_1)
         (at light_spell_1 shop)
         (selling chemist alchemy_spell_1)
         (owns chemist alchemy_spell_1)
         (at alchemy_spell_1 shop)
         (selling chemist teleport_spell_1)
         (owns chemist teleport_spell_1)
         (at teleport_spell_1 shop)
         (citizen chemist)
         (intends chemist (alive chemist))
         ; Barkeep
         (alive barkeep)
         (knows-location barkeep tavern)
         (at barkeep tavern)
         (buying barkeep money_1)
         (buying barkeep money_2)
         (buying barkeep spell_money)
         (selling barkeep ale)
         (owns barkeep ale)
         (at ale tavern)
         (citizen barkeep)
         (intends barkeep (alive barkeep))
         ; Crocodile
         (alive crocodile)
         (knows-location crocodile sewer)
         (knows-location crocodile bog)
         (knows-location crocodile alley)
         (at crocodile sewer)
         (intends crocodile (alive crocodile))
         ; Witch
         (alive witch)
         (knows-location witch bog)
         (at witch bog)
         (buying witch nightshade)
         (selling witch light_spell_2)
         (owns witch light_spell_2)
         (at light_spell_2 bog)
         (selling witch kill_spell_1)
         (owns witch kill_spell_1)
         (at kill_spell_1 bog)
         (intends witch (alive witch))
         ; Troll
         (alive troll)
         (knows-location troll cave)
         (at troll cave)
         (intends troll (alive troll))
         ; Wolf
         (alive wolf)
         (knows-location wolf clearing)
         (knows-location wolf forest)
         (knows-location wolf bog)
         (at wolf clearing)
         (intends wolf (alive wolf))
         ; Items
         (at torch camp)
         (at nightshade forest)
         ; Spells
         (summons light_spell_1 spell_torch_1)
         (summons light_spell_2 spell_torch_2)
         (summons alchemy_spell_1 spell_money)
         (leads_to teleport_spell_1 bridge))
  (:goal (and (at goblin tower)
              (has goblin tonic))))