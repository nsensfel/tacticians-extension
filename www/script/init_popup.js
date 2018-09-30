tacticians_online.app =
   Elm.Main.fullscreen
   (
      {
         params: tacticians_online.params.get_value(),
         players: tacticians_online.battles.get_value()
      }
   );

tacticians_online.params.attach_to(tacticians_online.app);
tacticians_online.battles.attach_to(tacticians_online.app);
