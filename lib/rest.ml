open Lwt
open Cohttp

let api_base = "https://discordapp.com/api/v6"

module Endpoints = struct
	let gateway base_uri = Uri.of_string (base_uri ^ "/gateway")
  let bot_gateway base_uri = Uri.of_string (base_uri ^ "/gateway/bot")
end

(** Fails with a pretty-prented JSON response *)
let failwith_json json =
  failwith ("Unexpected response: " ^ (Yojson.Basic.pretty_to_string json))

let handle_response (resp, body) =
	let resp_code = resp |> Response.status |> Code.code_of_status in
	match resp_code with
	| 200 -> body |> Cohttp_lwt_body.to_string >|= Yojson.Basic.from_string
	| code -> failwith ("unexpected response code " ^ (string_of_int code))
