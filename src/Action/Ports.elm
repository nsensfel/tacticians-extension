port module Action.Ports exposing (..)

port store_new_params : (Int, (List String)) -> (Cmd msg)
port reset_params : () -> (Cmd msg)
