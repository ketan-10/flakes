{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.media_server.qbittorrent = {
    enable = lib.mkEnableOption "Enable qbittorrent-nox service configuration";

    uiPort = lib.mkOption {
      description = "Web UI Port for qbittorrent-nox";
      type = lib.types.port;
      default = 8069;
    };

    torrentPort = lib.mkOption {
      description = "Torrenting port";
      type = with lib.types; nullOr port;
      default = 64211;
    };
  };

  config =
    let
      cfg = config.media_server.qbittorrent;
    in
    lib.mkIf cfg.enable {

        systemd.services.qbittorrent-nox = {
            description = "qBittorrent-nox service";
            wants = [ "network-online.target" ];
            after = [
                "local-fs.target"
                "network-online.target"
                "nss-lookup.target"
            ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                StateDirectory = "qbittorrent-nox";
                WorkingDirectory = "/var/lib/qbittorrent-nox";
                ExecStart = ''
                    ${pkgs.qbittorrent-nox}/bin/qbittorrent-nox ${
                        lib.optionalString (cfg.torrentPort != null) "--torrenting-port=${toString cfg.torrentPort}"
                    } \
                        --webui-port=${toString cfg.uiPort} --profile=/var/lib/qbittorrent-nox
                '';
            };
        };
    };
}
