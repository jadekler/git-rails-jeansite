projects = Project.create([
        {title: 'Boom Projecto', github_url: 'http://boom.com'},
        {title: 'Yolo swaggins', github_url: 'http://boom.com'},
        {title: 'Boom Amigos', github_url: 'http://boom.com'},
        {title: 'Several Projects', github_url: 'http://boom.com'},
        {title: 'Heyo Projecto', github_url: 'http://boom.com'},
        {title: 'Bam Project', github_url: 'http://boom.com'}
])

blogs = Blog.create([
        {title: 'Setting Up A Golang Website On AWS', created_at: DateTime.parse('29-12-2013'), content: "It should come as no surprise that the first post will talk about how this website is written, and how you can do the same. Keep in mind that this post is being written in the present - future iterations of the site may look different, but this is a solid place to start. Also, for this post I will provide only a summary - not a full explanation. So to start, let's briefly take a look at the tools we'll be using to get this up on its feet:
- AWS EC2: Our VM that acts as our server
- Name.com: The domain registrar for jeandeklerk.com
- Golang: The server-side programming language we'll be using. We'll also be using the built in http server and templating systems
- Sass: The pre-compilation we'll be using for our css
- Twitter Bootstrap: Some sexy pre-built CSS and JS
- Font-Awesome: For awesome fonts, as the name implies
- jQuery: For javascript goodness
I'll try and keep this brief and ordered. Here are the steps to walk through:
Install Git: https://help.github.com/articles/set-up-git
Install Go: http://golang.org/doc/install
Either step through the Golang 'Writing Web Applications' tutorial
Or grab my completed code at my Github Repo
Fire up your server!
go build main.go ./main http://localhost:8080
Again, for the sake of brevity I'm skipping a lot. If you're here and the above hasn't worked for you I suggest stepping through the aforementioned tutorial. It has all you need to get off the ground.
So you have a server but you don't have anywhere to put it. This is where AWS EC2 comes in. Once again, here is a very helpful guide: Getting Started with Amazon EC2 Linux Instances. Walk through steps 1-4 to get an instance running,
Install Golang and Git on your EC2 instance as before and pull your repo down to your server.
Now you have an AWS EC2 instance with running (go) server code, but we still need to be able to access it. This instance has a Dynamic IP - it changes periodically. Not useful to use. We need to assign a static IP. Under the left panel of the EC2 console you should see a link called 'Elastic IPs'. Click this and allocate a new address to your EC2 instance.
Now we have an EC2 instance with server code running and a static IP pointing to it. Great! Last step, which is entirely optional: go to name.com and register a domain name (it may cost $5+ for a year or so). Once that's done, create a CNAME record that points to your static IP. Here is yet another, more-detailed guide for this process.
"},
        {title: 'Hello World', created_at: DateTime.parse('28-12-2013'), content: 'This blog was built to learn Go but also to post things that I pick up along the way. I believe strongly that programmers as a whole benefit from a community of giving, not just one of taking.
Therefore, I hope that you - the reader - finds something here of worth. And if nothing else, go fork my repo for this site (https://github.com/jadekler/git-go-jeansite) and start your own blog!'}
])
