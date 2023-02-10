/* user.js
 *
 */

/* Disable warning */
user_pref("general.warnOnAboutConfig", false);

/* Bookmarks */
user_pref("browser.bookmarks.max_backups", 0); // No bookmarks backup
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.bookmarks.showMobileBookmarks", true);

/* Disable preview */
user_pref("browser.ctrlTab.previews", false);

/* Download button */
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.panel.shown", true);

/* Customize a new tab */
user_pref("browser.library.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.places", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.filterAdult", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
user_pref("browser.newtabpage.activity-stream.tippyTop.service.endpoint", "");
user_pref("browser.newtabpage.activity-stream.topSitesRows", 3);
user_pref("browser.newtabpage.enhanced", true);

/* Disable telemetry */
user_pref("browser.ping-centre.telemetry", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.firstRunURL", "");
user_pref("security.ssl.errorReporting.automatic", true);
user_pref("toolkit.identity.enabled", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.infoURL", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

/* Disable sending reports of tab crashes to Mozilla (about:tabcrashed),
don't nag user about unsent crash reports
https://hg.mozilla.org/mozilla-central/file/tip/browser/app/profile/firefox.js */
user_pref("browser.tabs.crashReporting.sendReport",		false);
user_pref("browser.crashReports.unsubmittedCheck.enabled",	false);

/* Tabs settings */
user_pref("browser.tabs.tabMinWidth", 30);
user_pref("browser.tabs.warnOnClose", false);

/* URL bar settings */
user_pref("browser.urlbar.maxRichResults", 6);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false)
user_pref("browser.urlbar.groupLabels.enabled", false)

/* DevTools settings */
user_pref("devtools.aboutdebugging.showSystemAddons", true);
user_pref("devtools.onboarding.telemetry.logged", false);
user_pref("devtools.theme", "dark");
user_pref("devtools.toolbox.splitconsoleEnabled", false);

/* Disable permission asking */
user_pref("dom.push.enabled", false);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);

/* Smooth scrolling */
/*
user_pref("general.smoothScroll.currentVelocityWeighting", "0");
user_pref("general.smoothScroll.durationToIntervalRatio", 1000);
user_pref("general.smoothScroll.lines.durationMaxMS", 150);
user_pref("general.smoothScroll.lines.durationMinMS", 0);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 150);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 0);
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 250);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 450);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 450);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 50);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 5000);
user_pref("general.smoothScroll.other", true);
user_pref("general.smoothScroll.other.durationMaxMS", 150);
user_pref("general.smoothScroll.other.durationMinMS", 0);
user_pref("general.smoothScroll.pages.durationMaxMS", 150);
user_pref("general.smoothScroll.pages.durationMinMS", 0);
user_pref("general.smoothScroll.pixels", true);
user_pref("general.smoothScroll.pixels.durationMaxMS", 150);
user_pref("general.smoothScroll.pixels.durationMinMS", 0);
user_pref("general.smoothScroll.scrollbars.durationMaxMS", 600);
user_pref("general.smoothScroll.scrollbars.durationMinMS", 0);
user_pref("general.smoothScroll.stopDecelerationWeighting", "0.2");
*/

/* Acceleration */
user_pref("gfx.use_text_smoothing_setting", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.highlight-painted-layers", false);
user_pref("gfx.x11-egl.force-enabled", true);
user_pref("layers.acceleration.force-enabled", true);

/* Video settings */
user_pref("media.autoplay.enabled", false);
user_pref("media.av1.enabled", false);

/* Network tweaks */
// user_pref("network.allow-experiments", false);
// user_pref("network.cookie.prefsMigrated", true);
// user_pref("network.dns.disablePrefetch", true);
// user_pref("network.dns.echconfig.enabled", true);
// user_pref("network.http.speculative-parallel-limit", 0);
// user_pref("network.predictor.enabled", false);
// user_pref("network.prefetch-next", false);
// user_pref("network.tcp.tcp_fastopen_enable", true);
// user_pref("network.trr.mode", 2);
// user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.warnOnAboutNetworking", false);

/* Disable menu popping up when pressed Alt key */
user_pref("ui.key.menuAccessKeyFocuses", false);

/* Enable highlighting when searching on page */
user_pref("findbar.modalHighlight", true);

/* Disable add-ons recommendations */
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

/* Hardware Video Acceleration */
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffvpx.enabled", false); // disables software decoding of VP8/VP9
user_pref("media.av1.enabled", false); // Disable AV1 codec

/* Papirus icons
 * https://github.com/PapirusDevelopmentTeam/firefox-papirus-icon-theme
 */

// Enable customChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Set UI density to compact
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);

// Enable SVG context-propertes
user_pref("svg.context-properties.content.enabled", true);
