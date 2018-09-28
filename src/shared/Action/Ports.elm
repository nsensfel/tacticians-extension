port module Action.Ports exposing (..)

port get_params : () -> (Cmd msg)
port params_in : ((Int, String) -> msg) -> (Sub msg)
port set_params : (Int, String) -> (Cmd msg)

port get_results : () -> (Cmd msg)
port results_in : (String -> msg) -> (Sub msg)
port set_results : (String) -> (Cmd msg)

port set_signal : (Bool) -> (Cmd msg)
