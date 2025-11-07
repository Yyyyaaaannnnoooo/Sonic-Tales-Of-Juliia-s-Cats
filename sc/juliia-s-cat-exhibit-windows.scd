(

// Set this file as startup file so that to run the thing is only double click on scd logo

// curse does not work due to toString problem!!!!!!
Server.default.options.outDevice_("ASIO4ALL v2");
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
		~retrieve_grimoire.("grimoire-windows.scd");
		0.5.wait;
		~spirit_calling.();
		35.wait;
		~sonic_gate = Synth(\eoc, [\in1, ~ch1,\in2, ~ch2,\in3, ~ch3,\in4, ~ch4],target:~eoc);
	}.fork;

	~purrstroy = {
		40.wait;
		inf.do({
			arg iteration;
			"NEW ITERATION".postln;
			iteration.postln;
			Date.new.postln;
			~yule = ~summon.(~ch1, ~cat_spectre, ~cat_sigil);
			~yule.set(\amp, 1);
			60.wait;
			// 60.5
			~yule.set(\rate, 0);
			10.do({
				var tune = [0.1, 0.2, 0.3, 0.45, 0.5, 0.6].choose;
				~yule.set(\pamp, 0.125);
				~yule.set(\amp, 1);
				~enchant.();
				~yule.set(\pos, tune);
				10.wait;
				~yule.set(\amp, 0);
				1.wait;
			});
			//170
			Date.new.postln;
			~yule.set(\amp, 1);
			~yule.set(\pamp, 5);


			~sigil.();
			1.wait;
			~curse.(1);
			~yule.set(\rate, 2);
			10.wait;


			~sigil.();
			1.wait;
			~curse.(0.92);
			~yule.set(\rate, 1);
			10.wait;


			~sigil.();
			1.wait;
			~curse.(0.85);
			~yule.set(\rate, 0.75);
			10.wait;


			~sigil.();
			1.wait;
			~curse.(0.75);
			~yule.set(\rate, 0.5);
			10.wait;
			//  170 + 44 = 214
			Date.new.postln;
			~sigil.();
			1.wait;
			~curse.(0.6);
			~yule.set(\amp, -6.dbamp);
			3.wait;
			// 218

			~sigil.();
			1.wait;
			~curse.(0.5);
			~yule.set(\amp, -12.dbamp);
			3.wait;
			// 220

			~sigil.();
			1.wait;
			~curse.(0.4);
			~yule.set(\amp, -18.dbamp);
			3.wait;
			// 224

			~sigil.();
			1.wait;
			~curse.(0.3);
			~yule.set(\amp, -24.dbamp);
			3.wait;
			// 228

			~curse.(0.2);
			~yule.set(\amp, -30.dbamp);
			3.wait;
			// 231

			~curse.(0.3);
			~yule.set(\amp, 0);
			3.wait;
			~curse.(0.1);
			~yule.free;
			// 234
			// "wait this amount of time until next iteration"
			// 690.wait;
			Date.new.postln;
			666.wait;
		})
	}.fork

})
)



// 16;11;24
// 16;15;20