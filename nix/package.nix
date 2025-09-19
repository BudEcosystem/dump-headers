{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "infra-debug-tools";
  version = "git";

  src = lib.cleanSourceWith {
    filter =
      name: type:
      lib.cleanSourceFilter name type
      && !(builtins.elem (baseNameOf name) [
        "nix"
        "flake.nix"
      ]);

    src = ../.;
  };
  vendorHash = null;

  meta = {
    platforms = lib.platforms.unix;
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
})
