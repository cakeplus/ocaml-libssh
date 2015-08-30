(** OCaml bindings to libssh, both Client and Server side
    functionality provided *)

(** Abstract type for an ssh session*)
type ssh_session

(** libssh's version *)
external version : unit -> string = "libssh_ml_version"
(** Create a fresh ssh_session *)
external init : unit -> ssh_session = "libssh_ml_ssh_init"
(** Close a ssh_session *)
external close : ssh_session -> unit = "libssh_ml_ssh_close"

(** Client side of ssh *)
module Client = struct

  type log_level =
    (** No logging at all *)
    | SSH_LOG_NOLOG
    (** Only warnings *)
    | SSH_LOG_WARNING
    (** High level protocol information *)
    | SSH_LOG_PROTOCOL
    (** Lower level protocol infomations, packet level *)
    | SSH_LOG_PACKET
    (** Every function path *)
    | SSH_LOG_FUNCTIONS

  type auth =
    (** Authenticate using the Ssh agent, assuming its running *)
    | Auto
    (** Type in the password on the command line*)
    | Interactive

  type options = { host: string;
                   username : string;
                   port : int;
                   log_level : log_level;
                   command : string;
                   auth : auth; }

  external connect : options -> ssh_session -> unit = "libssh_ml_ssh_connect"

  let with_session f opts =
    let handle = init () in
    connect opts handle;
    f handle;
    close handle

end

(** Server side of ssh *)
module Server = struct


end

