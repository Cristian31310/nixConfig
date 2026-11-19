{
  config,
  pkgs,
  inputs,
  ...
}:{

  security.pam.loginLimits = [
    {
      domain = "yourusername";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];
  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        action.id == "org.freedesktop.login1.reboot" ||
        action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
        action.id == "org.freedesktop.login1.power-off" ||
        action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||

        action.id == "org.freedesktop.udisks2.filesystem-mount" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount-other-seat"

      ) {
        // Allow users in the 'wheel' group to shutdown/reboot without password
        if (subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      }
      });
  '';
}
