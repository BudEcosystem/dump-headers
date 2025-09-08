{
  dh,
  lib,
  dockerTools,
}:
let
  port = 8008;
in
dockerTools.buildLayeredImage {
  name = "budstudio/dump-headers";
  tag = "git";

  contents = [
    dh
  ];

  config = {
    Cmd = [
      (lib.getExe dh)
    ];
    Env = [
      "PORT=${builtins.toString port}"
    ];
    ExposedPorts = {
      "${builtins.toString port}/tcp" = { };
    };
  };
}
