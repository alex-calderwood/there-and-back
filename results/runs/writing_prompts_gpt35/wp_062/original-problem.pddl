(define (problem skyrim-hero)
  (:domain skyrim)
  (:objects
    dragonborn - character
    town-guard winterhold-shopkeeper priest bandit-corpse jarl-of-windhelm thieves-guild dark-brotherhood thalmor unnamed-companion ysolda whiterun-blacksmith unnamed-courier former-adventurer - character
    fireball arrow - item
    whiterun winterhold riften windhelm - place)
  (:init
    (alive dragonborn)
    (at dragonborn whiterun)
    (intends dragonborn (alive dragonborn))
    (intends dragonborn (has dragonborn dragon))
    (intends dragonborn (made-weapon dragonborn arrow))
    (intends dragonborn (become-true-savior dragonborn))
    (alive town-guard)
    (at town-guard whiterun)
    (intends town-guard (alive town-guard))
    (intends town-guard (saved-life town-guard))