{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # Adjust device path accordingly (using uuid for safety)
        device = "/dev/disk/by-uuid/ad115b46-8ee3-4119-bf43-4cc0f0053605";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              type = "8300"; # Linux filesystem
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@persistent" = {
                    mountpoint = "/persistent";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "ssd"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "ssd"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "ssd"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "noatime"
                      "compress-force=zstd:1"
                      "ssd"
                      "discard=async"
                      "space_cache=v2"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  # Volatile root as tmpfs
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=256M" "mode=755" ];
  };
}
