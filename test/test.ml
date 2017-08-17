open Lwt

let token = "MzI3NTk1MjkzNjE5MjU3MzQ1.DFQnzw.zFQ2ATHWtjjNS3w-s__Z0CKh5D8"

let main_thr =
  Lwt_log.(add_rule "kallisti" Debug);
  Kallisti.start token

let () =
  Lwt_main.run main_thr
