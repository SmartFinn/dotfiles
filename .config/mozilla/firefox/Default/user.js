/* user.js
 *
 */

/* Disable about:config warning */
user_pref("general.warnOnAboutConfig", false);

/* STARTUP
 */

/* Bookmarks */
user_pref("browser.bookmarks.max_backups", 0); // No bookmarks backup
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.bookmarks.showMobileBookmarks", true);

/* Download button */
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.panel.shown", true);

/* Customize a new tab */
user_pref("browser.library.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.feeds.places", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
user_pref("browser.newtabpage.activity-stream.topSitesRows", 3);
user_pref("browser.newtabpage.enhanced", true);

/* Disable telemetry */
user_pref("browser.ping-centre.telemetry", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.firstRunURL", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");

/* Disable other recommendations */
user_pref("extensions.getAddons.showPane", false); /* [HIDDEN PREF] */
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shopping.experience2023.enabled", false);

/* Disable Studies */
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/* Disable sending reports of tab crashes to Mozilla (about:tabcrashed),
don't nag user about unsent crash reports
https://hg.mozilla.org/mozilla-central/file/tip/browser/app/profile/firefox.js */
user_pref("browser.tabs.crashReporting.sendReport",		false);
user_pref("browser.crashReports.unsubmittedCheck.enabled",	false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

/* Tabs settings */
user_pref("browser.tabs.tabMinWidth", 30);
user_pref("browser.tabs.warnOnClose", false);

/* URL bar settings */
user_pref("browser.urlbar.maxRichResults", 6);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.groupLabels.enabled", false);

/* Disable some suggestions in URL bar */
user_pref("browser.urlbar.mdn.featureGate", false);
user_pref("browser.urlbar.pocket.featureGate", false);
user_pref("browser.urlbar.weather.featureGate", false);
user_pref("browser.urlbar.yelp.featureGate", false);

/* DevTools settings */
user_pref("devtools.aboutdebugging.showSystemAddons", true);
user_pref("devtools.onboarding.telemetry.logged", false);
user_pref("devtools.theme", "dark");
user_pref("devtools.toolbox.splitconsoleEnabled", false);

/* Disable permission asking */
user_pref("dom.push.enabled", false);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);

/* Disable Graphite because of unsafe */
user_pref("gfx.font_rendering.graphite.enabled", false);

/* Disable media cache from writing to disk in Private Browsing */
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);

/* Video settings */
user_pref("media.autoplay.enabled", false);
user_pref("media.av1.enabled", false);

/* Network tweaks */
// user_pref("network.dns.disablePrefetch", true);
// user_pref("network.dns.disablePrefetchFromHTTPS", true);
// user_pref("network.http.speculative-parallel-limit", 0);
// user_pref("network.predictor.enabled", false);
// user_pref("network.predictor.enable-prefetch", false);
// user_pref("network.prefetch-next", false);
// user_pref("network.trr.mode", 3);
// user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.dns.disableIPv6", true);

/* Disable menu popping up when pressed Alt key */
user_pref("ui.key.menuAccessKeyFocuses", false);

/* Enable highlighting when searching on page */
user_pref("findbar.modalHighlight", true);

/* Disable add-ons recommendations */
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

/* Hardware Video Acceleration */
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.av1.enabled", false); // Disable AV1 codec

/* Keep Firefox open when you close the last tab */
/* user_pref("browser.tabs.closeWindowWithLastTab", false); */

/* Papirus icons
 * https://github.com/PapirusDevelopmentTeam/firefox-papirus-icon-theme
 */

/* Enable customChrome.css */
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

/* Set UI density to compact */
user_pref("browser.compactmode.show", true);

/* Enable SVG context-propertes */
user_pref("svg.context-properties.content.enabled", true);

// Disable private window dark theme
user_pref("browser.theme.dark-private-windows", false);

/* Deny to respect disablePictureInPicture option */
user_pref("media.videocontrols.picture-in-picture.respect-disablePictureInPicture", false);
