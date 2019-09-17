# GIT cheatsheet

## Overview

|     Location           |   Transition Command     |
|------------------------|--------------------------|
| working directory      |     git add              |
| staging area           |     git commit           |
| local repository       |     git push             |
| remote repository      | "Pull Request on Github" |
| upstream repository    |     /                    |

Many git commands like `git log`, `git diff` and `git [command] --help` show their output  
in the `less` pager, which means `q` to exit.  
To search in the less pager, use `/` followed by the search term and press enter.  
Use `n` and `N` to move forwards/backwards in the search results.  

**Tip**:  
$ `git [command] --help`  
This gets you information on any git command.

## Basic git commands and usage, alphabetically:

### $ `git add main.go`  
Add main.go to be tracked by git, it is now said to be staged.   
(It still needs to be committed to actually be included in version control)

### $ `git add .`  
Add all files in the directory.
This is useful if you want to upload an existing project to Github.   
(Use a .gitignore file that lists all exceptions)

### $ `git blame [path/to/file]`  
This will show you the commit hash, the time and the committer for each line.  
Then you can use the commit hash in `git log [hash]` or `git show [hash]`  
to find out more about it, like why it's done this way (if documented).  
You can also use the -L flag to indicate the from-to line numbers you want info about:  
$ `git blame -L 38,41 src/color/adjustHue.js`  
Or for a single line, use:  
$ `git blame -L 38,38 src/color/adjustHue.js`  
**Note:**  
`git blame` only reveals the last introduced changes to each line, not who or when the lines  
were *first* introduced into the codebase. This can be rather annoying if the last change  
was for example an indentation change.  
Use `git log -S` to find the commits that first introduced a specific line of code.

### $ `git branch [new_branch]`  
Create the branch 'new_branch'.

* $ `git branch -a`  
Show all branches.

* $ `git branch -u origin/[remote-branch]`  
 = $ `git branch --set-upstream-to=origin/[remote-branch]`  
This sets the default remote branch for the current local branch.  
Any future git pull command (with the current local branch checked-out),
will attempt to bring in commits from the 'remote-branch' into the current local branch.
One way to avoid having to explicitly do `--set-upstream-to` is to use the shorthand flag
`-u` along with the very first `git push` as follows:  
$ `git push -u origin local-branch`  
which sets the upstream association for any future push/pull attempts automatically.  

### $ `git checkout cffd76070aaebf82e4b5eb330fe9a2df944c1b81`  
Checkout commit cffd76070aaebf82e4b5eb330fe9a2df944c1b81.

* $ `git checkout master (--force)`  
Move back to the master/head commit.  
--force: When you've made changes that aren't committed, git won't let you checkout another branch.  
The "--force" flag forces git to checkout anyway, which will result in losing the changes.

* $ `git checkout -b test_branch (cffd76070)`  
= Shorthand for:  
$ `git branch test_branch (cffd76070)`  
$ `git checkout test_branch (cffd76070)`  
(cffd76070): Optionally specify a commit hash to base the branch on.
When not specified, it is based on the currently checked out commit
(current position of head) So when you're in detached head state
(= after checkout of commit hash instead of branch), you can simply
run 'git checkout -b test_branch' to turn that commit into a real branch.
Afterwards, simply:  
$ `git checkout master`  
$ `git branch -d test-branch`  
to checkout master, and delete the branch (locally) if you don't need it anymore.  
To also delete the branch remotely (on Github):  
$ `git push origin --delete test_branch`  

### $ `git cherry-pick (-x) <HASH>`  
Cherry picking in Git means to choose a commit from one branch and apply it onto another.  
This is in contrast with other ways such as [merge](#-git-merge-other_branch)
and [rebase](#-git-rebase-other_branch), which normally apply many commits onto another branch.  
-x: This generates a standard commit message with mention where it was cherry-picked from.  
    This is good practice when cherry-picking from a public branch.  

*  $ `git cherry-pick -x 0379e861ca82^..bb2197f0845d`  
   Cherry-pick a range of commits to include in the current branch.  
   **Note:**  
    - Both hashes should be from the same branch, with the oldest specified first.
    - Include `^` at the end of the first hash if that commit itself should be included;  
    without it, the range will start at the commit following the specified one:  
    `0379e861ca82^..bb2197f0845d` = [0379e861ca82, bb2197f0845d]  
    `0379e861ca82..bb2197f0845d `&nbsp;= ]0379e861ca82, bb2197f0845d]

