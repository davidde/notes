# GIT cheatsheet
(loosely inspired by Udacity's course: How to use Git and Github)

## Overview

|     Location           |   Transition Command     |
|------------------------|--------------------------|
| working directory      |     git add              |
| staging area           |     git commit           |
| local repository       |     git push             |
| remote repository      | "Pull Request on Github" |
| upstream repository    |     /                    |

Git commands like log and diff show their result in the less editor,
which means 'q' to exit.

## Basic git commands and usage, alphabetically:

* git add main.go  
Add main.go to be tracked by git, it is now said to be staged.
(It still needs to be committed to actually be included in version control)

* git add .  
Add all files in the directory.
This is useful if you want to upload an existing project to Github.
(Use a .gitignore file that lists all exceptions)

* git branch 'new_branch'  
Create the 'new_branch' branch.

* git branch -a  
Show all branches.

* git checkout cffd76070aaebf82e4b5eb330fe9a2df944c1b81  
Checkout commit cffd76070aaebf82e4b5eb330fe9a2df944c1b81.

* git checkout master (--force)  
Move back to the master/head commit.  
--force: When you've made changes that aren't committed,
git won't let you checkout another branch. The "--force" flag
forces git to checkout anyway, which will result in losing the changes.

* git checkout -b test_branch (cffd76070)  
= Shorthand for:  
$ git branch test_branch (cffd76070)  
$ git checkout test_branch (cffd76070)  
(cffd76070): Optionally specify a commit hash to base the branch on.
When not specified, it is based on the currently checked out commit
(current position of head) So when you're in detached head state
(= after checkout of commit hash instead of branch), you can simply
run 'git checkout -b test_branch' to turn that commit into a real branch.
Afterwards, simply:  
$ git checkout master  
$ git branch -d test-branch  
to checkout master, and delete the branch if you don't need it anymore.

* git commit -m "Description of changes"  
Commit all tracked files permanently to version history.

* git diff  
Shows all modifications that are NOT yet staged.  
(= difference between working directory and staging area)

* git diff --staged  
Shows all modifications that are staged.  
(= difference between staging area and last commit)

* git diff cffd76070aaebf82e4b5eb330fe9 1e14e1134d7eabf136d6210a6d87a99  
or: git diff cffd76070aaebf82e4b5eb330fe9 1e14e  
or: git diff cffd 1e14  
=   git diff old new!  
(you may abbreviate commit hashes; the first 4 or more chars suffice)  
Compare 2 specific commits (get commit hash from 'git log' command)

* git log (--stat)  
          (--oneline --graph master other_branch)  
Log of all git commits in less editor (q to exit).  
--stat: shows additional data like the files that were changed,
and insertions/deletions.  
--oneline: show only one line per commit.  
--graph master other_branch: show a graph of how the commits
in both branches relate to each other.

* git log | cat  
Prints git log output on standard output/ terminal.

* git ls-files  
List the files managed by git.

* git merge master other_branch  
Merges the other_branch and the master branch into the
currently checked out branch.
So the currently checked out branch is always included in a merge!
To merge other_branch into master, do:  
$ git checkout master  
$ git merge other_branch  
(Also, since the two branches are merged, the order in which they
are typed into the command line does not matter. The key is to remember
that "git merge" always merges all the specified branches
**into the currently checked out branch**, creating a merge commit
for that branch.)

* git merge --abort  
Restore your files to their state before you started the merge.

* git push REMOTENAME BRANCHNAME  
Pushes the specified branch to the specified remote.

* git pull origin master  
= git fetch origin  
\+ git merge master origin/master  
When you clone a git repository from github, you get separate pointers
to master (= latest commit in local master branch) and to origin/master
(= latest commit in githubs master branch). When you commit locally,
only the master branch is updated. When you commit on github and then fetch,
the origin/master branch will be updated locally. If you then merge both
branches, you'll get the same result as a 'git pull origin master'.  
(But if 'git pull' is the same as 'fetch + merge', why don't we get
merge commits when pulling?  
=> This is because git by default performs 'fast-forward merges'
when one commit is reachable from the other; the oldest commit's label
is fast-forwarded to the head of the branch. No merge commit is
necessary since they are already linked.)  
(-> Udacity Git/Github Lesson 4, 21.)

* Pull request (Github-specific):  
You request the original author to pull your changes into his master.  
-> could also be called "Merge request"  
To contribute to a public project on Github, you have to first 'fork' it
(similar to clone, but Github-specific), so you have your own version of
the project to make changes to. Then you can start a pull request to have
the author of the original project (commonly referred to as 'upstream')
include your changes into his repository.  
When contributing to a public repository on Github, it’s standard practice
to make the changes in a non-master branch within the fork. This way,
you can easily keep your master branch up-to-date with the master of the
original repository, and merge changes from your master into your branch
when you are ready.

* Keeping a Github fork up to date:
  - Clone your fork:  
  $ git clone https://github.com/YOUR-USERNAME/YOUR-FORKED-REPO.git
  - Add remote from original repository in your forked repository:  
  $ cd into/cloned/fork-repo  
  $ git remote add upstream https://github.com/ORIGINAL-DEV-USERNAME/REPO-YOU-FORKED-FROM.git  
  $ git fetch upstream  
  - Updating your fork from original repo to keep up with their changes:  
  $ git pull upstream master  
  - Push the changes to your fork:  
  $ git push

* git remote add origin "remote repository URL"  
Add your project to github by setting a remote first.  
Afterwards, push or pull your project by running:  
$ git push origin master  
$ git pull origin master  
(Run: "git remote -v" to check if remote was added correctly)  
upstream/master: this is the repository you forked, to which you're trying
to contribute. When collaborating, it's often necessary to add this repository
as a remote, in order to resolve merge conflicts between your fork and upstream:  
$ git remote add upstream "remote repository URL"  
then you can pull in the conflicting changes from upstream/master:  
$ git pull upstream master  
and merge the master branch into your 'change' branch:  
$ git checkout change  
$ git merge master  
(git merge merges all specified branches into the currently checked out branch)  
Resolve merge conflicts locally:
  - update 'file.txt'
  - git add 'file.txt'
  - git commit   (-> the 'merge commit')

  Then push your 'change' branch to your fork (NOT upstream):  
  (this will automatically update your pull request)  
  $ git push origin change  
  Finally, just update the master branch on your fork:  
  $ git checkout master  
  $ git push origin master  
  (-> Udacity Git/Github Lesson 4, 33.)

* git reset main.go  
Unstages main.go, but preserves its contents.

* git reset (--hard)  
Undo all changes.  
--hard: also modifies your working directory;
so it is dangerous to lose uncommitted changes.

* git reset HEAD~ (--hard)  
Undo the latest commit, the staged/tracked files will no longer be staged/tracked.  
(HEAD is a pointer to the most recent git commit in a specific branch;
detached head means the head does not point to the most recent commit.
This happens when you move the head back in time by checking out a
specific commit hash)  
If the commit was already pushed to your remote, you will have to push the newly
deleted version again with the --force flag to delete it from the remote:  
$ git push origin master --force

* git reset cffd76070aaebf82e4b  
Undo all commits that came after cffd76070aaebf82e4b!

* git status  
Lists all new or modified files to be committed.

* git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81  
Compare a specific commit to its parent commit.

* git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81:main.go  
Look at a specific commit of the main.go file (path required) in less editor.

* git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81:main.go | vi -  
Look at a specific commit of the main.go file (path required) in vi editor.

* git show HEAD:main.go  
Show the head (most recent) commit of main.go

* git show HEAD~2:main.go | vi -  
Show the third latest commit of main.go in the vi editor.
