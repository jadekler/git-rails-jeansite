@blogs.push(Blog.create({title: "Javascript's Inner-Outer Function Scoping vs Go's", created_at: DateTime.parse('08-06-2014'), content: "The language I'd been focusing on before Go was Javascript - naturally, there were Javascript-y things I was used to doing that I tried in Go. Most of them were pretty similar: functions are similar, various logical and mathematical operators work as you'd expect, switches and ifs and so on work very similarly. However, one thing I recently stumbled upon does not: the concept of inner and outer scoping.
In many programming languages, there is the concept of lexical scoping. In short, the scope of an outer function (which may contain variables) is apparent to an inner function (e.g., the inner function can access the variables of the outer). Here is a javascript example (source):

```
function init() {
    var name = \"Mozilla\"; // name is a local variable created by init
    function displayName() { // displayName() is the inner function, a closure
        alert (name); // displayName() uses variable declared in the parent function    
    }
    displayName();    
}
init();
```

[See this in JSFiddle](http://jsfiddle.net/Q27Qe/)

A common problem with lexical scoping is the case of variables in the inner and outer function that have the same name. In javascript, we can deal with this problem by storing the scope (among other methods). See below an example of storing the scope to access both the inner and outer variable:

```
(function() {
    var self = this;
    this.foo = \"bar\";
    (function(foo) {
        foo = \"gaz\";
        console.dir(foo);
        console.dir(self.foo);
    }(foo));
    console.dir(foo);
}())
```
    
[See this in JSFiddle](http://jsfiddle.net/w4jHW/)

In other languages we might use things like super and parent to access parent classes or functions, but the idea is pretty apparent: we either store scope or keep it in saved in some reserved keyword to access things higher up the chain. So, how do we do this in go? See below:

```
// It turns out you can't...easily
```
    
Here is an example of code we would want to behave in the same way (but does not yet):

```
package main

import (
    \"fmt\"
)

func main() {
    foo := \"bar\"
    func(foo string) {
        foo = \"gaz\"
        // Foo is passed by value (presumedly) and is unaffected outside
        // this goroutine. However, we cannot access the original
        fmt.Println(foo)
    }(foo)
    fmt.Println(foo)
}
```
    
[See this in the Go Playground](http://play.golang.org/p/BDfHCBKk6p)

So it turns out that Go has no way to access the outer method - no scope saving, no reserved keyword, nothing. The best we can do is work around it using different variable names (duh) or a struct. Very unsatisfactory! Oh well. =) Here is the previous example using a struct.

```
package main

import (
    \"fmt\"
)

type Capsule struct {
    foo string
}

func main() {
    capsule := Capsule{foo:\"bar\"}
    func(foo string) {
        foo = \"gaz\"
        fmt.Println(capsule.foo)
    }(capsule.foo)
    fmt.Println(capsule.foo)
}
```
    
[See this in the Go Playground](http://play.golang.org/p/23ozK9VSjD)
"}))