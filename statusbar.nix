{pkgs, ...}: let
  myScript =
    pkgs.writeShellScriptBin "statusbar" ''
    '';
in {
  myScript = myScript;
}
