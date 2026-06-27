{
  config,
  pkgs,
  ...
}: {
  programs.htop = {
    enable = true;
    settings =
      {
        color_scheme = 5;
        cpu_count_from_one = 1;
        delay = 15;
        fields = with config.lib.htop.fields; [
          PID
          USER
          PRIORITY
          NICE
          M_VIRT
          M_RESIDENT
          M_SHARE
          STATE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];

        # NixOS path fix
        show_program_path = 0;
        highlight_base_name = 1;
        show_merged_command = 1;
        strip_exe_from_cmdline = 1;
        find_comm_in_cmdline = 1;

        # Visuals
        highlight_megabytes = 1;
        highlight_threads = 1;
        highlight_changes = 1;
        highlight_changes_delay_secs = 3;

        # Behavior
        sort_key = 46;
        sort_direction = -1;
        tree_view = 1;
        tree_sort_key = 1;
        tree_sort_direction = 1;
        hide_kernel_threads = 1;
        hide_userland_threads = 1;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
        degree_fahrenheit = 0;
        detailed_cpu_time = 0;
        header_margin = 1;
        enable_mouse = 1;
      }
      // (with config.lib.htop;
        leftMeters [
          (text "Hostname")
          (text "Uptime")
          (text "Battery")
          (bar "AllCPUs2")
          (bar "CPU")
          (text "CPU")
        ])
      // (with config.lib.htop;
        rightMeters [
          (text "Systemd")
          (text "LoadAverage")
          (text "Tasks")
          (bar "DiskIO")
          (bar "NetworkIO")
          (bar "Memory")
          (bar "Swap")
        ]);
  };
}
