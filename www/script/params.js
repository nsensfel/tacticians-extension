/******************************************************************************/
/** Session Management ********************************************************/
/******************************************************************************/
var tacticians_online = tacticians_online || new Object();

tacticians_online.params = new Object();

tacticians_online.params.private = new Object();
tacticians_online.params.private.frequency = 1;
tacticians_online.params.private.players = "";

tacticians_online.params.reset =
function ()
{
   localStorage.removeItem("frequency");
   localStorage.removeItem("players");
}

tacticians_online.params.load =
function ()
{
   tacticians_online.params.private.frequency =
      localStorage.getItem("frequency");

   tacticians_online.params.private.players = localStorage.getItem("players");

   if (tacticians_online.params.private.frequency == null)
   {
      tacticians_online.params.private.frequency = 1;
   }

   if (tacticians_online.params.private.players == null)
   {
      tacticians_online.params.private.players = "";
   }
}

tacticians_online.params.get_frequency =
function ()
{
   return tacticians_online.params.private.frequency;
}

tacticians_online.params.get_players =
function ()
{
   return tacticians_online.params.private.players;
}

tacticians_online.params.set_frequency =
function (frequency)
{
   tacticians_online.params.private.frequency = frequency;

   localStorage.setItem
   (
      "frequency",
      tacticians_online.params.private.frequency
   );
}

tacticians_online.params.set_players =
function (players)
{
   tacticians_online.params.private.players = players;
   localStorage.setItem("players", tacticians_online.params.private.players);
}

tacticians_online.params.set_params =
function (params)
{
   var [frequency, players] = params;
   tacticians_online.params.set_frequency(frequency);
   tacticians_online.params.set_players(players);
}

tacticians_online.params.js_get =
function ()
{
   return {get_frequency(), get_players()};
}

tacticians_online.params.get =
function ()
{
   tacticians_online.app.params_in.send(tacticians_online.params.js_get());
}

tacticians_online.params.attach_to =
function (app)
{
   app.ports.get_params.subscribe(tacticians_online.params.get);
   app.ports.set_params.subscribe(tacticians_online.params.set);
   app.ports.reset_params.subscribe(tacticians_online.params.reset);
}

