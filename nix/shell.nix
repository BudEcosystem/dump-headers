{
  mkShell,
  dh,
  nixfmt-rfc-style,
  gopls,
  markdownlint-cli,
}:

mkShell {
  inputsFrom = [ dh ];

  buildInputs = [
    gopls
    nixfmt-rfc-style
    markdownlint-cli
  ];

  shellHook = ''
    export PS1="\033[0;31m[dh]\033[0m $PS1"
  '';
}
