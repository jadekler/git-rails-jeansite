@blogs.push(Blog.create({title: 'An Ember.js Widget Tutorial', created_at: DateTime.parse('05-01-2014'), content: "Let's take a look at an easy way to create some pretty cool widgets with Ember.js. See a completed example in the showcase area, found here, and the corresponding code at this github repo.

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
"}))