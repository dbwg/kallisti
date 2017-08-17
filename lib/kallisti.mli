open Lwt

(** [start api_base token] starts up the Discord connection/event loop *)
val start : ?api_base:string -> string -> unit Lwt.t

(** [connect token gateway_uri] establishes a connection to the WebSocket gateway
      and performs an `IDENTIFY`. *)
val connect : string -> Uri.t -> unit Lwt.t

(** [get_gateway api_base token] gets the (bot) Gateway URI and the recommended number of shards,
      taking a token to authorize with. *)
val get_gateway : string -> string -> (Uri.t * int) Lwt.t
