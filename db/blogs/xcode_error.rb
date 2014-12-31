@blogs.push(Blog.create({title: 'xCode Mach Error 1102', created_at: DateTime.parse('08-07-2014'), content: "So I started playing with Swift recently. I've never had much inclination to build iOS apps due to the closed platform, but I figured I'd give it a shot. Immediately I hit an error that took me a week to fix: Mach Error 1102 - Unknown Error Code. Before I start, please note that these are simply the steps I took to get there - the error sort of just disappeared overnight in the middle of my trying to fix it. Lastly, please note that this was a fresh install of xCode 6 (as in, I installed 6 without 5 before it) so it may have been a case of initialized caches or something. Anyways, this is how I went about fixing it.

1. Reset iOS Simulator Content + Settings
    1. Open the iOS simulator at `/wherever-xcode-is-installed/Contents/Applications/iOS Simualtor`
    1. Click iOS Simulator at the top left
    1. Click Reset Content and Settings (this didn't work for you, but it has for others, so give it a quick shot)
1. Ensure that xCode is under `/Applications`
1. Give it the 'ol Uninstall-Reinstall
1. Download the latest Components
    1. In xCode, go to Preferences
    1. Click Downloads
    1. Download everything under Components. I was missing 'iOS 7.1 Simulator' and 'iOS 7.0 Simulator'
1. Download a previously-built app and see if it runs
    1. Head over to this excellent tutorial app
    1. At the bottom of the page is a link to download the app
    1. Run it - does it work? Woohoo! Now try and run your own blank app - does that work too? It did for me - I assume I was missing some cache or common stuff that should have been built before but due to my fresh install was missing.

None of these steps work for you? Sorry! As mentioned, I have no clue what in that fiddling did it, but it was resolved the night after importing that tutorial app and running it once. Another solution you might try is installing xCode 5 and seeing if you can get an app running there. I was getting the same error in xCode 5 myself, which gives further weight to my idea that some files or folders needed to be initialized.

Best of luck!
"}))