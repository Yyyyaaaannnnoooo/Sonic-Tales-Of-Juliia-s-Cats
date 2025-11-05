// SYNTHS
(
// Server.default.options.outDevice_("Multi-Output Device");
Server.default.options.outDevice_("External Headphones");
// Server.default.options.inDevice_("BlackHole 16ch");
Server.default.options.inDevice_("VB-Cable");
s.options.numOutputBusChannels = 4;
s.options.numInputBusChannels = 2;
s.reboot;
)
s.boot

(

~retrieve_grimoire = {
  arg file;
  var path = PathName(thisProcess.nowExecutingPath).parentPath;
  PathName(path++file).fullPath.openDocument
};

~consecrate_ground = {
  s.newBusAllocators;
  ~size = 8192;
  ~waves = 16;
  ~hop = 0.25;
  ~win = 0;

  ~bus1 = Bus.audio(s, 2);
  ~bus2 = Bus.audio(s, 2);
  ~bus3 = Bus.audio(s, 2);
  ~bus4 = Bus.audio(s, 2);

  ~ch1 = Bus.audio(s, 2);
  ~ch2 = Bus.audio(s, 2);
  ~ch3 = Bus.audio(s, 2);
  ~ch4 = Bus.audio(s, 2);
  ~ch5 = Bus.audio(s, 2);
  ~sigils = Group.new;
  ~cursed_lands = Group.after(~sigils);
  ~eoc = Group.after(~cursed_lands);
  s.meter;
  s.scope;
  s.plotTree;
};



~weave_sigils = {

  ~spectral = {
    arg buf;
    "Spectral".postln;
    Buffer.alloc(s, buf.duration.calcPVRecSize(~size, ~hop), 1);
  };

  ~spectral_calling = {
    arg recbuf=1, soundbuf=2;
    "Calling...".postln;
    Synth(\pvrec_mono, [\recBuf, recbuf, \soundBufnum, soundbuf]);
  };

  ~summon = {
    arg out=0, recbuf=1, sample=2;
    var result = nil;
    if(~sigils == nil)
    {result = "Groups are not initialized, evaluate '~init.()' and retry"}
    {result = Synth(\fftscrub_mono,[\out, out, \recBuf, recbuf, \sample, sample],target: ~sigils)};
    result
  };

  ~spirit_calling = {
    var rite=30, gesture;
    {
      Buffer.freeAll;
      ~cat_sigil = Buffer.read(s, "/Users/ya/Documents/___projects/Yule-the-cat/sc/audio/ulla-purr-loop.wav");
      ~server = Buffer.read(s, "/Users/ya/Documents/___projects/Yule-the-cat/sc/audio/server-room.wav");
      "Oh Cat spirits join this world".postln;
      0.5.wait;
      ~cat_spectre = ~spectral.(~cat_sigil);
      0.5.wait;
      ~spectral_calling.(~cat_spectre, ~cat_sigil);
      gesture =  ~cat_sigil.duration / rite;
      {
        rite.do({
          "purr".postln;
          gesture.wait;
        });
      }.fork;
      ~cat_sigil.duration.wait;
      "spirts have reached this world".postln;
    }.fork
  };

  ~travel_to_cursed_lands = {
    ~server_scourge = Synth(\sampler, [\buf, ~server, \out, ~ch4], target:~cursed_lands)
  };


  SynthDef(\pvrec_mono, {
    arg recBuf=0, soundBufnum=0;
    var bufnum, in, chain;
    in = PlayBuf.ar(
      2, soundBufnum,
      BufRateScale.kr(soundBufnum),
      loop: 0,
      doneAction:2
    );
    bufnum = LocalBuf.new(~size); // uses frame size from above
    chain = FFT(bufnum, in, 0.25, 1);
    chain = PV_RecordBuf(chain, recBuf, 0, 1, 0, 0.25, 1);
  }).add;


  SynthDef(\sampler, {
    arg buf, out, rate=1, amp=1;
    var sig, line;
    line = Line.kr(0, 1, 60*2);
    sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, loop:1);
    sig = sig*line;
    Out.ar(out, sig * amp.varlag(5));
  }).add;

  SynthDef(\fftscrub_mono,
    {
      arg out=0, recBuf, sample=0, start=0, dura = 1;
      var chain1, chain2, bufnum,
      sig, sig1, sig12, sig2,
      sig3, sig4, env, trig,
      ampl, position, rate, mod,
      pitch, bin, wipe, width, pos, end=1;
      pitch = \pitch.kr(1, 0.5);
      wipe = \wipe.kr(0, 0.5);
      width = \width.kr(0.25, 0.5);
      bin = \bin.kr(1, 3);
      pos = \pos.kr(0, \plag.kr(0));
      bufnum ={LocalBuf.new(~size)}!2;
      trig = \ttt.tr(1);
      rate = \rate.kr(1).varlag(\lag.kr(5), warp: \sin);
      end = start + dura;
      end.clip(0, 1);
      position = Phasor.kr(trig, (256 / BufFrames.kr(recBuf)) * rate , 0, 1, 0);
      mod = SinOsc.kr(\lfo.kr(0.001)).range(0, \mul.kr(0));
      chain1 = PV_BufRd(
        bufnum,
        recBuf,
        pos +
        position +
        mod
      );
      chain1 = PV_PitchShift(chain1, pitch);
      chain1 = PV_BinShift(chain1, bin, \shift.kr(0, 0.75));
      chain1 = PV_BinScramble(chain1, wipe, width, \tt.tr(1));
      sig1 = IFFT(chain1, 1);
      // use BufRd here!
      sig2 = PlayBuf.ar(
        numChannels: 2,
        bufnum: sample,
        rate:BufRateScale.kr(sample) * rate,
        trigger: trig,
        startPos: 0,
        loop: 1);
      sig4 = Splay.ar(sig2, 1);
      sig3 = SelectX.ar(\sel.kr(0), [sig1, sig4]);
      sig = Select.ar((rate.abs<1), [sig2, sig3]);
      // Out.ar(aux, sig * \send.kr(-12.dbamp, 0.5));
      Out.ar(out, sig * \amp.kr(0.dbamp, 0.5));
  }).add;

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

  SynthDef(\eoc, {
    arg in1 = 0, in2 = 2, in3 = 4, in4 = 6;
    var input1 = In.ar(in1, 2);
    var input2 = In.ar(in2, 2);
    var input3 = In.ar(in3, 2);
    var input4 = In.ar(in4, 2);
    var sig1, sig2, sig3, sig4;
    sig1= RLPF.ar(input1, \lpf.kr(19000, 0.25).clip(20, 19000));
    sig1 = RHPF.ar(sig1, \hpf.kr(20, 0.5).clip(20, 19000));
    sig1 = LeakDC.ar(sig1);

    sig2= RLPF.ar(input2, \lpf.kr(19000, 0.25).clip(20, 19000));
    sig2 = RHPF.ar(sig2, \hpf.kr(20, 0.5).clip(20, 19000));
    sig2 = LeakDC.ar(sig2);

    sig3= RLPF.ar(input3, \lpf.kr(19000, 0.25).clip(20, 19000));
    sig3 = RHPF.ar(sig3, \hpf.kr(20, 0.5).clip(20, 19000));
    sig3 = LeakDC.ar(sig3);

    sig4= RLPF.ar(input4, \lpf.kr(19000, 0.25).clip(20, 19000));
    sig4 = RHPF.ar(sig4, \hpf.kr(20, 0.5).clip(20, 19000));
    sig4 = LeakDC.ar(sig4);

    ReplaceOut.ar(0,
      [
        sig1[0], sig1[1],
        sig2[0], sig2[1],
        sig3[0], sig3[1],
        sig4[0], sig4[1]
    ]);
  }).add;
}
)

