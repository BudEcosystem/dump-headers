{
  mkShell,
  infra-debug-tools,
  nixfmt-rfc-style,
  gopls,
  markdownlint-cli,
  apacheHttpd, # ab - Apache HTTP server benchmarking tool
}:

mkShell {
  inputsFrom = [ infra-debug-tools ];

  buildInputs = [
    gopls
    nixfmt-rfc-style
    markdownlint-cli
    apacheHttpd
  ];

  shellHook = ''
    export PS1="\033[0;31m[infra-debug-tools]\033[0m $PS1"
  '';
}