### $ `git commit (-a) -m "Description of changes"`  
Commit all staged files permanently to version history.  
 
* $ `git commit -am "Description of changes"`  
-a/--all: Automatically stage/add all tracked files that were modified; this means you don't
have to manually stage/'git add' all files that are modified.  

* $ `git commit --amend`  
Rewrite the most recent commit message and/or commit content (if they have not yet been pushed online).  
If you want to also edit the commit's content, you need to 'git add' the edited files before amending,  
so you may or may not have to 'git stash' code that shouldn't be included.  
(In Git, the text of the commit message is part of the commit.  
Changing the commit message will change the commit ID, i.e. the SHA1 checksum that names the commit.  
Effectively, you are creating a new commit that replaces the old one, but keeps its date.)

### $ `git diff`  
Shows all modifications that are NOT yet staged.  
(= difference between working directory and staging area)  
Note:  
`git diff` output is shown in the less pager (q to exit).  
To search in the less pager, use `/` followed by the search term and press enter.  
Use `n` and `N` to move forwards/backwards in the search results.  

* $ `git diff --staged`  
Shows all modifications that are staged.  
(= difference between staging area and last commit)

* $ `git diff cffd76070aaebf82e4b5eb330fe9 1e14e1134d7eabf136d6210a6d87a99`  
or: `git diff cffd76070aaebf82e4b5eb330fe9 1e14e`  
or: `git diff cffd 1e14`  
=   `git diff [old] [new]`!  
(you may abbreviate commit hashes; the first 4 or more chars suffice)  
Compare 2 specific commits (get commit hash from 'git log' command)

* To permanently exclude a specific file in your repository from the diff command:  
$ `git config diff.nodiff.command /bin/true`  
$ `cat >.git/info/attributes`  
\> `package-lock.json    diff=nodiff`  
From now onwards, `package-lock.json` will be excluded from any diff.  
Use `--global` in the first command to accomplish this for all your repos.

### $ `git log`  
Returns a log of all git commits in the less pager (q to exit).  
To search in the less pager, use `/` followed by the search term and press enter.  
Use `n` and `N` to move forwards/backwards in the search results.  
Alternatively, you can also specify a commit hash:  
$ `git log 0a6bb439280d77458f`  
This will show the specified commit hash at the top with its parent commits below it.
In other words, its child commits (commits made afterwards) are ommitted.  
To print the git log output to the terminal instead of viewing it in less, use:  
$ `git log | cat`  

* $ `git log -L 3,4:[path/to/file]`  
This command will present you with a log of all commits that changed line **4** in the specified file.  

* $ `git log -p -- [path/to/file]`  
This command allows you to efficiently view the change history of a single file.  
It displays a log of all commits that changed the specific file, along with their diffs.

* $ `git log -S 'search-string'`  
This gives you the commits in which the 'search-string' was introduced.  
Be aware that this command will return *every commit* in which this 'search-string'  
was added to *any file*.  
To find when a specific line of code was introduced in a specific file, use:  
$ `git log -S ['Full-Line-of-Code'] [path/to/file]`  
This gives you the commit(s) in which this line of code was introduced.

* $ `git log --format=fuller`  
Shows the difference between AuthorDate and CommitDate. They are usually the same,
but can differ for example after a 'git rebase'. The CommitDate is taken into account
when creating the commit hash, so a 'git rebase' without changes still modifies the hash.  
Other 'git log'-formats: oneline, short, medium, full, fuller, email, raw, ...

* $ `git log --name-status`  
Adds the names and status of the changed files of each commit to the log.

