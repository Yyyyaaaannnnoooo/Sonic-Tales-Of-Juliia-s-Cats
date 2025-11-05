
(

~purr_paths = [
  "/Users/ya/Documents/___projects/Yule-the-cat/sc/ascii/cat1.txt",
  "/Users/ya/Documents/___projects/Yule-the-cat/sc/ascii/cat2.txt",
  "/Users/ya/Documents/___projects/Yule-the-cat/sc/ascii/cat3.txt",
];
~server_scourge_curse = File.readAllString("/Users/ya/Documents/___projects/Yule-the-cat/sc/ascii/server1.txt");

~purr_incantations = ~purr_paths.collect({
  arg item, i;
  File.readAllString(item);
});

~whisper_incantation = {
  arg incantation, haste;
  {
    incantation.do({
      arg gesture;
      gesture.postln;
      haste.wait
    })
  }.fork
};

~enchant = {
  arg casting_haste = 0.05,
  incantation,
  purrs = 10 + rand(20);
  incantation = ~purr_incantations[3.rand];
  {
    incantation = incantation.split($\n);
    ~whisper_incantation.(incantation, casting_haste);
    (casting_haste * incantation.size).wait;
    {
      purrs.do({
        arg pu;
        ("purr"++("rr"!pu).toString).postln;
        casting_haste.wait
    })}.fork;
    (purrs * casting_haste).wait;
  }.fork
};

~sigil = {
  var casting_haste = 0.1,
  incantation,
  purrs = 10 + rand(30);
  incantation = ~purr_incantations[3.rand];
  {
    incantation = incantation.split($\n);
    ~whisper_incantation.(incantation, casting_haste);
    (casting_haste * incantation.size).wait;
    /*    {
    purrs.do({
    arg pu;
    ("purr"++("r"!pu).toString).postln;
    casting_haste.wait
    })}.fork;
    (purrs * casting_haste).wait;*/
  }.fork
};

~curse = {
  arg strength=30;
  var casting_haste = 0.1,
  // curse = ~server_scourge_curse.replace("|", sigil);
  curse = ~blaze.(~server_scourge_curse, strength);
  {
    ~whisper_incantation.(curse.split($\n), casting_haste);
    (casting_haste * curse.split($\n).size).wait;
  }.fork
};

~blaze = {
  arg curse, strength = 0;
  var runes, mending = "🔥";
  runes = (0!curse.size);
  curse.do({
    arg to_mend, i;
    // i.postln;
    runes.put(i, to_mend);
    if(to_mend != "\n"){
      if(i%strength==0)
      {runes.put(i, mending)};
    };

    // 0.1.wait
  });
  if(strength>curse.size)
  {curse}
  {runes.toString}
};

//
// {
//   ~enchant.();
//   3.wait;
//   ~curse.(120000)
// }.fork;

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
  {
    result = Synth(\fftscrub_mono,[\out, out, \recBuf, recbuf, \sample, sample],target: ~sigils);
    ~sigil.();
  };
  result
};

~spirit_calling = {
  var rite=30, gesture;
  {
    Buffer.freeAll;
    ~cat_sigil = Buffer.read(s, "/Users/ya/Documents/___projects/Yule-the-cat/sc/audio/ulla-purr-loop.wav");
    0.5.wait;
    ~server = Buffer.read(s, "/Users/ya/Documents/___projects/Yule-the-cat/sc/audio/server-room.wav");
    "Oh Cat spirits join this world".postln;
    0.5.wait;
    ~cat_spectre = ~spectral.(~cat_sigil);
    0.5.wait;
    ~spectral_calling.(~cat_spectre, ~cat_sigil);
    gesture =  ~cat_sigil.duration / rite;
    {
      rite.do({
        arg pu;
        // "purr".postln;
        ("purr"++("r"!pu).toString).postln;
        gesture.wait;
      });
    }.fork;

    // ~enchant.();
    // ~enchant.();

    ~cat_sigil.duration.wait;
    "spirts have reached this world".postln;
    ~sigil.();
    0.6.wait;
    ~sigil.();
    0.6.wait;
    ~sigil.();
  }.fork
};

~travel_to_cursed_lands = {
  arg out = ~ch4;
  ~curse.(120000);
  ~server_scourge = Synth(\sampler, [\buf, ~server, \out, out, \fadein, 120], target:~cursed_lands)
};



d = Dictionary.newFrom([
  \C, 0,
  'C#', 1,
  \D, 2,
  'D#', 3,
  \Eb, 3,
  \E, 4,
  \F, 5,
  'F#', 6,
  \G, 7,
  'G#', 8,
  \Ab, 8,
  \A, 9,
  \Bb, 10,
  \B, 11,

]);

