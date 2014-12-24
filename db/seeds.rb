projects = Project.create([
        {title: 'Boom Projecto', github_url: 'http://boom.com'},
        {title: 'Yolo swaggins', github_url: 'http://boom.com'},
        {title: 'Boom Amigos', github_url: 'http://boom.com'},
        {title: 'Several Projects', github_url: 'http://boom.com'},
        {title: 'Heyo Projecto', github_url: 'http://boom.com'},
        {title: 'Bam Project', github_url: 'http://boom.com'}
])

blogs = Blog.create([
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
- [http://localhost:8080/blog/posts/name.com](Name.com): The domain registrar for jeandeklerk.com
- [http://golang.org/](Golang): The server-side programming language we'll be using. We'll also be using the built in http server and templating systems
- [http://sass-lang.com/](Sass): The pre-compilation we'll be using for our css
- [http://getbootstrap.com/](Twitter Bootstrap): Some sexy pre-built CSS and JS
- [http://fontawesome.io/](Font-Awesome): For awesome fonts, as the name implies
- [http://jquery.com/](jQuery): For javascript goodness

I'll try and keep this brief and ordered. Here are the steps to walk through:

1. Install Git: [https://help.github.com/articles/set-up-git](https://help.github.com/articles/set-up-git)
1. Install Go: [http://golang.org/doc/install](http://golang.org/doc/install)
    1. Either step through the Golang [http://golang.org/doc/articles/wiki/]('Writing Web Applications') tutorial
    1. Or grab my completed code at [https://github.com/jadekler/git-go-jeansite/tree/0de39c59b638c8ba74885d5d7126d968253204aa](this Github Repo)
1. Fire up your server! `go build main.go ./main http://localhost:8080`
Again, for the sake of brevity I'm skipping a lot. If you're here and the above hasn't worked for you I suggest stepping through the aforementioned tutorial. It has all you need to get off the ground.
1. So you have a server but you don't have anywhere to put it. This is where AWS EC2 comes in. Once again, here is a very helpful guide: [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html](Getting Started with Amazon EC2 Linux Instances). Walk through steps 1-4 to get an instance running,
1. Install Golang and Git on your EC2 instance as before and pull your repo down to your server.
1. Now you have an AWS EC2 instance with running (go) server code, but we still need to be able to access it. This instance has a Dynamic IP - it changes periodically. Not useful to use. We need to assign a static IP. Under the left panel of the EC2 console you should see a link called 'Elastic IPs'. Click this and allocate a new address to your EC2 instance.
1. Now we have an EC2 instance with server code running and a static IP pointing to it. Great! Last step, which is entirely optional: go to [http://localhost:8080/blog/posts/name.com](name.com) and register a domain name (it may cost $5+ for a year or so). Once that's done, create a CNAME record that points to your static IP. Here is yet another, [http://www.name.com/blog/general/development/2012/01/so-you-want-free-web-hosting-an-amazon-ec2-how-to/](more-detailed guide for this process).
"},
        {title: 'Hello World', created_at: DateTime.parse('28-12-2013'), content: 'This blog was built to learn Go but also to post things that I pick up along the way. I believe strongly that programmers as a whole benefit from a community of giving, not just one of taking.

Therefore, I hope that you - the reader - finds something here of worth. And if nothing else, go fork my repo for this site (https://github.com/jadekler/git-go-jeansite) and start your own blog!'}
])
