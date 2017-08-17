let uri_with_params ?(enc="json") ?(ver=6) base_uri =
  Uri.with_query' base_uri [("encoding", enc); ("v", string_of_int 6)]
