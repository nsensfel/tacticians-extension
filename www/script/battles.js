/******************************************************************************/
/** Battles Management ********************************************************/
/******************************************************************************/
var tacticians_online = tacticians_online || new Object();

tacticians_online.battles = new Object();

tacticians_online.battles.get =
function ()
{
   tacticians_online.app.battles_in.send(localStorage.getItem("battles"));
}

tacticians_online.battles.set =
function (encoded_battles)
{
   localStorage.setItem("battles", encoded_battles);
}

tacticians_online.battles.get_value =
function ()
{
   return localStorage.getItem("battles");
}

tacticians_online.battles.attach_to =
function (app)
{
   app.ports.get_battles.subscribe(tacticians_online.battles.get);
   app.ports.set_battles.subscribe(tacticians_online.battles.set);
}

