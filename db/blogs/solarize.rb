@blogs.push(Blog.create({title: 'Solarize Your Dev Tools Console', created_at: DateTime.parse('15-09-2014'), content: "Lately, the Denver Pivotal Labs office has undergone a Solarized Theme surge - all of our IDEs and terminals have all been swept by the light, eye-calming tan wave. A colleague and I decided to take it a step further while a couple of rather long tests were running. Here you have it: how to solarize your chrome developer tools! Note: you can also see this at my GitHub.

1. git clone https://github.com/jadekler/solarized-chrome-devtools.git to some location
1. Open chrome, and navigate to chrome://flags/
1. Search for 'Enable Developer Tools experiments', and click 'Enable'
1. Restart chrome
1. Go to developer settings (CMD+ALT+I on Mac)
1. Click the settings icon (a small cog)
1. Click 'experiments', and then enable 'Allow Custom UI Themes'
1. Navigate to chrome://extensions/
1. Click 'Developer Mode' at the top right
1. Click 'Load unpackaged extensions' and select the folder your cloned in step 1
1. Open dev tools again - no reload needed - and your changes should be there!

![](/images/solarized.png)
"}))