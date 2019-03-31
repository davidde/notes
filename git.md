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

Git commands like log and diff show their output in the 'less' pager,
which means 'q' to exit.

## Basic git commands and usage, alphabetically:

### $ `git add main.go`  
Add main.go to be tracked by git, it is now said to be staged.   
(It still needs to be committed to actually be included in version control)

### $ `git add .`  
Add all files in the directory.
This is useful if you want to upload an existing project to Github.   
(Use a .gitignore file that lists all exceptions)

### $ `git branch [new_branch]`  
Create the branch 'new_branch'.

### $ `git branch -u origin/[remote-branch]`
### = `git branch --set-upstream-to=origin/[remote-branch]`  
This sets the default remote branch for the current local branch.  
Any future git pull command (with the current local branch checked-out),
will attempt to bring in commits from the 'remote-branch' into the current local branch.
One way to avoid having to explicitly do `--set-upstream-to` is to use the shorthand flag
`-u` along with the very first `git push` as follows:  
$ `git push -u origin local-branch`  
which sets the upstream association for any future push/pull attempts automatically.  

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
to checkout master, and delete the branch (locally) if you don't need it anymore.  
To also delete the branch remotely (on Github):  
$ git push origin --delete test_branch  

* git commit (-a) -m "Description of changes"  
Commit all staged files permanently to version history.  
-a/--all: Automatically stage/add all tracked files that were modified; this means you don't
have to manually stage/'git add' all files that are modified.  
Shortcut: $ git commit -am "Description of changes"

* git commit --amend  
Rewrite the most recent commit message and/or commit content (if they have not yet been pushed online).  
If you want to also edit the commit's content, you need to 'git add' the edited files before amending,  
so you may or may not have to 'git stash' code that shouldn't be included.  
(In Git, the text of the commit message is part of the commit.  
Changing the commit message will change the commit ID, i.e. the SHA1 checksum that names the commit.  
Effectively, you are creating a new commit that replaces the old one, but keeps its date.)

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
Log of all git commits in less pager (q to exit).  
--stat: shows additional data like the files that were changed,
and insertions/deletions.  
--oneline: show only one line per commit.  
--graph master other_branch: show a graph of how the commits
in both branches relate to each other.

* git log --name-status  
Adds the names and status of the changed files on every commit.

* git log --format=fuller  
Shows the difference between AuthorDate and CommitDate. They are usually the same,
but can differ for example after a 'git rebase'. The CommitDate is taken into account
when creating the commit hash, so a 'git rebase' without changes still modifies the hash.  
Other 'git log'-formats: oneline, short, medium, full, fuller, email, raw, ...

* git log | cat  
Prints git log output on standard output/ terminal.

* git ls-files  
Lists all the files that exist in the latest commit on the current branch.

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

* git mv old_filename new_filename  
Rename a tracked file.

* git push REMOTENAME BRANCHNAME  
Pushes the specified branch to the specified remote.

* git push --set-upstream origin --all  
= git push -u origin --all  
Pushes all branches to the origin remote, and sets origin as 'upstream' for all of them.  
This means on next push you don't need to specify neither your branch, nor  
your remote; simply run 'git push'.

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
  $ git clone `https://github.com/YOUR-USERNAME/YOUR-FORKED-REPO.git`
  - Add remote from original repository in your forked repository:  
  $ cd into/cloned/fork-repo  
  $ git remote add upstream `https://github.com/ORIGINAL-DEV-USERNAME/REPO-YOU-FORKED-FROM.git`  
  $ git fetch upstream  
  - Updating your fork from original repo to keep up with their changes:  
  $ git pull upstream master  
  - Push the changes to your fork:  
  $ git push

