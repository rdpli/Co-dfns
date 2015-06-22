:Namespace H
  (⎕IO ⎕ML ⎕WX)←0 1 3 ⋄ A←##.A ⋄ C←##.C
  d←A.d ⋄ t←A.t ⋄ k←A.k ⋄ n←A.n ⋄ r←A.r ⋄ s←A.s ⋄ v←A.v ⋄ y←A.y ⋄ e←A.e

  ⍝ Utilities
  var←{(,'⍺')≡⍺:,'l' ⋄ (,'⍵')≡⍺:,'r' ⋄ '&env[',(⍕⊃⍵),'][',(⍕⊃⌽⍵),']'}
  nl←⎕UCS 13 10
  for←{'for(i=0;i<',(⍕⍵),';i++){'}
  do←{'{BOUND i;',(for ⍺),⍵,'}}',nl}
  pdo←{'{BOUND i;',nl,(((⊂C.COMPILER)∊'icc' 'pgi')⊃''('#pragma simd',nl)),(for ⍺),⍵,'}}',nl}
  tl←{('di'⍳⍵)⊃¨⊂('APLDOUB' 'double')('APLLONG' 'aplint32')}
  enc←⊂⊣,∘⊃((⊣,'_',⊢)/(⊂''),(⍕¨(0≠⊢)(/∘⊢)⊢))
  fvs←,⍤0(⌿⍨)0≠(≢∘⍴¨⊣)
  cln←'¯'⎕R'-'

  ⍝ Runtime Header
  rth ←'#include <math.h>',nl,'#include <dwa.h>',nl,'#include <dwa_fns.h>',nl
  rth,←'#include <stdio.h>',nl
  rth,←'int isinit=0;',nl
  rth,←'#define PI 3.14159265358979323846',nl

  ⍝ Environments
  dnv←{(0≡z)⊃('LOCALP ',⍺,'[',(⍕z←⊃v⍵),'];')('LOCALP*',⍺,'=NULL;')}
  reg←{(⊃v⍵)do'regp(&',⍺,'[i]);'}
  cutp←'cutp(&env0[0]);'

  ⍝ Functions
  frt←'void static inline ' ⋄ fre←'void EXPORT '
  flp←'(LOCALP*z,LOCALP*l,LOCALP*r,LOCALP*penv[])'
  elp←'(LOCALP*z,LOCALP*l,LOCALP*r)'
  foi←'if(!isinit){Init(NULL,NULL,NULL,NULL);isinit=1;}',nl
  fnv←{'LOCALP*env[]={',(⊃,/(⊂'env0'),{',penv[',(⍕⍵),']'}¨⍳⊃s ⍵),'};',nl}
  tps←'int tp=0;switch(r->p->ELTYPE){case APLLONG:break;',nl
  tps,←'case APLDOUB:tp=3;break;',nl,'default:error(16);}',nl
  tps,←'if(l==NULL)tp+=2;',nl
  tps,←'else switch(l->p->ELTYPE){case APLLONG:break;',nl
  tps,←'case APLDOUB:tp+=1;break;',nl,'default:error(16);}',nl
  tps,←'switch(tp){',nl
  tpi←'ii' 'if' 'in' 'fi' 'ff' 'fn'
  cas←{'case ',(⍕⍺),':',⍵,(⍺⊃tpi),'(z,l,r,env);break;',nl}
  calm←{z r←var/⍵ ⋄ ⍺⍺,((1⌷⍺)⊃'i' 'i' 'f'),'n(',z,',NULL,',r,',env);',nl}

  ⍝ Scalar Groups
  rk0←'BOUND prk=0;BOUND sp[15];BOUND cnt=1,i=0;',nl
  rk1←'if(prk!=(' ⋄ rk2←')->p->RANK){if(prk==0){',nl
  rsp←{'prk=(',⍵,')->p->RANK;',nl,'prk'do'sp[i]=(',⍵,')->p->SHAPETC[i];'}
  rk3←'}else if((' ⋄ rk4←')->p->RANK!=0)error(4);',nl
  spt←{'if(sp[i]!=(',⍵,')->p->SHAPETC[i])error(4);'}
  rkv←{rk1,⍵,rk2,(rsp ⍵),rk3,⍵,rk4,'}else{',nl,('prk'do spt ⍵),'}',nl}
  rk5←'if(prk!=1){if(prk==0){prk=1;sp[0]='
  rka←{rk5,l,';}else error(4);}else if(sp[0]!=',(l←⍕≢⍵),')error(4);',nl}
  crk←{⍵((⊃,/)((rkv¨var/)⊣(⌿⍨)(~⊢)),(rka¨0⌷∘⍉(⌿⍨)))0=(⊃0⍴∘⊂⊃)¨0⌷⍉⍵}
  srk←{crk(⊃v⍵)(,⍤0(⌿⍨)0≠(≢∘⍴¨⊣))(⊃e⍵)}
  ste←{'relp(',⍵,');(',⍵,')->p=p',(⍕⍺),';',nl}
  sts←{'r',(⍕⍺),'[i]=s',(⍕⍵),';',nl}
  rkp1←{'BOUND m',(⍕⍺),'=(',(⍕⍵),')->p->RANK==0?0:1;',nl}
  rkp2←{''('BOUND mz',(⍕⍺),'=(',(⍕⍵),')->p->RANK==0?1:cnt;',nl)}
  rkp←{(⍺ rkp1 ⍵),(C.COMPILER≡'pgi')⊃⍺ rkp2 ⍵}
  git←{⍵⊃¨⊂'/* XXX */ aplint32 ' 'aplint32 ' 'double ' '?type? '}
  gie←{⍵⊃¨⊂'/* XXX */ APLLONG' 'APLLONG' 'APLDOUB' 'APLNA'}
  gdp←{'*d',(⍕⍺),'=ARRAYSTART((',⍵,')->p);',nl}
  gda1←{'d',(⍕⍺),'[]={',(⊃{⍺,',',⍵}/⍕¨⍵),'};',nl}
  gdm←{'BOUND m',(⍕⍺),'=',(⍕0≢≢⍵),';',nl}
  gda2←{''('BOUND mz',(⍕⍺),'=cnt;',nl)}
  gda←{(⍺ gda1 ⍵),(⍺ gdm ⍵),(C.COMPILER≡'pgi')⊃⍺ gda2 ⍵}
  sfa←{(git m/⍺),¨{((+/~m)+⍳≢⍵)gda¨⍵}⊣/(m←0=(⊃0⍴∘⊂⊃)¨0⌷⍉⍵)⌿⍵}
  sfp←{(git m⌿⍺),¨{(⍳≢⍵)(gdp,rkp)¨⍵}var/(m←~0=(⊃0⍴∘⊂⊃)¨0⌷⍉⍵)⌿⍵}
  sfv←(1⌷∘⍉(⊃v)fvs(⊃y))((⊃,/)sfp,sfa)(⊃v)fvs(⊃e)
  ack←{'p',(⍕⍺),'=getarray(',(⊃gie ⍺⌷⍺⍺),',prk,sp,NULL);',nl}
  gpp←{nl,⍨';',⍨⊃,/'POCKET',⊃{⍺,',',⍵}/'*p'∘,∘⍕¨⍳≢⍵}
  grs←{(⊃git ⍺),'*r',(⍕⍵),'=ARRAYSTART(p',(⍕⍵),');',nl}
  spp←(⊃s){(gpp⍵),(⊃,/(⍳≢⍵)(⍺ ack)¨⍵),(⊃,/⍺ grs¨⍳≢⍵)}(⊃n)var¨(⊃r)
  sip←{⍺,'f',⍵,'=d',⍵,'[i*m',⍵,'];',nl}∘⍕
  smcd←{'copyin(',(⊃{⍺,',',⍵}/{'d',(⍕⍵),'[0:mz',(⍕⍵),']'}¨⍳≢⍵),')'}
  smcr←{'copyout(',(⊃{⍺,',',⍵}/{'r',(⍕⍵),'[0:cnt]'}¨⍳≢⍵),')'}
  simc←{(smcd(⊃v⍵)fvs(⊃e⍵)),' ',(smcr⊃n⍵),nl}
  prag←{('#pragma acc parallel loop ',simc ⍵)('#pragma simd',nl)('')}
  simd←{('pgi' 'icc'⍳⊂C.COMPILER)⊃prag ⍵}
  slp←{(simd ⍵),(for'cnt'),nl,⊃,/(git 1⌷⍉(⊃v⍵)fvs(⊃y⍵))sip¨⍳≢(⊃v⍵)fvs(⊃e⍵)}

:EndNamespace

