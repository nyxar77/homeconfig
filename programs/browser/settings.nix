{
  "content.notify.interval" = 100000;

  /**
  GFX **
  */
  "gfx.canvas.accelerated.cache-items" = 4096;
  "gfx.canvas.accelerated.cache-size" = 512;
  "gfx.content.skia-font-cache-size" = 20;

  /**
  DISK CACHE **
  */
  "browser.cache.disk.enable" = true;

  /**
  MEDIA CACHE **
  */
  "media.memory_cache_max_size" = 65536;
  "media.cache_readahead_limit" = 7200;
  "media.cache_resume_threshold" = 3600;
  "media.ffmpeg.vaapi.enabled" = true;

  /**
  IMAGE CACHE **
  */
  "image.mem.decode_bytes_at_a_time" = 32768;

  /**
  NETWORK **
  */
  #"network.http.max-connections"= 1800;
  #"network.http.max-persistent-connections-per-server"= 10 ;
  "network.http.max-urgent-start-excessive-connections-per-host" = 5;
  "network.http.pacing.requests.enabled" = false;
  "network.dnsCacheExpiration" = 3600;
  "network.ssl_tokens_cache_capacity" = 10240;

  /**
  SPECULATIVE LOADING **
  */
  "network.dns.disablePrefetch" = true;
  "network.dns.disablePrefetchFromHTTPS" = true;
  "network.prefetch-next" = true;
  "network.predictor.enabled" = true;
  "network.predictor.enable-prefetch" = true;

  /**
  EXPERIMENTAL **
  */
  "layout.css.grid-template-masonry-value.enabled" = true;
  "dom.enable_web_task_scheduling" = true;

  /**
   **************************************************************************
  * SECTION: SECUREFOX                                                       *
  ***************************************************************************
  */
  /**
  TRACKING PROTECTION **
  */
  "browser.contentblocking.category" = "custom";

  "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";

  "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
  "browser.download.start_downloads_in_tmp_dir" = true;
  "browser.helperApps.deleteTempFileOnExit" = true;
  "browser.uitour.enabled" = false;
  "privacy.globalprivacycontrol.enabled" = true;

  /**
  OCSP & CERTS / HPKP **
  */
  "security.OCSP.enabled" = 1;
  "security.remote_settings.crlite_filters.enabled" = true;
  "security.pki.crlite_mode" = 2;

  /**
  SSL / TLS **
  */
  "security.ssl.treat_unsafe_negotiation_as_broken" = true;
  "browser.xul.error_pages.expert_bad_cert" = true;
  "security.tls.enable_0rtt_data" = false;

  "browser.privatebrowsing.forceMediaMemoryCache" = true;
  "browser.sessionstore.interval" = 60000;

  "browser.privatebrowsing.resetPBM.enabled" = true;
  "privacy.history.custom" = true;

  "browser.urlbar.trimHttps" = true;
  "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
  "browser.search.separatePrivateDefault.ui.enabled" = true;
  "browser.urlbar.update2.engineAliasRefresh" = true;
  "browser.search.suggest.enabled" = false;
  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.groupLabels.enabled" = false;
  "browser.formfill.enable" = false;
  "security.insecure_connection_text.enabled" = true;
  "security.insecure_connection_text.pbmode.enabled" = true;
  "network.IDN_show_punycode" = true;
  "dom.security.https_first" = true;
  "signon.formlessCapture.enabled" = false;
  "signon.privateBrowsingCapture.enabled" = false;
  "network.auth.subresource-http-auth-allow" = 1;
  "editor.truncate_user_pastes" = false;
  "security.mixed_content.block_display_content" = true;
  "pdfjs.enableScripting" = false;
  "extensions.enabledScopes" = 5;
  "network.http.referer.XOriginTrimmingPolicy" = 2;
  "privacy.userContext.ui.enabled" = true;

  "browser.safebrowsing.downloads.remote.enabled" = true;

  "permissions.default.desktop-notification" = 2;
  "permissions.default.geo" = 2;
  "browser.search.update" = false;
  "permissions.manager.defaultsUrl" = "";

  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.uploadEnabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.coverage.opt-out" = true;
  "toolkit.coverage.opt-out" = true;
  "toolkit.coverage.endpoint.base" = "";
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;

  "app.shield.optoutstudies.enabled" = false;
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";

  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;

  "captivedetect.canonicalURL" = "";
  "network.captive-portal-service.enabled" = false;
  "network.connectivity-service.enabled" = false;

  "browser.privatebrowsing.vpnpromourl" = "";
  "extensions.getAddons.showPane" = false;
  "extensions.htmlaboutaddons.recommendations.enabled" = false;
  "browser.discovery.enabled" = false;
  "browser.shell.checkDefaultBrowser" = false;

  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
  "browser.preferences.moreFromMozilla" = false;
  "browser.aboutConfig.showWarning" = false;
  "browser.aboutwelcome.enabled" = false;
  "browser.profiles.enabled" = true;

  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "browser.compactmode.show" = true;
  "browser.privateWindowSeparation.enabled" = false;

  "cookiebanners.service.mode" = 1;
  "cookiebanners.service.mode.privateBrowsing" = 1;

  "full-screen-api.transition-duration.enter" = "0 0";
  "full-screen-api.transition-duration.leave" = "0 0";
  "full-screen-api.warning.timeout" = 0;

  "browser.urlbar.suggest.calculator" = true;
  "browser.urlbar.unitConversion.enabled" = true;
  "browser.urlbar.trending.featureGate" = false;

  #("browser.newtabpage.activity-stream.feeds.topsites", false);
  #("browser.newtabpage.activity-stream.showWeather", false);
  #("browser.newtabpage.activity-stream.feeds.section.topstories", false);

  "browser.download.manager.addToRecentDocs" = false;
  "browser.download.open_pdf_attachments_inline" = true;
  "browser.bookmarks.openInTabClosesMenu" = false;
  "browser.menu.showViewImageInfo" = true;
  "findbar.highlightAll" = true;
  "layout.word_select.eat_space_to_next_word" = false;
  "privacy.userContext.enabled" = true;
  "browser.newtabpage.activity-stream.showWeather" = true;
  "browser.newtabpage.activity-stream.feeds.section.topstories" = true;
  "browser.newtabpage.activity-stream.feeds.topsites" = true;
  "browser.newtabpage.activity-stream.showSearch" = true;
  "browser.newtabpage.activity-stream.default.sites" = "";
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  "privacy.resistFingerprinting" = false;
  "privacy.fingerprintingProtection" = true;
  "privacy.resistFingerprinting.pbmode" = true;
  "privacy.trackingprotection.enabled" = true;
  "privacy.trackingprotection.pbmode.enabled" = true;
  "privacy.trackingprotection.fingerprinting.enabled" = true;
  "network.cookie.cookieBehavior" = 1;
  "privacy.partition.network_state" = true;
  "network.trr.mode" = 3;
  "dom.security.https_only_mode" = true;
  "network.http.speculative-parallel-limit" = 0;
  "webgl.disabled" = true;
  "geo.enabled" = false;
  "network.http.sendRefererHeader" = 2;
  "security.ssl.require_safe_negotiation" = true;
}
