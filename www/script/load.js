tacticians_online.params.load();

tacticians_online.app =
   Elm.Main.fullscreen
   (
      {
         frequency: tacticians_online.params.get_frequency(),
         players: tacticians_online.params.get_players()
      }
   );

tacticians_online.params.attach_to(tacticians_online.app);
