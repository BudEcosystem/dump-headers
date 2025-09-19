{
  infra-debug-tools,
  dockerTools,
}:
let
  port = 8008;
in
dockerTools.buildLayeredImage {
  name = "budstudio/dump-headers";
  tag = "git";

  contents = [ infra-debug-tools ];

  config = {
    Cmd = [
      ("${infra-debug-tools}/bin/dump-headers")
    ];
    Env = [
      "PORT=${builtins.toString port}"
    ];
    ExposedPorts = {
      "${builtins.toString port}/tcp" = { };
    };
  };
}
