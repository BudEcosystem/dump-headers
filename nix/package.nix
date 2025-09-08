{
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  pname = "dh";
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
    description = "Your frenly neighbourhood CI/CD.";
    platforms = lib.platforms.unix;
    license = lib.licenses.agpl3Plus;
    mainProgram = "dh";
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
})