* $ `git log --stat --oneline --graph master other_branch`  
`--stat`: shows additional data like the files that were changed, and insertions/deletions.  
`--oneline`: show only one line per commit (see other `--format` types above at `git log --format`).  
`--graph master other_branch`: show a graph of how the commits in both branches relate to each other.

* $ `git log --reverse`  
The first entry in the output will be the first commit, instead of the last one as usual.

### $ `git ls-files`  
Lists all the files that exist in the latest commit on the current branch.

### $ `git merge other_branch`  
Merge `other_branch` into the currently checked out branch.  
To merge `other_branch` into master, simply check it out first:  
$ `git checkout master`  
$ `git merge other_branch`  
The key is to remember that `git merge` always merges all the specified branches  
**into the currently checked out branch**, creating a merge commit for that branch.

* $ `git merge --abort`  
Restore your files to their state before you started the merge.

### $ `git mv old_filename new_filename`  
Rename a tracked file.

### $ `git push REMOTENAME BRANCHNAME`  
Pushes the specified branch to the specified remote.

* git push --set-upstream origin --all  
= git push -u origin --all  
Pushes all branches to the origin remote, and sets origin as 'upstream' for all of them.  
This means on next push you don't need to specify neither your branch, nor  
your remote; simply run 'git push'.

### $ `git pull origin master`  
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

