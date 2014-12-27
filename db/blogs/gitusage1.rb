@blogs.push(Blog.create({title: 'Quickstart Git Guide', created_at: DateTime.parse('10-03-2014'), content: "This post will serve as a quick, functional guide to jumping into git as well as a refresher for those who've used it before. I will use some examples from SVN as comparison.

#### Git Clone
###### Feels like svn checkout

Commands
`git clone [repo address] [local address]`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs]$ git clone https://github.com/jadekler/git-misc.git
Cloning into 'git-misc'...
remote: Reusing existing pack: 540, done.
remote: Total 540 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (540/540), 13.75 MiB | 4.19 MiB/s, done.
Resolving deltas: 100% (192/192), done.
Checking connectivity... done
```

#### Git Status
###### Feels like svn status

Commands
`git status`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git status
# On branch master
# Untracked files:
#   (use 'git add ...' to include in what will be committed)
#
#   test/
nothing added to commit but untracked files present (use 'git add' to track)
```

#### Git Add, Commit, Push
###### Feels like svn commit

Commands
```
# -A will add all, including removals
git add [filename] OR git add -A

# Store commit on local machine
git commit -m [commit message]

# Send to server
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Added test folder'
[master 3d2a496] Added test folder
 1 file changed, 1 insertion(+)
 create mode 100644 test/index.html
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 311 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   5f78792..3d2a496  master -> master
```

#### Git Pull
###### Feels like svn update

Commands
`git pull`

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From https://github.com/jadekler/git-misc
   3d2a496..8bfcfea  master     -> origin/master
Updating 3d2a496..8bfcfea
Fast-forward
 test/index.html | 2 ++
 1 file changed, 2 insertions(+)
```

#### Git Branch Create
###### Feels like svn checkout trunk branch

Commands
```
# Create new branch and switch to it
git checkout -b [branch name]

# View your branches
git branch

# Add new branch to repository
git push origin [branch name]
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout -b newbranch
Switched to a new branch 'newbranch'
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git branch
  master
* newbranch
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push origin newbranch
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
 * [new branch]      newbranch -> newbranch
```

#### Git Branch Pushing
###### Feels like svn commit

Commands
```
# Same as before
git add -A
git commit -m [commit message]

# Pushing a branch requires manually specifying the from and to
git push origin [branch name]
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git add -A
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git commit -m 'Some minor changes to my file in this branch'
[newbranch 7c91650] Some minor changes to my file in this branch
 1 file changed, 2 insertions(+)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push origin newbranch
Counting objects: 7, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (4/4), 332 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   8bfcfea..7c91650  newbranch -> newbranch
```

#### Git Merge
###### Feels like svn merge

Commands
```
git checkout master
git merge [branch name]
git push
```

Example
```
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git checkout master
Switched to branch 'master'
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git merge newbranch
Updating 8bfcfea..7c91650
Fast-forward
 test/index.html | 2 ++
 1 file changed, 2 insertions(+)
[jeand@Jeans-MacBook-Pro-2:/Applications/XAMPP/htdocs/git-misc]$ git push
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/jadekler/git-misc.git
   8bfcfea..7c91650  master -> master
```
"}))