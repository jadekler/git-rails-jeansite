@blogs.push(Blog.create({title: 'Godoc And You', created_at: DateTime.parse('11-05-2014'), content: "This post will talk briefly about the basic Godoc functionality - if you have already been exposed to godoc, you probably know all of this. Fair warning! For those of you who haven't taken a look at godoc, check out this [summary of godoc](http://blog.golang.org/godoc-documenting-go-code) and quickly read through [Go's recommended Commentary section](http://golang.org/doc/effective_go.html#commentary). What follows is a couple of examples of godoc.

###### Host the entire golang docs...on your machine!

Yep! ALL of the google docs live on your machine. Navigate to the go common code (run `which go` to see where it lives). Type `godoc -http=:6060` and (in your browser) go to `http://localhost:6060`. You can also add -index=true if you'd like searchable docs, as per the officially hosted docs.

###### Use godoc to generate documentation for your code

Just type `godoc -http=:6060 -goroot='/path/to/your/project'`. Simple as that!

###### Use godoc to search for packages in the command line

If I'm looking for the regexp package, I can simply type godoc regexp to get the regexp documentation. If I'm looking for something like 'parse', I can narrow down my search even further with something like godoc regexp | grep parse. Sweet!"}))