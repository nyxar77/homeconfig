{ config, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = true;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = true;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
      "github.com" = {
        Hostname = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github";
        IdentitiesOnly = true;
        AddKeysToAgent = true;
      };
      "gitlab.com" = {
        Hostname = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/github";
        IdentitiesOnly = true;
        AddKeysToAgent = true;
      };
    }
    // lib.optionalAttrs (config.home.username == "nyxar") {
      serverless = {
        Hostname = "serverless";
        User = "baryon";
        IdentityFile = "~/.ssh/serverless";
        IdentitiesOnly = true;
        AddKeysToAgent = true;
      };
    };
  };
}
