(define (space robbery)
  (:literals (alive carl)
             (alive hank)
             (alive timmy)
             (alive will)
             (at carl generalstore)
             (not (at carl generalstore))
             (at carl jailhouse)
             (not (at carl jailhouse))
             (at carl ranch)
             (not (at carl ranch))
             (at carl saloon)
             (not (at carl saloon))
             (at hank generalstore)
             (not (at hank generalstore))
             (at hank jailhouse)
             (not (at hank jailhouse))
             (at hank ranch)
             (not (at hank ranch))
             (at hank saloon)
             (not (at hank saloon))
             (at timmy generalstore)
             (not (at timmy generalstore))
             (at timmy jailhouse)
             (not (at timmy jailhouse))
             (at timmy ranch)
             (not (at timmy ranch))
             (at timmy saloon)
             (not (at timmy saloon))
             (at will generalstore)
             (not (at will generalstore))
             (at will jailhouse)
             (not (at will jailhouse))
             (at will ranch)
             (not (at will ranch))
             (at will saloon)
             (not (at will saloon))
             (cures antivenom snakebite)
             (free carl)
             (not (free carl))
             (free hank)
             (not (free hank))
             (free timmy)
             (not (free timmy))
             (free will)
             (not (free will))
             (has carl antivenom)
             (not (has carl antivenom))
             (has hank antivenom)
             (intends carl (free carl))
             (not (has hank antivenom))
             (has timmy antivenom)
             (not (has timmy antivenom))
             (has will antivenom)
             (not (has will antivenom))
             (intends carl (has carl antivenom))
             (intends hank (free hank))
             (intends timmy (free timmy))
             (intends will (free will))
             (loves hank timmy)
             (loves timmy hank)
             (sheriff will)
             (sick carl snakebite)
             (not (sick carl snakebite))
             (sick hank snakebite)
             (not (sick hank snakebite))
             (sick timmy snakebite)
             (not (sick timmy snakebite))
             (sick will snakebite)
             (not (sick will snakebite)))
  (:steps (snakebite hank)
          (snakebite timmy)
          (snakebite will)
          (snakebite carl)
          (die hank snakebite)
          (die timmy snakebite)
          (die will snakebite)
          (die carl snakebite)
          (travel hank jailhouse jailhouse)
          (travel hank jailhouse saloon)
          (travel hank jailhouse ranch)
          (travel hank jailhouse generalstore)
          (travel hank saloon jailhouse)
          (travel hank saloon saloon)
          (travel hank saloon ranch)
          (travel hank saloon generalstore)
          (travel hank ranch jailhouse)
          (travel hank ranch saloon)
          (travel hank ranch ranch)
          (travel hank ranch generalstore)
          (travel hank generalstore jailhouse)
          (travel hank generalstore saloon)
          (travel hank generalstore ranch)
          (travel hank generalstore generalstore)
          (travel timmy jailhouse jailhouse)
          (travel timmy jailhouse saloon)
          (travel timmy jailhouse ranch)
          (travel timmy jailhouse generalstore)
          (travel timmy saloon jailhouse)
          (travel timmy saloon saloon)
          (travel timmy saloon ranch)
          (travel timmy saloon generalstore)
          (travel timmy ranch jailhouse)
          (travel timmy ranch saloon)
          (travel timmy ranch ranch)
          (travel timmy ranch generalstore)
          (travel timmy generalstore jailhouse)
          (travel timmy generalstore saloon)
          (travel timmy generalstore ranch)
          (travel timmy generalstore generalstore)
          (travel will jailhouse jailhouse)
          (travel will jailhouse saloon)
          (travel will jailhouse ranch)
          (travel will jailhouse generalstore)
          (travel will saloon jailhouse)
          (travel will saloon saloon)
          (travel will saloon ranch)
          (travel will saloon generalstore)
          (travel will ranch jailhouse)
          (travel will ranch saloon)
          (travel will ranch ranch)
          (travel will ranch generalstore)
          (travel will generalstore jailhouse)
          (travel will generalstore saloon)
          (travel will generalstore ranch)
          (travel will generalstore generalstore)
          (travel carl jailhouse jailhouse)
          (travel carl jailhouse saloon)
          (travel carl jailhouse ranch)
          (travel carl jailhouse generalstore)
          (travel carl saloon jailhouse)
          (travel carl saloon saloon)
          (travel carl saloon ranch)
          (travel carl saloon generalstore)
          (travel carl ranch jailhouse)
          (travel carl ranch saloon)
          (travel carl ranch ranch)
          (travel carl ranch generalstore)
          (travel carl generalstore jailhouse)
          (travel carl generalstore saloon)
          (travel carl generalstore ranch)
          (travel carl generalstore generalstore)
          (forcetravel hank hank jailhouse jailhouse)
          (forcetravel hank hank jailhouse saloon)
          (forcetravel hank hank jailhouse ranch)
          (forcetravel hank hank jailhouse generalstore)
          (forcetravel hank hank saloon jailhouse)
          (forcetravel hank hank saloon saloon)
          (forcetravel hank hank saloon ranch)
          (forcetravel hank hank saloon generalstore)
          (forcetravel hank hank ranch jailhouse)
          (forcetravel hank hank ranch saloon)
          (forcetravel hank hank ranch ranch)
          (forcetravel hank hank ranch generalstore)
          (forcetravel hank hank generalstore jailhouse)
          (forcetravel hank hank generalstore saloon)
          (forcetravel hank hank generalstore ranch)
          (forcetravel hank hank generalstore generalstore)
          (forcetravel hank timmy jailhouse jailhouse)
          (forcetravel hank timmy jailhouse saloon)
          (forcetravel hank timmy jailhouse ranch)
          (forcetravel hank timmy jailhouse generalstore)
          (forcetravel hank timmy saloon jailhouse)
          (forcetravel hank timmy saloon saloon)
          (forcetravel hank timmy saloon ranch)
          (forcetravel hank timmy saloon generalstore)
          (forcetravel hank timmy ranch jailhouse)
          (forcetravel hank timmy ranch saloon)
          (forcetravel hank timmy ranch ranch)
          (forcetravel hank timmy ranch generalstore)
          (forcetravel hank timmy generalstore jailhouse)
          (forcetravel hank timmy generalstore saloon)
          (forcetravel hank timmy generalstore ranch)
          (forcetravel hank timmy generalstore generalstore)
          (forcetravel hank will jailhouse jailhouse)
          (forcetravel hank will jailhouse saloon)
          (forcetravel hank will jailhouse ranch)
          (forcetravel hank will jailhouse generalstore)
          (forcetravel hank will saloon jailhouse)
          (forcetravel hank will saloon saloon)
          (forcetravel hank will saloon ranch)
          (forcetravel hank will saloon generalstore)
          (forcetravel hank will ranch jailhouse)
          (forcetravel hank will ranch saloon)
          (forcetravel hank will ranch ranch)
          (forcetravel hank will ranch generalstore)
          (forcetravel hank will generalstore jailhouse)
          (forcetravel hank will generalstore saloon)
          (forcetravel hank will generalstore ranch)
          (forcetravel hank will generalstore generalstore)
          (forcetravel hank carl jailhouse jailhouse)
          (forcetravel hank carl jailhouse saloon)
          (forcetravel hank carl jailhouse ranch)
          (forcetravel hank carl jailhouse generalstore)
          (forcetravel hank carl saloon jailhouse)
          (forcetravel hank carl saloon saloon)
          (forcetravel hank carl saloon ranch)
          (forcetravel hank carl saloon generalstore)
          (forcetravel hank carl ranch jailhouse)
          (forcetravel hank carl ranch saloon)
          (forcetravel hank carl ranch ranch)
          (forcetravel hank carl ranch generalstore)
          (forcetravel hank carl generalstore jailhouse)
          (forcetravel hank carl generalstore saloon)
          (forcetravel hank carl generalstore ranch)
          (forcetravel hank carl generalstore generalstore)
          (forcetravel timmy hank jailhouse jailhouse)
          (forcetravel timmy hank jailhouse saloon)
          (forcetravel timmy hank jailhouse ranch)
          (forcetravel timmy hank jailhouse generalstore)
          (forcetravel timmy hank saloon jailhouse)
          (forcetravel timmy hank saloon saloon)
          (forcetravel timmy hank saloon ranch)
          (forcetravel timmy hank saloon generalstore)
          (forcetravel timmy hank ranch jailhouse)
          (forcetravel timmy hank ranch saloon)
          (forcetravel timmy hank ranch ranch)
          (forcetravel timmy hank ranch generalstore)
          (forcetravel timmy hank generalstore jailhouse)
          (forcetravel timmy hank generalstore saloon)
          (forcetravel timmy hank generalstore ranch)
          (forcetravel timmy hank generalstore generalstore)
          (forcetravel timmy timmy jailhouse jailhouse)
          (forcetravel timmy timmy jailhouse saloon)
          (forcetravel timmy timmy jailhouse ranch)
          (forcetravel timmy timmy jailhouse generalstore)
          (forcetravel timmy timmy saloon jailhouse)
          (forcetravel timmy timmy saloon saloon)
          (forcetravel timmy timmy saloon ranch)
          (forcetravel timmy timmy saloon generalstore)
          (forcetravel timmy timmy ranch jailhouse)
          (forcetravel timmy timmy ranch saloon)
          (forcetravel timmy timmy ranch ranch)
          (forcetravel timmy timmy ranch generalstore)
          (forcetravel timmy timmy generalstore jailhouse)
          (forcetravel timmy timmy generalstore saloon)
          (forcetravel timmy timmy generalstore ranch)
          (forcetravel timmy timmy generalstore generalstore)
          (forcetravel timmy will jailhouse jailhouse)
          (forcetravel timmy will jailhouse saloon)
          (forcetravel timmy will jailhouse ranch)
          (forcetravel timmy will jailhouse generalstore)
          (forcetravel timmy will saloon jailhouse)
          (forcetravel timmy will saloon saloon)
          (forcetravel timmy will saloon ranch)
          (forcetravel timmy will saloon generalstore)
          (forcetravel timmy will ranch jailhouse)
          (forcetravel timmy will ranch saloon)
          (forcetravel timmy will ranch ranch)
          (forcetravel timmy will ranch generalstore)
          (forcetravel timmy will generalstore jailhouse)
          (forcetravel timmy will generalstore saloon)
          (forcetravel timmy will generalstore ranch)
          (forcetravel timmy will generalstore generalstore)
          (forcetravel timmy carl jailhouse jailhouse)
          (forcetravel timmy carl jailhouse saloon)
          (forcetravel timmy carl jailhouse ranch)
          (forcetravel timmy carl jailhouse generalstore)
          (forcetravel timmy carl saloon jailhouse)
          (forcetravel timmy carl saloon saloon)
          (forcetravel timmy carl saloon ranch)
          (forcetravel timmy carl saloon generalstore)
          (forcetravel timmy carl ranch jailhouse)
          (forcetravel timmy carl ranch saloon)
          (forcetravel timmy carl ranch ranch)
          (forcetravel timmy carl ranch generalstore)
          (forcetravel timmy carl generalstore jailhouse)
          (forcetravel timmy carl generalstore saloon)
          (forcetravel timmy carl generalstore ranch)
          (forcetravel timmy carl generalstore generalstore)
          (forcetravel will hank jailhouse jailhouse)
          (forcetravel will hank jailhouse saloon)
          (forcetravel will hank jailhouse ranch)
          (forcetravel will hank jailhouse generalstore)
          (forcetravel will hank saloon jailhouse)
          (forcetravel will hank saloon saloon)
          (forcetravel will hank saloon ranch)
          (forcetravel will hank saloon generalstore)
          (forcetravel will hank ranch jailhouse)
          (forcetravel will hank ranch saloon)
          (forcetravel will hank ranch ranch)
          (forcetravel will hank ranch generalstore)
          (forcetravel will hank generalstore jailhouse)
          (forcetravel will hank generalstore saloon)
          (forcetravel will hank generalstore ranch)
          (forcetravel will hank generalstore generalstore)
          (forcetravel will timmy jailhouse jailhouse)
          (forcetravel will timmy jailhouse saloon)
          (forcetravel will timmy jailhouse ranch)
          (forcetravel will timmy jailhouse generalstore)
          (forcetravel will timmy saloon jailhouse)
          (forcetravel will timmy saloon saloon)
          (forcetravel will timmy saloon ranch)
          (forcetravel will timmy saloon generalstore)
          (forcetravel will timmy ranch jailhouse)
          (forcetravel will timmy ranch saloon)
          (forcetravel will timmy ranch ranch)
          (forcetravel will timmy ranch generalstore)
          (forcetravel will timmy generalstore jailhouse)
          (forcetravel will timmy generalstore saloon)
          (forcetravel will timmy generalstore ranch)
          (forcetravel will timmy generalstore generalstore)
          (forcetravel will will jailhouse jailhouse)
          (forcetravel will will jailhouse saloon)
          (forcetravel will will jailhouse ranch)
          (forcetravel will will jailhouse generalstore)
          (forcetravel will will saloon jailhouse)
          (forcetravel will will saloon saloon)
          (forcetravel will will saloon ranch)
          (forcetravel will will saloon generalstore)
          (forcetravel will will ranch jailhouse)
          (forcetravel will will ranch saloon)
          (forcetravel will will ranch ranch)
          (forcetravel will will ranch generalstore)
          (forcetravel will will generalstore jailhouse)
          (forcetravel will will generalstore saloon)
          (forcetravel will will generalstore ranch)
          (forcetravel will will generalstore generalstore)
          (forcetravel will carl jailhouse jailhouse)
          (forcetravel will carl jailhouse saloon)
          (forcetravel will carl jailhouse ranch)
          (forcetravel will carl jailhouse generalstore)
          (forcetravel will carl saloon jailhouse)
          (forcetravel will carl saloon saloon)
          (forcetravel will carl saloon ranch)
          (forcetravel will carl saloon generalstore)
          (forcetravel will carl ranch jailhouse)
          (forcetravel will carl ranch saloon)
          (forcetravel will carl ranch ranch)
          (forcetravel will carl ranch generalstore)
          (forcetravel will carl generalstore jailhouse)
          (forcetravel will carl generalstore saloon)
          (forcetravel will carl generalstore ranch)
          (forcetravel will carl generalstore generalstore)
          (forcetravel carl hank jailhouse jailhouse)
          (forcetravel carl hank jailhouse saloon)
          (forcetravel carl hank jailhouse ranch)
          (forcetravel carl hank jailhouse generalstore)
          (forcetravel carl hank saloon jailhouse)
          (forcetravel carl hank saloon saloon)
          (forcetravel carl hank saloon ranch)
          (forcetravel carl hank saloon generalstore)
          (forcetravel carl hank ranch jailhouse)
          (forcetravel carl hank ranch saloon)
          (forcetravel carl hank ranch ranch)
          (forcetravel carl hank ranch generalstore)
          (forcetravel carl hank generalstore jailhouse)
          (forcetravel carl hank generalstore saloon)
          (forcetravel carl hank generalstore ranch)
          (forcetravel carl hank generalstore generalstore)
          (forcetravel carl timmy jailhouse jailhouse)
          (forcetravel carl timmy jailhouse saloon)
          (forcetravel carl timmy jailhouse ranch)
          (forcetravel carl timmy jailhouse generalstore)
          (forcetravel carl timmy saloon jailhouse)
          (forcetravel carl timmy saloon saloon)
          (forcetravel carl timmy saloon ranch)
          (forcetravel carl timmy saloon generalstore)
          (forcetravel carl timmy ranch jailhouse)
          (forcetravel carl timmy ranch saloon)
          (forcetravel carl timmy ranch ranch)
          (forcetravel carl timmy ranch generalstore)
          (forcetravel carl timmy generalstore jailhouse)
          (forcetravel carl timmy generalstore saloon)
          (forcetravel carl timmy generalstore ranch)
          (forcetravel carl timmy generalstore generalstore)
          (forcetravel carl will jailhouse jailhouse)
          (forcetravel carl will jailhouse saloon)
          (forcetravel carl will jailhouse ranch)
          (forcetravel carl will jailhouse generalstore)
          (forcetravel carl will saloon jailhouse)
          (forcetravel carl will saloon saloon)
          (forcetravel carl will saloon ranch)
          (forcetravel carl will saloon generalstore)
          (forcetravel carl will ranch jailhouse)
          (forcetravel carl will ranch saloon)
          (forcetravel carl will ranch ranch)
          (forcetravel carl will ranch generalstore)
          (forcetravel carl will generalstore jailhouse)
          (forcetravel carl will generalstore saloon)
          (forcetravel carl will generalstore ranch)
          (forcetravel carl will generalstore generalstore)
          (forcetravel carl carl jailhouse jailhouse)
          (forcetravel carl carl jailhouse saloon)
          (forcetravel carl carl jailhouse ranch)
          (forcetravel carl carl jailhouse generalstore)
          (forcetravel carl carl saloon jailhouse)
          (forcetravel carl carl saloon saloon)
          (forcetravel carl carl saloon ranch)
          (forcetravel carl carl saloon generalstore)
          (forcetravel carl carl ranch jailhouse)
          (forcetravel carl carl ranch saloon)
          (forcetravel carl carl ranch ranch)
          (forcetravel carl carl ranch generalstore)
          (forcetravel carl carl generalstore jailhouse)
          (forcetravel carl carl generalstore saloon)
          (forcetravel carl carl generalstore ranch)
          (forcetravel carl carl generalstore generalstore)
          (give hank hank antivenom jailhouse)
          (give hank hank antivenom saloon)
          (give hank hank antivenom ranch)
          (give hank hank antivenom generalstore)
          (give hank timmy antivenom jailhouse)
          (give hank timmy antivenom saloon)
          (give hank timmy antivenom ranch)
          (give hank timmy antivenom generalstore)
          (give hank will antivenom jailhouse)
          (give hank will antivenom saloon)
          (give hank will antivenom ranch)
          (give hank will antivenom generalstore)
          (give hank carl antivenom jailhouse)
          (give hank carl antivenom saloon)
          (give hank carl antivenom ranch)
          (give hank carl antivenom generalstore)
          (give timmy hank antivenom jailhouse)
          (give timmy hank antivenom saloon)
          (give timmy hank antivenom ranch)
          (give timmy hank antivenom generalstore)
          (give timmy timmy antivenom jailhouse)
          (give timmy timmy antivenom saloon)
          (give timmy timmy antivenom ranch)
          (give timmy timmy antivenom generalstore)
          (give timmy will antivenom jailhouse)
          (give timmy will antivenom saloon)
          (give timmy will antivenom ranch)
          (give timmy will antivenom generalstore)
          (give timmy carl antivenom jailhouse)
          (give timmy carl antivenom saloon)
          (give timmy carl antivenom ranch)
          (give timmy carl antivenom generalstore)
          (give will hank antivenom jailhouse)
          (give will hank antivenom saloon)
          (give will hank antivenom ranch)
          (give will hank antivenom generalstore)
          (give will timmy antivenom jailhouse)
          (give will timmy antivenom saloon)
          (give will timmy antivenom ranch)
          (give will timmy antivenom generalstore)
          (give will will antivenom jailhouse)
          (give will will antivenom saloon)
          (give will will antivenom ranch)
          (give will will antivenom generalstore)
          (give will carl antivenom jailhouse)
          (give will carl antivenom saloon)
          (give will carl antivenom ranch)
          (give will carl antivenom generalstore)
          (give carl hank antivenom jailhouse)
          (give carl hank antivenom saloon)
          (give carl hank antivenom ranch)
          (give carl hank antivenom generalstore)
          (give carl timmy antivenom jailhouse)
          (give carl timmy antivenom saloon)
          (give carl timmy antivenom ranch)
          (give carl timmy antivenom generalstore)
          (give carl will antivenom jailhouse)
          (give carl will antivenom saloon)
          (give carl will antivenom ranch)
          (give carl will antivenom generalstore)
          (give carl carl antivenom jailhouse)
          (give carl carl antivenom saloon)
          (give carl carl antivenom ranch)
          (give carl carl antivenom generalstore)
          (tieup hank hank jailhouse)
          (tieup hank hank saloon)
          (tieup hank hank ranch)
          (tieup hank hank generalstore)
          (tieup hank timmy jailhouse)
          (tieup hank timmy saloon)
          (tieup hank timmy ranch)
          (tieup hank timmy generalstore)
          (tieup hank will jailhouse)
          (tieup hank will saloon)
          (tieup hank will ranch)
          (tieup hank will generalstore)
          (tieup hank carl jailhouse)
          (tieup hank carl saloon)
          (tieup hank carl ranch)
          (tieup hank carl generalstore)
          (tieup timmy hank jailhouse)
          (tieup timmy hank saloon)
          (tieup timmy hank ranch)
          (tieup timmy hank generalstore)
          (tieup timmy timmy jailhouse)
          (tieup timmy timmy saloon)
          (tieup timmy timmy ranch)
          (tieup timmy timmy generalstore)
          (tieup timmy will jailhouse)
          (tieup timmy will saloon)
          (tieup timmy will ranch)
          (tieup timmy will generalstore)
          (tieup timmy carl jailhouse)
          (tieup timmy carl saloon)
          (tieup timmy carl ranch)
          (tieup timmy carl generalstore)
          (tieup will hank jailhouse)
          (tieup will hank saloon)
          (tieup will hank ranch)
          (tieup will hank generalstore)
          (tieup will timmy jailhouse)
          (tieup will timmy saloon)
          (tieup will timmy ranch)
          (tieup will timmy generalstore)
          (tieup will will jailhouse)
          (tieup will will saloon)
          (tieup will will ranch)
          (tieup will will generalstore)
          (tieup will carl jailhouse)
          (tieup will carl saloon)
          (tieup will carl ranch)
          (tieup will carl generalstore)
          (tieup carl hank jailhouse)
          (tieup carl hank saloon)
          (tieup carl hank ranch)
          (tieup carl hank generalstore)
          (tieup carl timmy jailhouse)
          (tieup carl timmy saloon)
          (tieup carl timmy ranch)
          (tieup carl timmy generalstore)
          (tieup carl will jailhouse)
          (tieup carl will saloon)
          (tieup carl will ranch)
          (tieup carl will generalstore)
          (tieup carl carl jailhouse)
          (tieup carl carl saloon)
          (tieup carl carl ranch)
          (tieup carl carl generalstore)
          (untie hank hank jailhouse)
          (untie hank hank saloon)
          (untie hank hank ranch)
          (untie hank hank generalstore)
          (untie hank timmy jailhouse)
          (untie hank timmy saloon)
          (untie hank timmy ranch)
          (untie hank timmy generalstore)
          (untie hank will jailhouse)
          (untie hank will saloon)
          (untie hank will ranch)
          (untie hank will generalstore)
          (untie hank carl jailhouse)
          (untie hank carl saloon)
          (untie hank carl ranch)
          (untie hank carl generalstore)
          (untie timmy hank jailhouse)
          (untie timmy hank saloon)
          (untie timmy hank ranch)
          (untie timmy hank generalstore)
          (untie timmy timmy jailhouse)
          (untie timmy timmy saloon)
          (untie timmy timmy ranch)
          (untie timmy timmy generalstore)
          (untie timmy will jailhouse)
          (untie timmy will saloon)
          (untie timmy will ranch)
          (untie timmy will generalstore)
          (untie timmy carl jailhouse)
          (untie timmy carl saloon)
          (untie timmy carl ranch)
          (untie timmy carl generalstore)
          (untie will hank jailhouse)
          (untie will hank saloon)
          (untie will hank ranch)
          (untie will hank generalstore)
          (untie will timmy jailhouse)
          (untie will timmy saloon)
          (untie will timmy ranch)
          (untie will timmy generalstore)
          (untie will will jailhouse)
          (untie will will saloon)
          (untie will will ranch)
          (untie will will generalstore)
          (untie will carl jailhouse)
          (untie will carl saloon)
          (untie will carl ranch)
          (untie will carl generalstore)
          (untie carl hank jailhouse)
          (untie carl hank saloon)
          (untie carl hank ranch)
          (untie carl hank generalstore)
          (untie carl timmy jailhouse)
          (untie carl timmy saloon)
          (untie carl timmy ranch)
          (untie carl timmy generalstore)
          (untie carl will jailhouse)
          (untie carl will saloon)
          (untie carl will ranch)
          (untie carl will generalstore)
          (untie carl carl jailhouse)
          (untie carl carl saloon)
          (untie carl carl ranch)
          (untie carl carl generalstore)
          (take hank antivenom timmy jailhouse)
          (take hank antivenom timmy saloon)
          (take hank antivenom timmy ranch)
          (take hank antivenom timmy generalstore)
          (take hank antivenom will jailhouse)
          (take hank antivenom will saloon)
          (take hank antivenom will ranch)
          (take hank antivenom will generalstore)
          (take hank antivenom carl jailhouse)
          (take hank antivenom carl saloon)
          (take hank antivenom carl ranch)
          (take hank antivenom carl generalstore)
          (take timmy antivenom hank jailhouse)
          (take timmy antivenom hank saloon)
          (take timmy antivenom hank ranch)
          (take timmy antivenom hank generalstore)
          (take timmy antivenom will jailhouse)
          (take timmy antivenom will saloon)
          (take timmy antivenom will ranch)
          (take timmy antivenom will generalstore)
          (take timmy antivenom carl jailhouse)
          (take timmy antivenom carl saloon)
          (take timmy antivenom carl ranch)
          (take timmy antivenom carl generalstore)
          (take will antivenom hank jailhouse)
          (take will antivenom hank saloon)
          (take will antivenom hank ranch)
          (take will antivenom hank generalstore)
          (take will antivenom timmy jailhouse)
          (take will antivenom timmy saloon)
          (take will antivenom timmy ranch)
          (take will antivenom timmy generalstore)
          (take will antivenom carl jailhouse)
          (take will antivenom carl saloon)
          (take will antivenom carl ranch)
          (take will antivenom carl generalstore)
          (take carl antivenom hank jailhouse)
          (take carl antivenom hank saloon)
          (take carl antivenom hank ranch)
          (take carl antivenom hank generalstore)
          (take carl antivenom timmy jailhouse)
          (take carl antivenom timmy saloon)
          (take carl antivenom timmy ranch)
          (take carl antivenom timmy generalstore)
          (take carl antivenom will jailhouse)
          (take carl antivenom will saloon)
          (take carl antivenom will ranch)
          (take carl antivenom will generalstore)
          (heal hank hank snakebite antivenom jailhouse)
          (heal hank hank snakebite antivenom saloon)
          (heal hank hank snakebite antivenom ranch)
          (heal hank hank snakebite antivenom generalstore)
          (heal hank timmy snakebite antivenom jailhouse)
          (heal hank timmy snakebite antivenom saloon)
          (heal hank timmy snakebite antivenom ranch)
          (heal hank timmy snakebite antivenom generalstore)
          (heal hank will snakebite antivenom jailhouse)
          (heal hank will snakebite antivenom saloon)
          (heal hank will snakebite antivenom ranch)
          (heal hank will snakebite antivenom generalstore)
          (heal hank carl snakebite antivenom jailhouse)
          (heal hank carl snakebite antivenom saloon)
          (heal hank carl snakebite antivenom ranch)
          (heal hank carl snakebite antivenom generalstore)
          (heal timmy hank snakebite antivenom jailhouse)
          (heal timmy hank snakebite antivenom saloon)
          (heal timmy hank snakebite antivenom ranch)
          (heal timmy hank snakebite antivenom generalstore)
          (heal timmy timmy snakebite antivenom jailhouse)
          (heal timmy timmy snakebite antivenom saloon)
          (heal timmy timmy snakebite antivenom ranch)
          (heal timmy timmy snakebite antivenom generalstore)
          (heal timmy will snakebite antivenom jailhouse)
          (heal timmy will snakebite antivenom saloon)
          (heal timmy will snakebite antivenom ranch)
          (heal timmy will snakebite antivenom generalstore)
          (heal timmy carl snakebite antivenom jailhouse)
          (heal timmy carl snakebite antivenom saloon)
          (heal timmy carl snakebite antivenom ranch)
          (heal timmy carl snakebite antivenom generalstore)
          (heal will hank snakebite antivenom jailhouse)
          (heal will hank snakebite antivenom saloon)
          (heal will hank snakebite antivenom ranch)
          (heal will hank snakebite antivenom generalstore)
          (heal will timmy snakebite antivenom jailhouse)
          (heal will timmy snakebite antivenom saloon)
          (heal will timmy snakebite antivenom ranch)
          (heal will timmy snakebite antivenom generalstore)
          (heal will will snakebite antivenom jailhouse)
          (heal will will snakebite antivenom saloon)
          (heal will will snakebite antivenom ranch)
          (heal will will snakebite antivenom generalstore)
          (heal will carl snakebite antivenom jailhouse)
          (heal will carl snakebite antivenom saloon)
          (heal will carl snakebite antivenom ranch)
          (heal will carl snakebite antivenom generalstore)
          (heal carl hank snakebite antivenom jailhouse)
          (heal carl hank snakebite antivenom saloon)
          (heal carl hank snakebite antivenom ranch)
          (heal carl hank snakebite antivenom generalstore)
          (heal carl timmy snakebite antivenom jailhouse)
          (heal carl timmy snakebite antivenom saloon)
          (heal carl timmy snakebite antivenom ranch)
          (heal carl timmy snakebite antivenom generalstore)
          (heal carl will snakebite antivenom jailhouse)
          (heal carl will snakebite antivenom saloon)
          (heal carl will snakebite antivenom ranch)
          (heal carl will snakebite antivenom generalstore)
          (heal carl carl snakebite antivenom jailhouse)
          (heal carl carl snakebite antivenom saloon)
          (heal carl carl snakebite antivenom ranch)
          (heal carl carl snakebite antivenom generalstore))
  (:axioms))