### $ `git rebase other_branch`  
Rebase the **current branch** on the specified **other_branch**.  
This means the current branch's new commits will be reapplied on top of `other_branch`'s new commits;  
only the current branch changes, while `other_branch` remains unchanged.  
Similar to [git merge](#-git-merge-other_branch), `git rebase` integrates changes from one branch into another.  
The big difference is that **merging preserves history whereas rebasing (potentially) rewrites it:**  
* **Merge feature_branch into master**:
  ```bash
  git checkout master
  git merge feature_branch
  ```
  - If there are no new commits in master, the merge is fast-forwarded, meaning no new commit is generated.
  - If new commits are present in master, a merge commit will be generated, but no commit hashes will be changed.
  - Master changes, `feature_branch` doesn't.
  
  **=>** This is what you should do when the feature is **finished**, and its ready to reintegrate with the master branch.
  
* **Rebase feature_branch on master**:
  ```bash
  git checkout feature_branch
  git rebase master
  ```
  - If there are no new commits in master, the rebase will have no effect whatsoever.
  - If new commits are present in master, the commits from feature_branch will be reapplied on top of them,
    rewriting the feature_branch commit hashes.
  - `feature_branch` changes, master doesn't.
  
  **=>** This is what you should do if the feature is not finished, but relevant changes have happened to master:  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by rebasing you can simply continue working on the feature on top of the new master changes.

The easiest way to undo a rebase is to find the commit hash of the branch as it was before the rebase started  
and [reset](#-git-reset---hard) to it. Use `git log` or `git reflog` to find it.

* $ `git rebase -i <HASH>`  
-i, --interactive: Interactive rebasing can rewrite git history; unlike
[git commit --amend](#-git-commit--a--m-description-of-changes)
it also allows modifying commit messages further back than the last one.  
**Examples:**  
$ `git rebase -i 'Commit-Hash-You-Want-To-Change'^`  
Note the `^` is necessary to refer to the parent of that commit; otherwise you'll be off-by-one!  
$ `git rebase -i HEAD~3`  
Change the commit messages or commit content for the last 3 commits.  
This command will present you with your default editor;
change 'pick' to 'reword' for the commit message(s) you want to change, then save and close.
A new editor window will appear for each commit message you wish to change.  
If you also want to change the commit content, change 'pick' to 'edit', then save and close.
Back in your shell, you'll notice you're no longer on 'master', but on the specific commit
hash you chose to modify; simply change the code you want, 'git add' the changes, and
[git commit --amend](#-git-commit--a--m-description-of-changes)
the commit. Enter 'git rebase --continue' to finish up the rebase.
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
For more information, see
["Recovering from upstream rebase"](https://git-scm.com/docs/git-rebase#_recovering_from_upstream_rebase)
in the Git manual.

### $ `git reflog`  
Show the *reference logs*. The *reflogs* record when the tips of branches are updated;  
this means they contain all commits that are/were created in your local repository.  
This is very useful **to restore commits** you lost after a reset; simply
[checkout](#-git-checkout-cffd76070aaebf82e4b5eb330fe9a2df944c1b81)
or [cherry-pick](#-git-cherry-pick--x-hash-) the removed commit by its hash.

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

### $ `git reset (--hard)`  
Unstages all staged files.  
--hard: Also resets the working directory, so any uncommitted changes will be lost!

* $ `git reset main.go`  
Unstages main.go, but preserves its contents.

* $ `git reset 6f16fb26b3294 src/app/app.js`  
Reset a specific file (app.js) to the state of a previous commit.

* $ `git reset HEAD~ (--hard)`  
Undo the latest commit, the staged/tracked files will no longer be staged/tracked.  
(HEAD is a pointer to the most recent git commit in a specific branch;
detached head means the head does not point to the most recent commit.
This happens when you move the head back in time by checking out a
specific commit hash)  
If the commit was already pushed to your remote, you will have to push the newly
deleted version again with the --force flag to delete it from the remote:  
$ `git push origin master --force`

* $ `git reset cffd76070aaebf82e4b (--hard)`  
Undo all commits that came after cffd76070aaebf82e4b!  
--hard: will also get rid of everything you've done since then;  
all unpublished commits will be lost from your hard disk.  

### $ `git revert cffd76070aaebf82e4b`  
Undo only the changes that happened in this specific commit.

### $ `git rev-list --count HEAD`  
Count the commits for the branch you are on.

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
Apply an older stash; get its id from `git stash list`.  
stash@{0} = the most recent stash  
stash@{1} = the stash before the most recent one  
Etc.

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
If you want to update your submodules to their most recent upstream versions, use:  
$ `git submodule update --remote --merge`  

### Create a meta-repo that holds scripts from various other repos
### A. Use case:
Many applications allow user scripting. Usually the user's scripts are placed inside
a specific directory that guarantees they can be accessed by the program.
Since it is not possible to mix different git repos in one directory, manually updating
them can be a chore. Even more so if the scripts are maintained separately/elsewhere.  
This approach gives us the best of both worlds: we keep git's version control,
**and** we keep all the scripts neatly in a *single directory*!  
This means updating all of them in one go is as simple as running
`git submodule update --remote --merge`.

### B. How to:
* We create a `meta-scripts` directory as meta-repo with a `git` subdirectory inside.
  This `git` subdirectory will hold the full repos from which we can then handpick
  the relevant scripts, and link them to the main `meta-scripts` directory:
  ```
  mkdir meta-scripts meta-scripts/git
  cd meta-scripts
  git init
  git submodule add https://github.com/user1/sub-project1.git git/sub-project1
  git submodule add https://github.com/user2/sub-project2.git git/sub-project2
  git commit -m 'Initial commit: add submodules'
  ln (-s) git/sub-project1/script1.lua
  ln (-s) git/sub-project2/script2.py
  git add script1.lua script2.py
  git commit -m 'Link scripts to main directory'
  git remote add origin https://github.com/my-user/meta-scripts.git
  git push -u origin master
  ```
  **Note on the links**:
    - If you use hardlinks (`ln` without the `-s` flag) the advantage is that
      the file contents of the links will be visible to git.
      The disadvantage is that git does not preserve the linking.
      When you clone the repo, the link between the files will no longer be present;
      both files will still be there, but without any relation between them.
    - In contrast, symbolic links (`ln -s`) do preserve their linking in git.
      However, the file contents of the links will not be visible to git;
      when you look at the symbolically linked file through git/github you will
      only see the path to the linked file (but the link will work on the filesystem).

  Regardlessly, symbolic links are more convenient since they won't break.

* Then you can pull the meta-scripts repo wherever you need the scripts:
  ```
  cd /place/where/scripts/are/needed
  git clone https://github.com/my-user/meta-scripts.git .
  git submodule init
  git submodule update
  ```

* To update all scripts/submodules in one go:
  ```
  git submodule update --remote --merge
  ```
