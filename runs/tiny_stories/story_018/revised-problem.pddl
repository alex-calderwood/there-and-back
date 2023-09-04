(define (problem daisy-finds-treasure)
  (:domain
    daisy-treasure)
  (:objects
    daisy - character
    bedroom toys-cupboard - place
    treasure-chest - item
    shiny-coins - item)
  (:init
    (at daisy bedroom)
    (hidden treasure-chest bedroom)
    (hidden shiny-coins treasure-chest)
    (intends daisy (found daisy treasure-chest))
    (intends daisy (found daisy shiny-coins))
    (intends daisy (stored shiny-coins toys-cupboard)))
  (:goal
    (and (found daisy treasure-chest)
         (found daisy shiny-coins)
         (stored shiny-coins toys-cupboard)))
)

<|Error|>

No solutions found. The domain and problem compiled, but the planner failed to find a solution or timed out. (Note: There are a few common solutions. Ensure that characters have intentions that will lead to them taking actions that will fulfill the author's :goal. If there is not a clear sequence of motivated character actions that will solve the author's :goal, the planner will not be able to find a solution. One potential fix is to add character intentions to the problem. Another fix is to add or relax author goals such that at least one character's intentions will produce a sequence of motivated actions that will achieve each predicate within the author's :goal. Characters will not take actions for which they are an :agent if the action does not help them achieve an intention. For actions that exist independently of a character's volition, remove the :agent tag, or add intentions to the character.)