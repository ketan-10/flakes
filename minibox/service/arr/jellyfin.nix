{
  config,
  lib,
  ...
}:
{
  options.media_server.jellyfin = {
    enable = lib.mkEnableOption "Enable jellyfin deployment configuration";
  };

  config =
    let
      cfg = config.media_server.jellyfin;
    in
    lib.mkIf cfg.enable {
      services.jellyfin.enable = true;

    #   nixpkgs.config.packageOverrides = pkgs: {
    #     intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    #   };

    };
}
