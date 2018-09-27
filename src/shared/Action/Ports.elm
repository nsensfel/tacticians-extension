port module Action.Ports exposing (..)

port read_params : () -> (Cmd msg)
port store_params : (Int, String) -> (Cmd msg)
port store_results : (String) -> (Cmd msg)