~consecrate_ground.()
~weave_sigils.()


(
~sonic_gate = Synth(\eoc, [
  \in1, ~ch1,
  \in2, ~ch2,
  \in3, ~ch3,
  \in4, ~ch4
],target:~eoc);
)

~sonic_gate.free


~spirit_calling.()
~travel_to_cursed_lands.()
~server_scourge.free
~juliia.free

~server_scourge.set(\amp, -15.dbamp)

~juliia1 = ~summon.(~ch1, ~cat_spectre, ~cat_sigil);
~juliia2 = ~summon.(~ch2, ~cat_spectre, ~cat_sigil);
~juliia3 = ~summon.(~ch3, ~cat_spectre, ~cat_sigil);
~juliia.set(\amp, 3.dbamp)
~juliia1.set(\rate, 0.76)
~juliia2.set(\rate, 0.2)
~juliia3.set(\rate, 0.99)
~juliia.set(\bin, 1);
~juliia1.set(\pitch, 1);
~juliia2.set(\pitch, 0.5);
~juliia3.set(\pitch, 1);

(
// wipe, width, \tt.tr(1)
~juliia.set(\wipe, 0);
~juliia.set(\width, 0.05);
~juliia.set(\tt, 1)
)


(
~wipe.stop;
~wipe = {
  loop{
    ~juliia.set(\wipe, 0.2);
    ~juliia.set(\width, 0.125);
    ~juliia.set(\tt, 1);
    0.5.wait
  }
}.fork
)

~wipe.stop

Fork


// TESTING GROUNDS
