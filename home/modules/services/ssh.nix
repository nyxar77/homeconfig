{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
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
    settings."github.com" = {
      Hostname = "github.com";
      User = "git";
      IdentityFile = "~/.ssh/github";
      IdentitiesOnly = true;
      AddKeysToAgent = true;
    };
  };
}
