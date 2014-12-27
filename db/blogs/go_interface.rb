@blogs.push(Blog.create({title: 'The Go interface{} In Ambiguity', created_at: DateTime.parse('25-05-2014'), content: "As many of you may be aware, the interface{} type is basically Go's way of placeholding a spot for ANY other type. As a result, following code works perfectly fine:
```
package main

import (
    \"log\"
)

func loggit(loggableItem interface{}) {
    log.Println(loggableItem)
}

func main() {
    loggit(5)
    loggit(\"five\")
}
```

That's cool, but what if I'm working in the loggit function without any knowledge of the types of things coming in? How would I go about finding the actual type of the interface{} variable? Well, with the handy reflect package, we can simply do the following:

```
package main

import (
    \"log\"
\"reflect\"
)

func loggit(loggableItem interface{}) {
    log.Println(reflect.TypeOf(loggableItem))
    log.Println(loggableItem)
}

func main() {
    loggit(5)
    loggit(\"five\")
}
```

Awesome! Now, how about using those types? There is one more shortcut with this: when you switch something like an interface{}, you can simply use the following switch shorthand:

```
package main

import (
    \"log\"
\"reflect\"
)

func loggit(loggableItem interface{}) {
    switch loggableItem.(type) {
        case int:
            log.Println(\"This is an int!\")
        case string:
            log.Println(\"This is a string!\")
    }

    log.Println(reflect.TypeOf(loggableItem))
    log.Println(loggableItem)
}

func main() {
    loggit(5)
    loggit(\"five\")
}
```

And, of course, all the above applies to your own structures as well as the int and string that I've used here for example. I hope this has been helpful!"}))