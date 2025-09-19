{
  infra-debug-tools,
  dockerTools,
}:
let
  port = 8008;
in
dockerTools.buildLayeredImage {
  name = "budstudio/concurrency-test";
  tag = "git";

  contents = [ infra-debug-tools ];

  config = {
    Cmd = [
      ("${infra-debug-tools}/bin/concurrency-test")
    ];
    Env = [
      "PORT=${builtins.toString port}"
    ];
    ExposedPorts = {
      "${builtins.toString port}/tcp" = { };
    };
  };
}