~spectres = [
  ["C", "Eb", "G"],
  ["F", "Ab", "C"],
  ["C", "Eb", "G"],
  ["G", "B",  "D"],

  ["C", "Eb", "G"],
  ["F", "Ab", "C"],
  ["Ab", "C", "Eb"],
  ["G", "B", "D"],

  ["D", "F", "A"],
  ["A", "C#", "E"],
  ["G", "Bb", "D"],
  ["A", "C#", "E"],
  ["D", "F", "A"],

  ["D", "F", "A"],
  ["C#", "F", "G#"],
  ["A", "C#", "E"],

  ["Eb", "G", "Bb"],
  ["Bb", "D", "F"],
  ["C", "Eb", "G"],
  ["Ab", "C", "Eb"],

  ["Eb", "G", "Bb"],
  ["Bb", "D", "F"],
  ["C", "Eb", "G"],
  ["G", "Bb", "D"],
  ["Ab", "C", "Eb"],
  ["Eb", "G", "Bb"],
  ["Ab", "C", "Eb"],
  ["Bb", "D", "F"],
  ["A", "C", "E"],
  ["C", "E", "G"],
  ["F", "A", "C"],
  ["G", "B", "D"],

];

~convert = {
  arg string;
  d.at(string.asSymbol);
};

~get_spectre = {
  arg which=0, octave = 1;
  var note = 1/12;
  ~spectres[which].collect({
    arg item, i;
    item.postln;
    (~convert.(item)*note)+(octave);
  });
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
  bufnum = LocalBuf.new(~size, 1); // uses frame size from above
  chain = FFT(bufnum, in, 0.25, 1);
  chain = PV_RecordBuf(chain, recBuf, 0, 1, 0, 0.25, 1);
}).add;


SynthDef(\sampler, {
  arg buf, out, rate=1, amp=1, fadein=60*2;
  var sig, line;
  line = Line.kr(0, 1, fadein);
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
    pitch, bin, wipe, width, pos, end=1,
    fadein = Line.kr(0, 1, 120);
    pitch = \pitch.kr(1, 0.5);
    wipe = \wipe.kr(0, 0.5);
    width = \width.kr(0.25, 0.5);
    bin = \bin.kr(1).varlag(5, warp: \sin);
    pos = \pos.kr(0).varlag(\plag.kr(1));
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
    chain1 = PV_BinShift(chain1, bin, \shift.kr(0, 0.75), 1);
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
    sig = sig*fadein;
    sig = Balance2.ar(sig[0], sig[1], \bal.kr(0).varlag(2));
    // Out.ar(aux, sig * \send.kr(-12.dbamp, 0.5));
    Out.ar(out, sig * \amp.kr(0.dbamp).varlag(\pamp.kr(5)));
}).add;

SynthDef(\recorder, {
  arg bufnum, in;
  var input = In.ar(in, 2);
  RecordBuf.ar(input, bufnum, loop: 1);
  0;
}).add;

SynthDef(\curse, {
  arg buf, out, amp=0.5, trig = 1, bpf = 100;
  var sig, line,
  frames = BufFrames.kr(buf),
  start = 0, trigger, retrig = 5,
  rate=1, sr = 48000, br = 24,
  mod1 = 0, mod2=0, vol = 1, env, dur=0.1;
  trigger = Dust.kr(trig);
  dur = Latch.kr(LFNoise0.kr().range(0, trig.reciprocal), trigger);
  env = 1 - EnvGen.kr(
    Env([0,1,1,0],[0,dur,0]),
    gate: trigger
  );

  //
  // mod2 = Line.kr(0, 1, 3);
  // vol =
  // Pulse.kr(
  //   mod1.linlin(0,1, 0.01, 2)
  // ).range(0,1) *
  // Pulse.kr(
  //   mod1.linlin(0,1, 0.02, 2)
  // ).range(0,1);
  //
  // vol = 1 - (vol * mod2.linexp(0.01, 1, 0.01, 1));

  sig = PlayBuf.ar(2,
    buf,
    BufRateScale.kr(buf) * rate,
    trigger: trigger,
    startPos: 0,
    loop:1
  );

  bpf = bpf.varlag(2);
  sig = BPF.ar(sig, bpf, 200/bpf);
  // sr = mod2.linlin(0, 1, 48000, 8000);
  // br = mod2.linlin(0,1,24, 10);
  // sig = Decimator.ar(sig, rate: sr, bits: br);

  sig = sig*env;
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

// ascii sorcery



// MIDIClient.init;
// MIDIIn.connectAll;
// MIDIIn.connect(inport: 0, device: MIDIClient.sources.at(2));
// // m = MIDIOut.connect(inport:0, device: MIDIClient.sources.at(0));
// // m = MIDIOut.newByName("IAC Driver", "Bus 1");
// // MIDIClient.sources
// // MIDIIn.controlList
// MIDIFunc.trace(true);
//
// MIDIFunc.trace(false);
//
// MIDIdef.freeAll;
//
//
// // blend fft playbuf
// ~sl9 = MIDIdef.cc(\sl9,{
//   arg val, num, chan;
//   ~fade = val.linlin(0, 127, 0,1);
//   // ~fade.postln;
//   ~whisper.(~fade);
// },78, 8);
//
//


)
