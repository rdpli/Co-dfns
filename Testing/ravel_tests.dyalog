﻿:Namespace ravel

I←{⍬≡⍴⍵:⍵ ⋄ ⊃((⎕DR ⍵)323)⎕DR ⍵}
S←':Namespace' 'Run←{,⍵}' ':EndNamespace'
NS←⎕FIX S ⋄ C←#.codfns

RAVEL∆1∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/ravel1'C.Fix S
  #.UT.expect←NS.Run I ⍳5 ⋄ CS.Run I ⍳5
}

RAVEL∆1∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/ravel1'C.Fix S
  #.UT.expect←NS.Run I ⍳5 ⋄ CS.Run I ⍳5
}

RAVEL∆1∆VSC_TEST←{~(⊂'vsc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'vsc' ⋄ CS←'ravel1'C.Fix S
  #.UT.expect←NS.Run I ⍳5 ⋄ CS.Run I ⍳5
}

RAVEL∆2∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/ravel2'C.Fix S
  #.UT.expect←NS.Run I 0 ⋄ CS.Run I 0
}

RAVEL∆2∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/ravel2'C.Fix S
  #.UT.expect←NS.Run I 0 ⋄ CS.Run I 0
}

RAVEL∆2∆VSC_TEST←{~(⊂'vsc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'vsc' ⋄ CS←'ravel2'C.Fix S
  #.UT.expect←NS.Run I 0 ⋄ CS.Run I 0
}

RAVEL∆3∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/ravel3'C.Fix S
  #.UT.expect←NS.Run I ⍬ ⋄ CS.Run I ⍬
}

RAVEL∆3∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/ravel3'C.Fix S
  #.UT.expect←NS.Run I ⍬ ⋄ CS.Run I ⍬
}

RAVEL∆3∆VSC_TEST←{~(⊂'vsc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'vsc' ⋄ CS←'ravel3'C.Fix S
  #.UT.expect←NS.Run I ⍬ ⋄ CS.Run I ⍬
}

RAVEL∆4∆GCC_TEST←{~(⊂'gcc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'gcc' ⋄ CS←'Scratch/ravel4'C.Fix S
  #.UT.expect←NS.Run ÷2 2⍴1+⍳5 ⋄ CS.Run ÷2 2⍴1+⍳5
}

RAVEL∆4∆ICC_TEST←{~(⊂'icc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'icc' ⋄ CS←'Scratch/ravel4'C.Fix S
  #.UT.expect←NS.Run ÷2 2⍴1+⍳5 ⋄ CS.Run ÷2 2⍴1+⍳5
}

RAVEL∆4∆VSC_TEST←{~(⊂'vsc')∊C.TEST∆COMPILERS:0⊣#.UT.expect←0
  C.COMPILER←'vsc' ⋄ CS←'ravel4'C.Fix S
  #.UT.expect←NS.Run ÷2 2⍴1+⍳5 ⋄ CS.Run ÷2 2⍴1+⍳5
}

:EndNamespace

