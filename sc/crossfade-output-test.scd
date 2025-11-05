
(
Buffer.freeAll;
      ~cat_sigil = Buffer.read(s, "/Users/ya/Documents/___projects/Yule-the-cat/sc/audio/ulla-purr-loop.wav");
)

(
SynthDef(\test, {
  arg buf=0;
  var sig, sig1, sig2, sig3,
  amp1=0.dbamp, amp2=0.dbamp, amp3=0.dbamp,
  sel, min=0.0001;
  sig=PlayBuf.ar(2, buf, BufRateScale.kr(buf)*\rate.kr(1, 1), loop: 1);
/*
  sig1 = sig*\amp1.kr(0).varlag(5);
  sig2 = sig*\amp2.kr(0.dbamp).varlag(5);
  sig3 = sig*\amp3.kr(0).varlag(5);
*/
  // ExponentialWarp
  sel = SelectX.kr(\w.kr(0).varlag(10), [
    [1.0,min,min],
    [min,1.0,min],
    [min,min,1.0]
  ]);
  sig1 = sig*(amp1*sel[0]).linexp(min, 1, min, 1);
  sig2 = sig*(amp2*sel[1]).linexp(min, 1, min, 1);
  sig3 = sig*(amp3*sel[2]).linexp(min, 1, min, 1);

  Out.ar(0,
      [
        sig1[0], sig1[1],
        sig2[0], sig2[1],
        sig3[0], sig3[1]
    ]);
}).add
)


x = Synth(\test, [\buf, ~cat_sigil])
x.set(\w, 0)
(

x.set(\amp1, 0.dbamp);
x.set(\amp2, 0);
x.set(\amp3, 0);

)

x.free