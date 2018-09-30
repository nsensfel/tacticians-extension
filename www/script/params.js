/******************************************************************************/
/** Session Management ********************************************************/
/******************************************************************************/
var tacticians_online = tacticians_online || new Object();

tacticians_online.params = new Object();

tacticians_online.params.get =
function ()
{
   tacticians_online.app.params_in.send(localStorage.getItem("params"));
}

tacticians_online.params.set =
function (encoded_params)
{
   localStorage.setItem("params", encoded_params);
}

tacticians_online.params.get_value =
function ()
{
   return localStorage.getItem("params");
}

tacticians_online.params.attach_to =
function (app)
{
   app.ports.get_params.subscribe(tacticians_online.params.get);
   app.ports.set_params.subscribe(tacticians_online.params.set);
}

