﻿MF(add_f){z=r;}
SF(add_f,z.v=lv+rv)
SF(and_f,if(lv.isbool()&&rv.isbool())z.v=lv&&rv;else err(16);)
MF(brk_f){err(16);}
DF(brk_f){if(l.r!=1)err(16);
 z.r=r.r;z.s=r.s;z.v=l.v(r.v.as(s32));}
MF(cat_f){z.r=1;z.s[0]=cnt(r);z.v=flat(r.v);}
DA(cat_f){A nl=l,nr=r;I fx=(I)ceil(ax);
 if(fx<0||(fx>r.r&&fx>l.r))err(4);
 if(ax!=fx){if(r.r>3||l.r>3)err(10);
  if(nl.r){nl.r++;DO(3-fx,nl.s[3-i]=nl.s[3-(i+1)]);nl.s[fx]=1;}
  if(nr.r){nr.r++;DO(3-fx,nr.s[3-i]=nr.s[3-(i+1)]);nr.s[fx]=1;}
  if(nl.r)nl.v=moddims(nl.v,nl.s);if(nr.r)nr.v=moddims(nr.v,nr.s);
  catfn(z,nl,nr,fx,p);R;}
 if(fx>=r.r&&fx>=l.r)err(4);
 if(l.r&&r.r&&std::abs((I)l.r-(I)r.r)>1)err(4);
 z.r=(l.r>=r.r)*l.r+(r.r>l.r)*r.r+(!r.r&&!l.r);
 dim4 ls=l.s;dim4 rs=r.s;
 if(!l.r){ls=rs;ls[fx]=1;}if(!r.r){rs=ls;rs[fx]=1;}
 if(r.r&&l.r>r.r){DO(3-fx,rs[3-i]=rs[3-(i+1)]);rs[fx]=1;}
 if(l.r&&r.r>l.r){DO(3-fx,ls[3-i]=ls[3-(i+1)]);ls[fx]=1;}
 DO(4,if(i!=fx&&rs[i]!=ls[i])err(5));
 DO(4,z.s[i]=(l.r>=r.r||i==fx)*ls[i]+(r.r>l.r||i==fx)*rs[i]);
 if(!cnt(l)){z.v=r.v;R;}if(!cnt(r)){z.v=l.v;R;}
 dtype mt=mxt(r.v,l.v);
 array lv=(l.r?moddims(l.v,ls):tile(l.v,ls)).as(mt);
 array rv=(r.r?moddims(r.v,rs):tile(r.v,rs)).as(mt);
 z.v=join(fx,lv,rv);}
DF(cat_f){if(l.r||r.r){catfn(z,l,r,0,p);R;}
 A a,b;catfn(a,l,p);catfn(b,r,p);catfn(z,a,b,0,p);}
MF(cir_f){z.r=r.r;z.s=r.s;z.v=Pi*r.v.as(f64);}
SF(cir_f,array fv=rv.as(f64);
 if(!l.r){I x=l.v.as(s32).scalar<I>();if(abs(x)>10)err(16);
  switch(x){CS(0,z.v=sqrt(1-fv*fv))CS(1,z.v=sin(fv))CS(2,z.v=cos(fv))
   CS(3,z.v=tan(fv))CS(4,z.v=sqrt(1+fv*fv))CS(5,z.v=sinh(fv))
   CS(6,z.v=cosh(fv))CS(7,z.v=tanh(fv))CS(8,z.v=sqrt(fv*fv-1))CS(9,z.v=fv)
   CS(10,z.v=abs(fv))CS(-1,z.v=asin(fv))CS(-2,z.v=acos(fv))
   CS(-3,z.v=atan(fv))CS(-4,z.v=(fv+1)*sqrt((fv-1)/(fv+1)))
   CS(-5,z.v=asinh(fv))CS(-6,z.v=acosh(fv))CS(-7,z.v=atanh(fv))
   CS(-8,z.v=-sqrt(fv*fv-1))CS(-9,z.v=fv)CS(-10,z.v=fv)}R;}
 err(16);)