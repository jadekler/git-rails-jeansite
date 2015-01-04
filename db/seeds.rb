projects = Project.create([
        {title: 'Web Attributes Demo', github_url: 'https://github.com/jadekler/git-web-attrdemo'},
        {title: 'Require.js Demo', github_url: 'https://github.com/jadekler/git-web-requiredemo'},
        {title: 'Page Change Checking App', github_url: 'https://github.com/jadekler/git-web-dataformatter'},
        {title: 'Ember.js Treetable', github_url: 'https://github.com/jadekler/git-ember-treetable'},
        {title: 'Ember.js Treetable with Zend', github_url: 'https://github.com/jadekler/git-zend-ember-jeansite'},
        {title: 'jQuery Treetable', github_url: 'https://github.com/jadekler/git-jquery-treetable'},
        {title: 'Ember.js Widget Demo', github_url: 'https://github.com/jadekler/git-ember-widgetdemo'},
        {title: 'Ember.js Todo Demo', github_url: 'https://github.com/jadekler/git-ember-todo'},
        {title: 'Solarized Theme for Chrome Devtools', github_url: 'https://github.com/jadekler/git-solarized-chrome-devtools'},
        {title: 'Swift Todo Tutorial', github_url: 'https://github.com/jadekler/git-swift-todo-tutorial'},
        {title: 'HRT-SQL Lexer in Go', github_url: 'https://github.com/jadekler/git-go-logictree'},
        {title: 'Grunt Go Runner', github_url: 'https://github.com/jadekler/git-grunt-gorun'},
        {title: 'Grunt Go Stopper', github_url: 'https://github.com/jadekler/git-grunt-gostop'},
        {title: 'Grunt Go Builder', github_url: 'https://github.com/jadekler/git-grunt-gobuild'},
        {title: 'Go Website Skeleton', github_url: 'https://github.com/jadekler/git-go-websiteskeleton'}
].reverse)

@blogs = []

Dir[File.dirname(__FILE__) + '/blogs/*.rb'].each do |file|
    require file
end

blogs = @blogs
