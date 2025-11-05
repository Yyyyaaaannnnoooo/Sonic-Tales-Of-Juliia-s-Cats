// SYNTHS
(
// Server.default.options.outDevice_("Multi-Output Device");
Server.default.options.outDevice_("usbs");
// Server.default.options.inDevice_("BlackHole 16ch");
Server.default.options.inDevice_("VB-Cable");
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 2;
s.reboot;
)
(
Server.default.options.outDevice_("usbs");
s.options.numOutputBusChannels = 2;
s.waitForBoot({
  ~consecrate_ground = {
    s.newBusAllocators;
    ~size = 8192;
    ~waves = 16;
    ~hop = 0.25;
    ~win = 0;

    ~ch1 = Bus.audio(s, 2);
    ~sigils = Group.new;
    ~cursed_lands = Group.after(~sigils);
    ~eoc = Group.after(~cursed_lands);
  };

  ~retrieve_grimoire = {
    arg file;
    var path = PathName(thisProcess.nowExecutingPath).parentPath;
    (path++file).postln;
    PathName(path++file).fullPath.load
  };

  {
    1.wait;
    ~consecrate_ground.();
    0.5.wait;
    ~retrieve_grimoire.("grimoire.scd");
    0.5.wait;
    ~spirit_calling.();
    35.wait;
    ~sonic_gate = Synth(\eoc, [\in1, ~ch1,\in2, ~ch2,\in3, ~ch3,\in4, ~ch4],target:~eoc);
  }.fork;

  ~purrstroy = {
    40.wait;
    5.do({
      arg iteration;
      "NEW ITERATION".postln;
      iteration.postln;
      0.5.wait;
      ~yule = ~summon.(~ch1, ~cat_spectre, ~cat_sigil);
      60.wait;
      ~yule.set(\rate, 0);
      10.do({
        var tune = [0.1, 0.2, 0.3, 0.45, 0.5, 0.6].choose;
        ~yule.set(\pamp, 0.5);
        ~yule.set(\amp, 1);
        ~enchant.();
        ~yule.set(\pos, tune);
        10.wait;
        ~yule.set(\amp, 0);
        1.wait;
      });
      // 15.wait;
      ~yule.set(\amp, 1);
      ~yule.set(\pamp, 5);
      ~enchant.();
      ~yule.set(\rate, 2);
      10.wait;
      ~enchant.();
      ~yule.set(\rate, 0.5);
      10.wait;
      ~enchant.();
      ~yule.set(\rate, 0.25);
      3.wait;
      ~enchant.();
      ~yule.set(\rate, 0.125);
      3.wait;
      ~yule.set(\amp, -6.dbamp);
      3.wait;
      ~yule.set(\amp, -12.dbamp);
      3.wait;
      ~yule.set(\amp, -18.dbamp);
      3.wait;
      ~yule.set(\amp, -24.dbamp);
      3.wait;
      ~yule.set(\amp, -30.dbamp);
      3.wait;
      ~yule.set(\amp, 0);
      3.wait;
      ~yule.free;
      // "wait this amount of time until next iteration"
      2.wait;
      ~yule.set(\amp, 1);
    })
  }.fork

})
)



s.meter


~spirit_calling.()
(

)
~sonic_gate.free

~travel_to_cursed_lands.(~ch1)
~server_scourge.free
~server_scourge.set(\amp, -10.dbamp)
~server_scourge.set(\rate, 0.5)


~test = Synth(\curse, [\buf, ~server, \out, ~ch1], target: ~cursed_land)

~test.set(\bpf, 600)
~test.set(\amp, -6.dbamp)
~test.set(\trig, 0.5)

~test.free


~cursed_lands.freeAll


~yule = ~summon.(~ch1, ~cat_spectre, ~cat_sigil);
~yule.set(\rate, 0)
~yule.set(\rate, 2)
~yule.set(\pos, 0.45)
~yule.set(\bal, 0)
~yule.set(\amp, -18.dbamp)
~yule.set(\amp, 0)
~yule.free
~sigils.freeAll
[0.1, 0.2, 0.3, 0.5, 0.6].choose;
(
~yule_s_dance = {
  loop{
    // var tune = 1.0.rand;
    var tune = [0.1, 0.2, 0.3, 0.45, 0.5, 0.6].choose;
    ~yule.set(\pos, tune);
    ~enchant.();
    6.wait;
  }
}.fork
)
~yule_s_dance.stop
Routine.stopAll

Routine.all.do(_.stop);



~yule2 = ~summon.(~ch2, ~cat_spectre, ~cat_sigil);
~yule2.set(\bal, 0)
~yule2.set(\rate, 0.5)
~yule2.free
~weave_sigils.()



~feline_conjuring.(0.5)

~spectral_murmur.(5, 0.2)
~spectral_shriek.(1)
~serenity.()


~sidereal_call.()
~frost_wavering.(0, 0.05)


~return_spirits.()







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


// TESTING GROUNDS
