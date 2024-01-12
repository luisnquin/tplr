{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.tplr;
in {
  options = {
    programs.tplr = {
      enable = mkEnableOption "tplr";

      templates = mkOption {
        type = types.attrs;
        default = {};
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.callPackage ../../tplr {})
    ];

    xdg.configFile = {
      "tplr/tree.json".source = (pkgs.formats.json {}).generate "tplr-tree" cfg.templates;
    };
  };
}