* git rebase -i HEAD~3  
  (or: git rebase -i `Commit-Hash-You-Want-To-Change`^  
  with the ^ to refer to the parent of that commit; otherwise you'll be off-by-one)  
Change the commit messages or commit content for the last 3 commits.  
This command will present you with your default editor;
change 'pick' to 'reword' for the commit message(s) you want to change, then save and close.
A new editor window will appear for each commit message you wish to change.  
If you also want to change the commit content, change 'pick' to 'edit', then save and close.
Back in your shell, you'll notice you're no longer on 'master', but on the specific commit
hash you chose to modify; simply change the code you want, 'git add' the changes, and
'git commit --amend' the commit. Enter 'git rebase --continue' to finish up the rebase.
Most likely this will include fixing a merge conflict because git will have trouble
auto-merging the succeeding commit with your change ...  
**Note:**  
Amending the commit message will result in a new commit ID since the message itself
is used in the SHA1 hash that generates the commit ID. However, in this case, every commit
that follows the amended commit will also get a new ID because each commit also contains
the id of its parent.  
So if you have already pushed to GitHub, you will have to force push the amended messages/content.  
However, **'force pushing' is strongly discouraged**, since this changes
the history of your repository. If you force push, people who have already cloned
your repository will have to manually fix their local history.
For more information, see ["Recovering from upstream rebase"](https://git-scm.com/docs/git-rebase#_recovering_from_upstream_rebase) in the Git manual.

### $ `git remote add origin [remote-repository-URL]`  
Add your project to github by setting a remote first.  
Afterwards, push or pull your project by running:  
$ git push origin master  
$ git pull origin master  
(Run: "git remote -v" to check if remote was added correctly)  
(To change the URL, for instance from `git` to `https`, use:  
$ `git remote set-url origin https://github.com/USERNAME/REPOSITORY.git`)  
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

* git reset 6f16fb26b3294 src/app/app.js  
Reset a specific file (app.js) to the state of a previous commit.

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

* git reset cffd76070aaebf82e4b (--hard)  
Undo all commits that came after cffd76070aaebf82e4b!  
--hard: will also get rid of everything you've done since then;  
all unpublished commits will be lost from your hard disk.  

### $ `git rm filename`  
Remove a file from both git and working directory,  
so it doesn't longer show up as an untracked file.

### $ `git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81`  
Compare a specific commit to its parent commit.

* $ `git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81:main.go`  
Look at a specific commit of the main.go file (path required) in less pager.

* $ `git show cffd76070aaebf82e4b5eb330fe9a2df944c1b81:main.go | vi -`  
Look at a specific commit of the main.go file (path required) in vi editor.

* $ `git show HEAD:main.go`  
Show the head (most recent) commit of main.go

* $ `git show HEAD~2:main.go | vi -`  
Show the third latest commit of main.go in the vi editor.

### $ `git status`  
Lists all new or modified files to be committed.

### $ `git stash`  
Takes the dirty state of your working directory (uncommitted changes in tracked  
files) and saves ('stashes') it on a stack of unfinished changes that you can reapply at any time.

* $ `git stash list`  
Lists the entire stash (each `git stash` command creates a new snapshot).

* $ `git stash apply`  
Apply the most recent stash.

* $ `git stash apply stash@{2}`  
Apply an older stash; git its id from `git stash list`.

* $ `git stash drop (stash@{2})`  
Remove a stash from your stack.

* $ `git stash pop (stash@{2})`  
Apply the stash and then immediately drop it from your stack.

* $ `git stash push -m 'Put counter in Status' src/app/status/status.js`  
Stash a single file, by specifying a stash message and a path to the file.  
(NOTE: git 2.13 and up ONLY!)

* $ `git stash show`  
Shows which files were changed in the latest stash.

* $ `git stash show -p`   
View the content of the most recent stash (-p: 'patch').

* $ `git stash show -p stash@{2}`   
View the content of a specific stash.
If, however, you wish to view the content of a single file from a specific stash, you need to use the `git show` command:  
$ `git show stash@{0}:src/app/app.js`   
If you want to see the diff of a specific file in the stash, you have to use the `git diff` command:  
$ `git diff stash@{0}^1 stash@{0} -- <filename>`   
The `stash@{0}^1` shortcut means the first parent of the given stash, which is the commit at which
the changes were stashed away. We use this form of "git diff" (with two commits) because we have
to tell git which parent we want to diff against. Equivalent, but more cryptic:   
$ `git diff stash@{0}^! -- <filename>`

### $ `git submodule add https://github.com/matcornic/hugo-theme-learn.git themes/hugo-theme-learn`   
Add the project located at the github link as a submodule to the project in the working directory.
This allows combining several git repos in a single project.  
**Beware**:   
When pulling a github project, its submodules are **NOT** automatically pulled along!   
For that, you have to:   
$ `git submodule init`   
$ `git submodule update`   
