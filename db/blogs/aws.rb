@blogs.push(Blog.create({title: 'Setting Up A Golang Website On AWS', created_at: DateTime.parse('29-12-2013'), content: "It should come as no surprise that the first post will talk about how this website is written, and how you can do the same. Keep in mind that this post is being written in the present - future iterations of the site may look different, but this is a solid place to start. Also, for this post I will provide only a summary - not a full explanation. So to start, let's briefly take a look at the tools we'll be using to get this up on its feet:
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
"}))