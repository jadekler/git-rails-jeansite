projects = Project.create([
        {title: 'Boom Projecto', github_url: 'http://boom.com'},
        {title: 'Yolo swaggins', github_url: 'http://boom.com'},
        {title: 'Boom Amigos', github_url: 'http://boom.com'},
        {title: 'Several Projects', github_url: 'http://boom.com'},
        {title: 'Heyo Projecto', github_url: 'http://boom.com'},
        {title: 'Bam Project', github_url: 'http://boom.com'}
])

blogs = Blog.create([
        {title: 'Wolfram Programming Language', created_at: DateTime.parse('26-02-2014'), content: ""},
        {title: 'Wolfram Programming Language', created_at: DateTime.parse('26-02-2014'), content: ""},
        {title: 'Go Website Skeleton', created_at: DateTime.parse('26-03-2014'), content: "So after working with Go for a while in creating sites, I've noticed a serious lack of community consensus on structure. Most people are borrowing ideas from other frameworks at best. This is pretty hard for beginniners who are used to jumping into a language that has a well established operating style. To help start getting Go there (at least for websites), I've made a skeleton that should serve well for any small-medium sized site.

You can checkout the skeleton [source code here](https://github.com/jadekler/git-go-websiteskeleton).

I went ahead and posted it on Hacker news and Reddit, where I got a lot of (fair) criticism that has helped refine it and make it pretty lean. If you have any ideas for further improvements, I'd really love to hear them! Shoot me an email at [mailto:jadekler@gmail.com](jadekler@gmail.com)."},
        {title: 'Advanced Usage Git Guide', created_at: DateTime.parse('12-03-2014'), content: "Due to popular demand, here are a couple more git tips and tricks. These won't exactly be edge cases, but they should hopefully not be your average day usage. This set of commands, combined with the Quickstart Git Guide, should get you through most problems you face.
#### Revert To Earlier Commit
###### Feels like svn revert

Commands (Note: idea from [this stack overflow response](http://stackoverflow.com/questions/1895059/revert-to-a-commit-by-sha-hash))

```
# Reset the index to the desired SSH
git reset [SSH]

# Move the branch pointer back to the previous HEAD
git reset --soft HEAD@{1}

# Commit the revert
git commit -m 'Reverted to [SSH]'
git push

# Update working copy to reflect new commit
git reset --hard
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset 7c9165064021e62e4c2a3fb925a14bc535240446
Unstaged changes after reset:
D   test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset --soft HEAD@{1}
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446'
[master af7f80a] Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446
 1 file changed, 5 insertions(+)
 create mode 100644 test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset --hard
HEAD is now at af7f80a Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 343 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 2 (delta 0)
To https://github.com/jadekler/git-misc.git
   6afb73c..af7f80a  master -> master
```

#### Git Pull Conflicts

Sometimes when you pull you will get a message like 'Your local changes to the following files would be overwritten by merge. Please, commit your changes or stash them before you can merge.' There are two ways to deal with this: discarding your changes and pulling, stashing your changes and pulling or commiting your changes, fixing conflicts, and pulling. Let's briefly walk through these three options.

###### Git Pull Conflicts - Discard Changes

Commands
```
# Here you see a pull method. You choose to (a) discard your changes
git pull

# This discards all changes you've made
git checkout .

# Now you can cleanly pull
git pull
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   af7f80a..fdd9556  master     -> origin/master
Updating af7f80a..fdd9556
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout .
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
Updating af7f80a..fdd9556
Fast-forward
 test/index.html | 2 --
 1 file changed, 2 deletions(-)
```

###### Git Pull Conflicts - Merge Changes

Commands
```
# Here you see a pull method. You choose to (b) merge your changes
git pull

# Add your changes
git add -A
git commit -m 'Committing local changes'

# Merge your commit with origin
git merge origin

# Edit your conflicted file and remove things like >>>>>>> origin and <<<<<<< HEAD
vim [conflicted file]

# Add your merge fix
git add -A
git commit -m 'Committing merge fixes'
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   b1da90f..5e94678  master     -> origin/master
Updating b1da90f..5e94678
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Preparing to merge changes with origin'
[master f7c3fc7] Preparing to merge changes with origin
 1 file changed, 1 insertion(+), 1 deletion(-)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git merge origin
Auto-merging test/index.html
CONFLICT (content): Merge conflict in test/index.html
Automatic merge failed; fix conflicts and then commit the result.
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ vim test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Merge conflicts resolved'
[master 5eb7336] Merge conflicts resolved
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 11, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (5/5), 527 bytes | 0 bytes/s, done.
Total 5 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   5e94678..5eb7336  master -> master
```

###### Git Pull Conflicts - Stash Changes

Commands
```
# Here you see a pull method. You choose to (c) stash your changes
git pull

# Saves your changes in a stack and resets you to origin
git stash

# Grabbing origin will now work, since your changes are removed (and saved in the stash)
git pull

# Re-apply your saved changes. Any merge conflicts will be dealth with in the same way that merging works (see Merge Changes above)
git pop
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   5eb7336..b3e4850  master     -> origin/master
Updating 5eb7336..b3e4850
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git stash
Saved working directory and index state WIP on master: 5eb7336 Merge conflicts resolved
HEAD is now at 5eb7336 Merge conflicts resolved
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
Updating 5eb7336..b3e4850
Fast-forward
 test/index.html | 2 --
 1 file changed, 2 deletions(-)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git stash pop
Auto-merging test/index.html
CONFLICT (content): Merge conflict in test/index.html
```"},
        {title: 'Quickstart Git Guide', created_at: DateTime.parse('10-03-2014'), content: "This post will serve as a quick, functional guide to jumping into git as well as a refresher for those who've used it before. I will use some examples from SVN as comparison.

#### Git Clone
###### Feels like svn checkout

Commands
`git clone [repo address] [local address]`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs]$ git clone https://github.com/jadekler/git-misc.git
Cloning into 'git-misc'...
remote: Reusing existing pack: 540, done.
remote: Total 540 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (540/540), 13.75 MiB | 4.19 MiB/s, done.
Resolving deltas: 100% (192/192), done.
Checking connectivity... done
```

#### Git Status
###### Feels like svn status

Commands
`git status`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git status
# On branch master
# Untracked files:
#   (use 'git add ...' to include in what will be committed)
#
#   test/
nothing added to commit but untracked files present (use 'git add' to track)
```

#### Git Add, Commit, Push
###### Feels like svn commit

Commands
```
# -A will add all, including removals
git add [filename] OR git add -A

# Store commit on local machine
git commit -m [commit message]

# Send to server
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Added test folder'
[master 3d2a496] Added test folder
 1 file changed, 1 insertion(+)
 create mode 100644 test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 311 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   5f78792..3d2a496  master -> master
```

#### Git Pull
###### Feels like svn update

Commands
`git pull`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   3d2a496..8bfcfea  master     -> origin/master
Updating 3d2a496..8bfcfea
Fast-forward
 test/index.html | 2 ++
 1 file changed, 2 insertions(+)
```

#### Git Branch Create
###### Feels like svn checkout trunk branch

Commands
```
# Create new branch and switch to it
git checkout -b [branch name]

# View your branches
git branch

# Add new branch to repository
git push origin [branch name]
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout -b newbranch
Switched to a new branch 'newbranch'
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git branch
  master
* newbranch
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push origin newbranch
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
 * [new branch]      newbranch -> newbranch
```

#### Git Branch Pushing
###### Feels like svn commit

Commands
```
# Same as before
git add -A
git commit -m [commit message]

# Pushing a branch requires manually specifying the from and to
git push origin [branch name]
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Some minor changes to my file in this branch'
[newbranch 7c91650] Some minor changes to my file in this branch
 1 file changed, 2 insertions(+)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push origin newbranch
Counting objects: 7, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 332 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   8bfcfea..7c91650  newbranch -> newbranch
```

#### Git Merge
###### Feels like svn merge

Commands
```
git checkout master
git merge [branch name]
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout master
Switched to branch 'master'
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git merge newbranch
Updating 8bfcfea..7c91650
Fast-forward
 test/index.html | 2 ++
 1 file changed, 2 insertions(+)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   8bfcfea..7c91650  master -> master
```
"},
        {title: 'Wolfram Programming Language', created_at: DateTime.parse('26-02-2014'), content: "Long time, no post: lots of long, exhausting trips tend to do that. Anyways, enough of me and onto the content of this post - the [(youtube)](http://www.wolfram.com/wolfram-language/](Wolfram Knowledge-Based Programming Language). Here's a pretty good video explaining some of the things you can do with this language: [http://www.youtube.com/watch?v=_P9HqHVPeik).

I don't see this language being revolutionary, to be honest - Mathematica already does many of the things shown in this video. What stands out to me, though, are three things:

1. 'Knowledge-y' functions: for instance, weather data on the fly (e.g., wind speeds correlated to atmospheric pressure), geographical interpolation (e.g., travelling salesman combined with traffic data), social+cultural data (e.g., facebook mapping)
1. Human speech abstraction: e.g., Wolfram knowing what the computational equivalent to something like 'square rotated 40 degree tranposed onto map of Raleigh,NC'. This could be a great introduction to learning programming for kids and other newbies (I say that fondly, to be clear)
1. The ability to create scripts in 'the cloud' (fancy way of saying you can host them on Wolfram's servers and access them through some crazy url). This is pretty neat when you mix it with the aforementioned 'knowledge-y' functions - e.g., creating a weather data API in a couple of minutes, or perhaps an API that you can use to outsource your complex linear algebra computations to

There are certainly some downsides, though. This is not a free product, and it is certainly not open source. This will probably be a paid for product, which combined with the fact that many of the benefits are most useful in a learning or academic environment means that the most use this will see is probably in schools and universities, in the same way that Wolfram Alpha is mostly used by students.

I'd love to give it a try - creating a weather API that I can use d3 to create charts around would be a lot of fun. However, if it is behind even a $10 pay wall I will probably give it a pass. We'll have to wait and see how generous Wolfram feels."},
        {title: 'An Ember.js Widget Tutorial', created_at: DateTime.parse('05-01-2014'), content: "Let's take a look at an easy way to create some pretty cool widgets with Ember.js. See a completed example in the showcase area, found here, and the corresponding code at this github repo.

Our widgets are going to graph some dataset and have a button to switch to a table view. Please note - bootstrap styling was used with this. I'll leave it to you to include it. To get started, let's create a basic widget object, a widget template, and a basic array to hold widgets, and just a little bit of css to style this:

```
# Application Template
<script type='text/x-handlebars'>
    {{#each widget in App.Widgets.items}}
        {{view widget}}
    {{/each}}
</script>

# Widget Template
<script type='text/x-handlebars' data-template-name='widget'>
    <div class='container-fluid widget span5'>
        <div class='row-fluid titlebar'>
            <div class='span4 title'>
                {{view.title}}
            </div>
        </div>
    </div>
</script>

# Application Controller
window.App = Ember.Application.create();

App.ApplicationController = Ember.Controller.extend({
    init: function() {
        var self = this;

        for(var x = 0; x < 5; x++) {
            var tempView = App.Widget.create({
                data: Ember.makeArray([
                    App.DataItem.create({title: 'Group A', content: self.getRandomArr(8)}),
                    App.DataItem.create({title: 'Group B', content: self.getRandomArr(8)}),
                    App.DataItem.create({title: 'Group C', content: self.getRandomArr(8)})
                ]),
            });
            App.Widgets.items.pushObject(tempView);
        }
    },

    getRandomArr: function(size) {
        var randomArr = [];

        for(var x = 0; x < size; x++) {
            randomArr.push(this.getRandomInt(0, 10));
        }

        return randomArr;
    },

    getRandomInt: function(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    },
});

# Data Item
App.DataItem = Ember.Object.extend({
    title: 'default',
    content: null
});

# Widget View
App.Widget = Ember.View.extend({
    templateName: 'widget',
    title: 'Some Widget',
});

# Styling
.table {
  margin: 0;
  font-size: 10px;
}

.widget {
  border: 1px solid #c8c9c7;
  border-radius: 4px;
  padding: 0;
  height: 300px;
  margin: 0 10px 10px 0;
}

.widget .titlebar {
  border-bottom: 1px solid #c8c9c7;
  height: 31px;
}

.widget .titlebar .buttons button {
  height: 30px;
  border-top-left-radius: 0px;
  border-bottom-left-radius: 0px;
  float: right;
  border-left: 1px solid #c8c9c7;
  border-right: none;
  border-top: none;
  border-bottom: none;
  background-color: white;
  box-shadow: none;
  background-image: none;
}

.widget .titlebar .title {
  padding-top: 3px;
  padding-bottom: 3px;
}

.widget .titlebar .title, .widget .titlebar .buttons {
  padding-right: 5px;
  padding-left: 5px;
}
```

So now we have the basics: an iterator that loops over the widgets, and a widget view that has a title. Let's extend it a bit to graph data. To do that we'll have to add a .graphHere div, a function in the widget controller to graph the data, and a graphing package. We'll use highcharts - once again, I'll leave it to you to include it. Modify App.Widget and the widget template as follows.

```
# Widget View
App.Widget = Ember.View.extend({
    templateName: 'widget',
    title: 'Some Widget',
    graphElem: '.graphHere',

    didInsertElement: function() {
        this.graphData();
    },

    graphData: function() {
        var self = this;
        var data = [];
        var graphClass = 'graphArea';

        $(document).ready(function() {
            self.$().find(self.graphElem).append('
');

            $(self.data).each(function(){
                var datum = {name: this.title, data: this.content};
                data.push(datum);
            });

            self.$().find('.'+graphClass).highcharts({
                chart: {
                    height: 250,
                    marginRight: 10
                },
                title: {
                    text: 'Scores',
                    x: -20
                },
                xAxis: {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
                    labels: {
                        rotation: -45
                    }
                },
                yAxis: {
                    title: {
                        text: 'Score'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    borderWidth: 0
                },
                series: data,
                credits: {
                    enabled: false
                }
            });
        });
    }
});

# Widget Template
<script type='text/x-handlebars' data-template-name='widget'>
    <div class='container-fluid widget span5'>
        <div class='row-fluid titlebar'>
            <div class='span4 title'>
                {{view.title}}
            </div>
        </div>
        <div class='graphHere'></div>
    </div>
</script>
```

Now we have a widget that shows graph data. Let's modify just once more to allow us to switch between graphs and tables. To do this, we're going to add to our widget template an if/else to switch between graphing and tables, and we're going to modify our widget view to allow for switching view modes.

```
# Widget View
App.Widget = Ember.View.extend({
    templateName: 'widget',
    title: 'Some Widget',
    graphElem: '.graphHere',
    graphMode: true,

    didInsertElement: function() {
        this.graphData();
    },

    switchMode: function() {
        this.set('graphMode', !this.graphMode);
        if(this.graphMode) {
            this.graphData();
        } else {
            this.$().find(this.graphElem).empty();
        }
    },

    graphData: function() {
        var self = this;
        var data = [];
        var graphClass = 'graphArea';

        $(document).ready(function() {
            self.$().find(self.graphElem).append('
');

            $(self.data).each(function(){
                var datum = {name: this.title, data: this.content};
                data.push(datum);
            });

            self.$().find('.'+graphClass).highcharts({
                chart: {
                    height: 250,
                    marginRight: 10
                },
                title: {
                    text: 'Scores',
                    x: -20
                },
                xAxis: {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
                    labels: {
                        rotation: -45
                    }
                },
                yAxis: {
                    title: {
                        text: 'Score'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    borderWidth: 0
                },
                series: data,
                credits: {
                    enabled: false
                }
            });
        });
    }
});

# Widget Template
<div class='container-fluid widget col-md-4'>
    <div class='row-fluid titlebar'>
        <div class='col-md-4 title'>
            {{view.title}}
        </div>
        <div class='col-md-8 buttons'>
            <button {{action switchMode view}} class='btn'>
                {{#if view.graphMode}}
                    Table mode
                {{else}}
                    Graph mode
                {{/if}}
            </button>
        </div>
    </div>

    <div class='graphHere'></div>
    {{#unless view.graphMode}}
        <table class='content table'>
            <thead>
                <tr>
                    <td>Cost Center</td>
                    <td>Jan</td>
                    <td>Feb</td>
                    <td>Mar</td>
                    <td>Apr</td>
                    <td>May</td>
                    <td>Jun</td>
                    <td>Jul</td>
                    <td>Aug</td>
                </tr>
            </thead>
            <tbody>
                {{#each dataitem in view.data}}
                    <tr>
                        <td>{{dataitem.title}} </td>
                        {{#each value in dataitem.content}}
                            <td>{{value}}</td>
                        {{/each}}
                    </tr>
                {{/each}}
            <tbody>
        </table>
    {{/unless}}
</div>
```

That should just about do it! A basic Ember.js widget.
"},
        {title: 'Happy New Year!', created_at: DateTime.parse('01-01-2014'), content: "Happy new year's everyone! Let's spend the year building awesome things, being good to each other, and trying not to screw anything up."},
        {title: 'Setting Up A Golang Website On AWS', created_at: DateTime.parse('29-12-2013'), content: "It should come as no surprise that the first post will talk about how this website is written, and how you can do the same. Keep in mind that this post is being written in the present - future iterations of the site may look different, but this is a solid place to start. Also, for this post I will provide only a summary - not a full explanation. So to start, let's briefly take a look at the tools we'll be using to get this up on its feet:
- [AWS EC2](http://aws.amazon.com/): Our VM that acts as our server
- [Name.com](http://localhost:8080/blog/posts/name.com): The domain registrar for jeandeklerk.com
- [Golang](http://golang.org/): The server-side programming language we'll be using. We'll also be using the built in http server and templating systems
- [Sass](http://sass-lang.com/): The pre-compilation we'll be using for our css
- [Twitter Bootstrap](http://getbootstrap.com/): Some sexy pre-built CSS and JS
- [Font-Awesome](http://fontawesome.io/): For awesome fonts, as the name implies
- [jQuery](http://jquery.com/): For javascript goodness

I'll try and keep this brief and ordered. Here are the steps to walk through:

1. Install Git: [https://help.github.com/articles/set-up-git](https://help.github.com/articles/set-up-git)
1. Install Go: [http://golang.org/doc/install](http://golang.org/doc/install)
    1. Either step through the Golang ['Writing Web Applications'](http://golang.org/doc/articles/wiki/) tutorial
    1. Or grab my completed code at [this Github Repo](https://github.com/jadekler/git-go-jeansite/tree/0de39c59b638c8ba74885d5d7126d968253204aa)
1. Fire up your server! `go build main.go ./main http://localhost:8080`
Again, for the sake of brevity I'm skipping a lot. If you're here and the above hasn't worked for you I suggest stepping through the aforementioned tutorial. It has all you need to get off the ground.
1. So you have a server but you don't have anywhere to put it. This is where AWS EC2 comes in. Once again, here is a very helpful guide: [Getting Started with Amazon EC2 Linux Instances](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html). Walk through steps 1-4 to get an instance running,
1. Install Golang and Git on your EC2 instance as before and pull your repo down to your server.
1. Now you have an AWS EC2 instance with running (go) server code, but we still need to be able to access it. This instance has a Dynamic IP - it changes periodically. Not useful to use. We need to assign a static IP. Under the left panel of the EC2 console you should see a link called 'Elastic IPs'. Click this and allocate a new address to your EC2 instance.
1. Now we have an EC2 instance with server code running and a static IP pointing to it. Great! Last step, which is entirely optional: go to [more-detailed guide for this process](http://localhost:8080/blog/posts/name.com](name.com) and register a domain name (it may cost $5+ for a year or so). Once that's done, create a CNAME record that points to your static IP. [Here is yet another](http://www.name.com/blog/general/development/2012/01/so-you-want-free-web-hosting-an-amazon-ec2-how-to/).).
"},
        {title: 'Hello World', created_at: DateTime.parse('28-12-2013'), content: 'This blog was built to learn Go but also to post things that I pick up along the way. I believe strongly that programmers as a whole benefit from a community of giving, not just one of taking.

Therefore, I hope that you - the reader - finds something here of worth. And if nothing else, go fork my repo for this site (https://github.com/jadekler/git-go-jeansite) and start your own blog!'}
])
