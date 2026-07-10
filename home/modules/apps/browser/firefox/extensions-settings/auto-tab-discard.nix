{
  idle = false;
  "idle-timeout" = 300;
  period = 2400;
  number = 5;
  "max.single.discard" = 50;
  "trash.period" = 24;
  "trash.unloaded" = false;
  mode = "time-based";
  click = "click.popup";

  audio = true;
  paused = false;
  pinned = false;
  form = true;
  battery = false;
  online = false;

  "notification.permission" = false;
  "page.context" = false;
  "tab.context" = true;
  "link.context" = true;
  log = false;
  faqs = true;
  favicon = true;
  prepends = "💤";
  "go-hidden" = false;

  "simultaneous-jobs" = 10;
  "favicon-delay" = 500;

  whitelist = [];
  "whitelist-url" = [];
  "force.hostnames" = [];
  "trash.whitelist-url" = [];

  "memory-enabled" = false;
  "memory-value" = 60;

  "startup-unpinned" = false;
  "startup-pinned" = false;
  "startup-release-pinned" = false;

  "./plugins/dummy/core.js" = false;
  "./plugins/blank/core.js" = true;
  "./plugins/focus/core.js" = false;
  "./plugins/trash/core.js" = true;
  "./plugins/force/core.js" = true;
  "./plugins/next/core.js" = false;
  "./plugins/previous/core.js" = false;
  "./plugins/new/core.js" = false;
  "./plugins/unloaded/core.js" = false;
  "./plugins/youtube/core.js" = true;
}
