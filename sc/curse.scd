SynthDef(\curse, {
  arg buf, out, amp=1, trig = 1;
  var sig, line,
  frames = BufFrames.kr(buf),
  start = 0, trigger, retrig = 5,
  rate=1, sr = 48000, br = 24,
  mod1 = 0, mod2=0, vol = 1;
  trigger = Dust.kr(trig);
  mod1 = Latch.kr(LFNoise0.kr().range(0, 1), trigger);
  mod2 = Line.kr(0, 1, 30);
  vol =
  Pulse.kr(
    mod1.linlin(0,1, 0.01, 2)
  ).range(0,1) *
  Pulse.kr(
    mod1.linlin(0,1, 0.02, 2)
  ).range(0,1);

  vol = 1 - (vol * mod2.linexp(0.01, 1, 0.01, 1));

  /**
  Pulse.kr(
    mod1.linlin(0,1, 0.3, 1)
  ).range(0,1);*/

  sig = PlayBuf.ar(2,
    buf,
    BufRateScale.kr(buf) * rate,
    trigger: 1,
    startPos: 0,
    loop:1
  );

  sr = mod2.linlin(0, 1, 48000, 8000);
  br = mod2.linlin(0,1,24, 10);
  sig = Decimator.ar(sig, rate: sr, bits: br);

  sig = sig*vol;
  // sig = sig*line;
  Out.ar(out, sig*amp.varlag(0.5));
}).add;