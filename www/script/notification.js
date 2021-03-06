/******************************************************************************/
/** Notification Management ***************************************************/
/******************************************************************************/
var tacticians_online = tacticians_online || new Object();

tacticians_online.notification = new Object();

tacticians_online.notification.activate =
function ()
{
   browser.browserAction.setBadgeText({text: "!"});
}

tacticians_online.notification.disable =
function (encoded_notification)
{
   browser.browserAction.setBadgeText({text: ""});
}

tacticians_online.notification.attach_to =
function (app)
{
   app.ports.activate_notification.subscribe
   (
      tacticians_online.notification.activate
   );
   app.ports.disable_notification.subscribe
   (
      tacticians_online.notification.disable
   );
}

