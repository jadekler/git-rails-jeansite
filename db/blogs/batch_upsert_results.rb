@blogs.push(Blog.create({title: 'Finding The Results Of A Batch Upsert With MySQL', created_at: DateTime.parse('22-09-2014'), content: "This post is inspired by a discussion a former colleague and I recently had about finding the changeset of a mysql batch upsert. The problem is as such: Given a series of asynchronous workers performing batch upserts into mysql (see below), how would each worker know the IDs of those the specific worker inserted, and those it updated?

For reference, here is an example of a batch upsert:

```
mysql> use temp;
Database changed
mysql> CREATE TABLE users (id INT(11) PRIMARY KEY, name VARCHAR(255), age INT(11));
Query OK, 0 rows affected (0.00 sec)

# Let's insert bob, sam, and alex
mysql> INSERT INTO temp.users (id, name, age) VALUES (1, \"bob\", 5), (2, \"sam\", 7), (3, \"alex\", 9);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

# Let's re-insert bob and sam, with updated ages
mysql> INSERT INTO temp.users (id, name, age) VALUES (1, \"bob\", 6), (2, \"sam\", 8) ON DUPLICATE KEY UPDATE name=VALUES(name), age=VALUES(age);
Query OK, 4 rows affected (0.00 sec)
Records: 2  Duplicates: 2  Warnings: 0

# Note: mysql says 4 rows were affected - it will count 1 row per insert, 2 per update
```

So, how would we go about getting the IDs of those that were inserted and those that were updated? Our first guess might be a pair of columns called created_at and updated_at - things that were inserted would have an inserted_at date recently, and things that were updated would have an updated date recently without an inserted date recently.

We quickly throw that idea away when we remember that we have several asynchronous workers - what if two workers inserted things within a second of each other? Our solution becomes very messy very quickly.

Now we move onto a more robust solution: a column to tell us if a row has been updated or inserted, and a row to tell us which worker did it. The former is of course a bool column, and for the latter we'll use a sequence generating table to give each worker a unique ID. This unique id will simply be an ID assigned by an auto incrementing counter - sounds messy, right? Well, maybe not: we can use transactions to create a new id, grab and store it in our worker, and rollback to remove all trace of us using the table. The table will very infrequently store rows, but generally will be in an empty state.

So, let's revise our table creation to use InnoDB so that we can use transactions, and also create a sequence table to generate our unique IDs:

```
mysql> CREATE TABLE users (id INT(11) PRIMARY KEY, name VARCHAR(255), age INT(11), inserted BOOL, sequence INT(11)) ENGINE=InnoDB;
Query OK, 0 rows affected (0.00 sec)

mysql> CREATE TABLE sequence (id INT(11) AUTO_INCREMENT PRIMARY KEY) ENGINE=InnoDB;
Query OK, 0 rows affected (0.00 sec)
```

Let's use this idea of a sequence table in the above example. We'll begin again by populating our users table with stuff that we'll later be updating:

```
# We're ok with the inserted and sequence columns being null for now
mysql> INSERT INTO temp.users (id, name, age) VALUES (1, \"bob\", 5), (2, \"sam\", 7), (3, \"alex\", 9);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0
```

Now, let's upsert things - however, we'll do this in a programming environment, since we'll need to store variables. For this case I'll just use bash, but feel free to use any language of your choice.

```
# Note: -s is silent mode, and -N skips columns - we just want our one ID variable
[jadekler@Jeans-MacBook-Pro:~/go/src]$ newSequenceID=`mysql -uroot -s -N -e 'START TRANSACTION; INSERT INTO temp.sequence (id) VALUES (null); SELECT * FROM temp.sequence; ROLLBACK;'`

# Now that we have a sequence ID that only this worker knows about, let's perform our batch upsert with one update and one new insert
[jadekler@Jeans-MacBook-Pro:~/go/src]$ mysql -uroot -e \"INSERT INTO temp.users (id, name, age, inserted, sequence) VALUES (1, 'bob', 6, 1, $newSequenceID), (4, 'james', 2, 1, $newSequenceID) ON DUPLICATE KEY UPDATE name=VALUES(name), age=VALUES(age), inserted=0, sequence=$newSequenceID;\"
```

Let's grab the rows that were inserted:

```
[jadekler@Jeans-MacBook-Pro:~/go/src]$ mysql -uroot -e \"SELECT * FROM temp.users WHERE inserted=1 AND sequence=$newSequenceID\";
+----+-------+------+----------+----------+
| id | name  | age  | inserted | sequence |
+----+-------+------+----------+----------+
|  4 | james |    2 |        1 |       13 |
+----+-------+------+----------+----------+
```

Great! And, those that were updated:

```
[jadekler@Jeans-MacBook-Pro:~/go/src]$ mysql -uroot -e \"SELECT * FROM temp.users WHERE inserted=0 AND sequence=$newSequenceID\";
+----+------+------+----------+----------+
| id | name | age  | inserted | sequence |
+----+------+------+----------+----------+
|  1 | bob  |    6 |        0 |       13 |
+----+------+------+----------+----------+
```

And that's it! MySQL's auto increment guarantees us a new ID each time, so this approach is rock solid.

CREDIT: Idea for this is from a former colleague of mine - [John Klassa](http://klassa.com/john/), one of the best programmers I've ever met.
"}))