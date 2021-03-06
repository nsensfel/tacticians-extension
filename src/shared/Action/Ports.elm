port module Action.Ports exposing (..)

port get_params : () -> (Cmd msg)
port params_in : (String -> msg) -> (Sub msg)
port set_params : (String) -> (Cmd msg)

port get_results : () -> (Cmd msg)
port results_in : (String -> msg) -> (Sub msg)
port set_results : (String) -> (Cmd msg)

port activate_notification : () -> (Cmd msg)
port disable_notification : () -> (Cmd msg)
