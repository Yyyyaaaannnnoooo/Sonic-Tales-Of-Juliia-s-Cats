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
  var casting_haste = 0.1,
  incantation,
  purrs = 10 + rand(30);
  incantation = ~purr_incantations[3.rand];
  {
    incantation = incantation.split($\n);
    ~whisper_incantation.(incantation, casting_haste);
    (casting_haste * incantation.size).wait;
    {
      purrs.do({
        arg pu;
        ("purr"++("r"!pu).toString).postln;
        casting_haste.wait
    })}.fork;
    (purrs * casting_haste).wait;
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



~enchant.()
~curse.(120000)
)


// need to replace at every cycle more and more chars in the server txt
