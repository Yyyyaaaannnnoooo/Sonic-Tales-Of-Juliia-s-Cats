// FOR PERFORMANCE REMEBER to do rate 0 and change pos!!!
(
// Server.default.options.outDevice_("Multi-Output Device");
Server.default.options.outDevice_("BlackHole 16ch");
// Server.default.options.inDevice_("BlackHole 16ch");
Server.default.options.inDevice_("VB-Cable");
s.options.numOutputBusChannels = 8;
s.options.numInputBusChannels = 2;
s.boot;
)

(
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

~retrieve_grimoire = {
  arg file;
  var path = PathName(thisProcess.nowExecutingPath).parentPath;
  (path++file).postln;
  PathName(path++file).fullPath.load
};



~weave_sigils = {
  // ~enchant.();
  {
    ~juliia1 = ~summon.(~ch1, ~cat_spectre, ~cat_sigil);
    0.4.wait;
    ~juliia2 = ~summon.(~ch2, ~cat_spectre, ~cat_sigil);
    0.4.wait;
    ~juliia3 = ~summon.(~ch3, ~cat_spectre, ~cat_sigil);

  }.fork

};

~return_spirits = {
  ~juliia1.free;
  ~juliia2.free;
  ~juliia3.free;
};

~feline_conjuring = {
  arg potency = 0.9;
  ~enchant.();
  ~juliia1.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
  ~juliia2.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
  ~juliia3.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
};

// 0.1  nice value for weird spectral sounds
// when rate = 0.9!
~spectral_murmur = {
  arg spectre, murmur;
  var spectres = ~get_spectre.(spectre, murmur);
  ~enchant.();

  ~juliia1.set(\rate, 0.9);
  ~juliia2.set(\rate, 0.9);
  ~juliia3.set(\rate, 0.9);
  ~juliia1.set(\bin, spectres[0]);
  ~juliia2.set(\bin, spectres[1]);
  ~juliia3.set(\bin, spectres[2]);
};

~spectral_shriek = {
  arg potency;
  var spectres = ~get_spectre.(~spectres.size.rand, potency);
  ~enchant.();
  ~juliia1.set(\bin, spectres[0]);
  ~juliia2.set(\bin, spectres[1]);
  ~juliia3.set(\bin, spectres[2]);
};

~sidereal_call = {
  ~enchant.();
  ~juliia1.set(\rate, 0);
  ~juliia2.set(\rate, 0);
  ~juliia3.set(\rate, 0);

  ~juliia1.set(\pos, 1.0.rand);
  ~juliia2.set(\pos, 1.0.rand);
  ~juliia3.set(\pos, 1.0.rand);
};

~whisper = {
  arg potency;
  ~juliia1.set(\pos, potency);
  ~juliia2.set(\pos, potency);
  ~juliia3.set(\pos, potency);
};


~frost_wavering = {
  arg potency, haste;
  ~enchant.();
  ~juliia1.set(\mul, potency);
  ~juliia2.set(\mul, potency);
  ~juliia3.set(\mul, potency);
  ~juliia1.set(\lfo, haste);
  ~juliia2.set(\lfo, haste);
  ~juliia3.set(\lfo, haste);
};

~serenity = {
  // ~enchant.();
  ~juliia1.set(\bin, 1);
  ~juliia2.set(\bin, 1);
  ~juliia3.set(\bin, 1);
  ~feline_conjuring.(0.9)
};
)



~consecrate_ground.()


~retrieve_grimoire.("grimoire.scd")

(
~sonic_gate = Synth(\eoc, [
  \in1, ~ch1,
  \in2, ~ch2,
  \in3, ~ch3,
  \in4, ~ch4
],target:~eoc);
)
~sonic_gate.free

~travel_to_cursed_lands.()
~server_scourge.free
~server_scourge.set(\amp, 0.dbamp)
~server_scourge.set(\rate, 0.5)



~spirit_calling.()

~weave_sigils.()



~feline_conjuring.(0.5)

~spectral_murmur.(5, 0.2)
~spectral_shriek.(1)
~serenity.()


~sidereal_call.()
~frost_wavering.(0, 0.05)


~return_spirits.()

~chant_the_lore.()


// TESTING GROUNDS


(
var spectres = ~get_spectre.(4, 0.6);
~juliia1.set(\bin, spectres[0]);
~juliia2.set(\bin, spectres[1]);
~juliia3.set(\bin, spectres[2]);
)

(

~feline_conjuring = {
  arg potency = 0.9;
  ~enchant.();
  ~juliia1.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
  ~juliia2.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
  ~juliia3.set(\rate, (potency + 0.25.rand2).clip(-0.9, 0.9));
};

// 0.1  nice value for weird spectral sounds
// when rate = 0.9!
~spectral_murmur = {
  arg spectre, murmur;
  var spectres = ~get_spectre.(spectre, murmur);
  ~enchant.();

  ~juliia1.set(\rate, 0.9);
  ~juliia2.set(\rate, 0.9);
  ~juliia3.set(\rate, 0.9);
  ~juliia1.set(\bin, spectres[0]);
  ~juliia2.set(\bin, spectres[1]);
  ~juliia3.set(\bin, spectres[2]);
};

~serenity = {
  ~enchant.();
  ~juliia1.set(\bin, 1);
  ~juliia2.set(\bin, 1);
  ~juliia3.set(\bin, 1);
  ~feline_conjuring.(0.9)
}
)
(
~juliia1.set(\bin, 1);
~juliia2.set(\bin, 1);
~juliia3.set(\bin, 1);
)


~juliia.set(\bin, 1.5);

~juliia.set(\rate, 0.089)
~juliia.set(\shift, 0);

~juliia.set(\amp, 3.dbamp)
(
// wipe, width, \tt.tr(1)
var chaos  = 0;
~juliia1.set(\wipe, chaos);
~juliia1.set(\width, 0.5);
~juliia1.set(\tt, 1);
~juliia2.set(\wipe, chaos);
~juliia2.set(\width, 0.5);
~juliia2.set(\tt, 1);
~juliia3.set(\wipe, chaos);
~juliia3.set(\width, 0.5);
~juliia3.set(\tt, 1);
)



(

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



