@blogs.push(Blog.create({title: 'Writing A Lexical Parser For Logic Statements', created_at: DateTime.parse('21-09-2014'), content: "As programmers, we frequently write logic statements: `A && B`, `(A != C) || D`, `A NOT EQUAL TO F AND B NOT IN (C,D,E)`, and so on. These high-level statements get interpreted by a parser as part of the compiler and typically get turned into low-level language understandable in the target language. This is because it's generally easy to write things like A && B, rather than something like:

```
MOVE _x, R7
COMPARE _y, R7
```

But, what if we take this one step further? Let's write a language that non-programmers can read, and parse it into language that something like MySQL could understand. This could be useful if you want to provide users of your app the ability to organically search through a large dataset, for instance.
So, the first thing we need to do is define our human-readable language. Let's make it simple: `A eq B`, `A neq B`, `(A eq B and A neq C) or A eq D`. So, a couple of equality operators (eq, neq) and a couple of logical operators (and, or). Simple enough.
Now, let's see what we want our target language to look like:

- `A eq B` should become `A = B` in mysql
- `A neq B` should become `A != B`
- `(A eq B and A neq C) or A eq D` should become `(A = B AND A != C) OR A = D` in mysql

A pretty simple example, but to a non-programmer we may have already crossed the 'eyes-glazed' line, and certainly would if we threw in things like `BETWEEN`, `COALESCE`, `IN`, `CONTAINS`. Even then we might still have some non-programmers who'd be able to follow along, but mysql is an easy target language. A target language like C, Go, or Java would probably not do as well.

Anyways, let's talk about implementing this parser. In our above example, all we need to do is define a grammar: `eq` becomes `=`, `and` becomes `AND`, and so on. This is simple enough and done quickly with string replace functions.

What if we wanted to keep these statements in memory, and then modify parts of it as we go? Or, what if we wanted to add an optimization step that removes duplicate conditions?

Suddenly our problem is no longer solved by keeping the human-readable conditions in one string that simply gets string replaced upon. We need to define a slightly more robust way to hold our conditions.

The data structure that has probably already occurred to the reader is an n-width tree, where each branch is a logical condition (`and`, `or`, `xor`, etc) and each leaf an equality condition (`A eq B`, `D neq K`, etc). Building this tree from something like `(A eq B and A neq C) or A eq D` is surprisingly easy: we start at a root node, recurse down a level into the children of the node for each opening paren we see, recurse up a parent for each closing paren we see, and assign to the children each time we see a condition. See below an example of what this might look like:

![](/images/lexical_tree.png)

This approach runs through the human-readable once only, and touches each node only once (barring recurses up and down) - therefore, we have a speedy O(n) time method for creating our data structure, which is also conveniently stored in O(n) space. Converting our tree back to human-readable conditions (stringifying the tree) is as simple as traversing the tree post-order. We do the same for converting our tree to target language, with the added step of applying our grammar at each node. Simplicity!

Now, when we wish to modify our conditions, we simply modify the tree representation, stringify the tree, and give it back to the user. No problem!

To see this in action, as well as to see how you might store this tree in mysql for persistance, [https://github.com/jadekler/git-go-logictree/](check out my example here).
"}))