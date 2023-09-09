(define (problem jen-birthday)
  (:domain
    jen-birthday-cards)
  (:objects
    jen dad mom - character
    birch-box - object
    cancer - milestone
    18th-birthday graduation first-breakup buying-house university having-child getting-engaged - milestone
    home hospital - place)
  (:init
    (has-card mom 18th-birthday)
    (has-card mom graduation)
    (has-card mom first-breakup)
    (has-card mom buying-house)
    (has-card mom university)
    (has-card mom having-child)
    (has-card mom getting-engaged)
    (alive jen)
    (at jen home)
    (intends jen (alive jen))
    (intends jen (has-card birch-box cancer))
  )
  (:goal
    (and (not (