﻿ LF←{⍝ Lift functions to top level after resolving
     i←¯1 ⋄ mv←{'LF',⍕i⊣(⊃i)+←1} ⋄ a←↑'class' 'equiv'{⍺ ⍵}¨⊂'ambivalent'
     mn←{2 4⍴⍵'FuncExpr' ''a(⍵+1)'Variable' ''(2 2⍴'name'⍺'class' 'function')}
     up←{w←⍵ ⋄ (0⌷⍉w)-←(⊃⍵)-1 ⋄ w} ⋄ s←{⍵⊂[0]⍨(⍬ 1⊃⍨0≠≢⍵),2≠/∨\0,1↓(⊃⍵)≥0⌷⍉⍵}
     l←(1≠d)∧(d=⌈/f/d←0⌷⍉⍵)∧f←1⌽(1⌷⍉⍵)∊⊂'Function'
     c←↑{h r←2↑s ⍵ ⋄ n←mv ⍬ ⋄ (n Bind up h)(r⍪⍨n mn⊃h)}¨l⊂[0]⍵
     (1↑⍵)⍪(⊃⍪/(⊂MtAST),⊣/c)⍪(1↓⍵⌿⍨~∨\l)⍪⊃⍪/(⊂MtAST),⊢/c}