@blogs.push(Blog.create({title: 'Advanced Usage Git Guide', created_at: DateTime.parse('12-03-2014'), content: "Due to popular demand, here are a couple more git tips and tricks. These won't exactly be edge cases, but they should hopefully not be your average day usage. This set of commands, combined with the Quickstart Git Guide, should get you through most problems you face.
#### Revert To Earlier Commit
###### Feels like svn revert

Commands (Note: idea from [this stack overflow response](http://stackoverflow.com/questions/1895059/revert-to-a-commit-by-sha-hash))

```
# Reset the index to the desired SSH
git reset [SSH]

# Move the branch pointer back to the previous HEAD
git reset --soft HEAD@{1}

# Commit the revert
git commit -m 'Reverted to [SSH]'
git push

# Update working copy to reflect new commit
git reset --hard
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset 7c9165064021e62e4c2a3fb925a14bc535240446
Unstaged changes after reset:
D   test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset --soft HEAD@{1}
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446'
[master af7f80a] Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446
 1 file changed, 5 insertions(+)
 create mode 100644 test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git reset --hard
HEAD is now at af7f80a Reverted to 7c9165064021e62e4c2a3fb925a14bc535240446
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 343 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 2 (delta 0)
To https://github.com/jadekler/git-misc.git
   6afb73c..af7f80a  master -> master
```

#### Git Pull Conflicts

Sometimes when you pull you will get a message like 'Your local changes to the following files would be overwritten by merge. Please, commit your changes or stash them before you can merge.' There are two ways to deal with this: discarding your changes and pulling, stashing your changes and pulling or commiting your changes, fixing conflicts, and pulling. Let's briefly walk through these three options.

###### Git Pull Conflicts - Discard Changes

Commands
```
# Here you see a pull method. You choose to (a) discard your changes
git pull

# This discards all changes you've made
git checkout .

# Now you can cleanly pull
git pull
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   af7f80a..fdd9556  master     -> origin/master
Updating af7f80a..fdd9556
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout .
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
Updating af7f80a..fdd9556
Fast-forward
 test/index.html | 2 --
 1 file changed, 2 deletions(-)
```

###### Git Pull Conflicts - Merge Changes

Commands
```
# Here you see a pull method. You choose to (b) merge your changes
git pull

# Add your changes
git add -A
git commit -m 'Committing local changes'

# Merge your commit with origin
git merge origin

# Edit your conflicted file and remove things like >>>>>>> origin and <<<<<<< HEAD
vim [conflicted file]

# Add your merge fix
git add -A
git commit -m 'Committing merge fixes'
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   b1da90f..5e94678  master     -> origin/master
Updating b1da90f..5e94678
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Preparing to merge changes with origin'
[master f7c3fc7] Preparing to merge changes with origin
 1 file changed, 1 insertion(+), 1 deletion(-)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git merge origin
Auto-merging test/index.html
CONFLICT (content): Merge conflict in test/index.html
Automatic merge failed; fix conflicts and then commit the result.
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ vim test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Merge conflicts resolved'
[master 5eb7336] Merge conflicts resolved
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 11, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (5/5), 527 bytes | 0 bytes/s, done.
Total 5 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   5e94678..5eb7336  master -> master
```

###### Git Pull Conflicts - Stash Changes

Commands
```
# Here you see a pull method. You choose to (c) stash your changes
git pull

# Saves your changes in a stack and resets you to origin
git stash

# Grabbing origin will now work, since your changes are removed (and saved in the stash)
git pull

# Re-apply your saved changes. Any merge conflicts will be dealth with in the same way that merging works (see Merge Changes above)
git pop
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 2 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   5eb7336..b3e4850  master     -> origin/master
Updating 5eb7336..b3e4850
error: Your local changes to the following files would be overwritten by merge:
    test/index.html
Please, commit your changes or stash them before you can merge.
Aborting
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git stash
Saved working directory and index state WIP on master: 5eb7336 Merge conflicts resolved
HEAD is now at 5eb7336 Merge conflicts resolved
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
Updating 5eb7336..b3e4850
Fast-forward
 test/index.html | 2 --
 1 file changed, 2 deletions(-)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git stash pop
Auto-merging test/index.html
CONFLICT (content): Merge conflict in test/index.html
```"}))