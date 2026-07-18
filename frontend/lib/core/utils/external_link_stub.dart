/// Non-web fallback for [openExternalUrl]. There is no browser to navigate on
/// the Dart VM (tests) or native targets, so opening an external link is a
/// deliberate no-op — enough to keep the landing page compiling everywhere.
void openExternalUrl(String url) {
  // Intentionally empty: only the web build can hand off to the browser.
}
