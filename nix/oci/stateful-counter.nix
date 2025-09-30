{
  infra-debug-tools,
  dockerTools,
}:
let
  port = 8008;
in
dockerTools.buildLayeredImage {
  name = "budstudio/stateful-counter";
  tag = "git";

  contents = [ infra-debug-tools ];

  config = {
    Cmd = [
      ("${infra-debug-tools}/bin/stateful-counter")
    ];
    Env = [
      "PORT=${builtins.toString port}"
    ];
    ExposedPorts = {
      "${builtins.toString port}/tcp" = { };
    };
  };
}
