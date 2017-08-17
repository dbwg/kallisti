open Core
open Lwt
open Cohttp
open Cohttp_lwt_unix

open Rest

let section = Lwt_log.Section.make "kallisti"
let logi msg = Lwt_log.info ~section ("[i] " ^ msg)
let logd msg = Lwt_log.debug ~section ("[d] " ^ msg)


let get_gateway api_base token =
  let headers = (Header.init_with "Authorization" ("Bot " ^ token)) in
  Client.get ~headers (Endpoints.bot_gateway api_base) >>=
  Rest.handle_response >|= function
  | `Assoc [("url", `String uri); ("shards", `Int shards)] -> (Uri.of_string uri, shards)
  | unknown_resp -> failwith_json unknown_resp

let connect token gateway_uri =
  logi ("Connecting to the gateway with uri " ^ Uri.to_string gateway_uri)
  (* Lwt.return_unit *)

let start ?(api_base=Rest.api_base) token =
  let%lwt gateway_base_uri, n_shards = get_gateway api_base token in
  let gateway_uri = (Gateway.uri_with_params gateway_base_uri) in
  logi (Uri.to_string gateway_uri)
  (* logi ("Discord recommends " ^ string_of_int n_shards ^ " shards") >> *)
  (* connect token gateway_uri *)
