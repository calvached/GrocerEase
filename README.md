#How to start this app

1. Clone the repo

Assume you have rails and a postgres server installed. 

On the command line, type
     
    $bundle
    $rake db:create
    $rake db:migrate
    $rake db:seed
    $rails s

The server will start on localhost:3000

#Adding a card to Trello

The title is one of two formats:

    Feature: description of feature
    Bugfix: description of bugfix

Each issue must be a user story.  We use the following user story format:

    "As a <role>, I want <goal/desire> so that <benefit>"

For example,

    "As a developer, I want there to be a how to contribute section of the Readme, so that I know how to contribute to the project."


Each issue must also contain a description of what 'done' means for that feature or bugfix.  For example,

    "the 'how to contribute' section is complete when
       1. there is a specific outline of how one can claim units of work
       2. A descript of the preferred format for letting the other contributers know when you have claimed something.

Once you are done writing up the issue, feel free to claim it.


##If you have forked this repo and want to make a contribution:

###submit a pull request.  See the format for 'issues.'  Make sure your pull request follows that format.




# Git: Working with Teams

## A friendly reminder to make your teammates like you:
   1. NEVER merge your own pull requests.  Get a review.
   2. Commit early and often.
   3. Don't push to master.

Git is a distributed version control system. Every Git working directory is a full-fledged repository with complete history and full version tracking capabilities, not dependent on network access or a central server.

## Bash Make git workflow easy


Note: the first script is out of date since we switched from a fetch/rebase workflow to a pull/merge workflow.  the second script, the one specifically for diana's DevBootcamp workstation reflects the new workflow. So copy the second script, not the first. 

Copy this script into your bash profile.  

Every time you commit, we want you to pull the latest master branch.  This means that we won't have giant merge conflicts because you will be making sure every commit still works with the master branch.

```bash
git()
{
  if [ $# -gt 0 ] && [ "$1" == "status" ] ; then
     shift
     /usr/bin/git status  "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git diff  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "diff" ] && [ "$2" == "--cached" ] ; then
     shift
     /usr/bin/git diff --cached "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git commit -v  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "diff" ] ; then
     shift
     /usr/bin/git diff  "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git add -p -u .  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "add" ] ; then
     shift
     /usr/bin/git add -p -u .  "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git diff --cached  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "commit" ] && [ "$2" == "-v" ]; then
     shift
     /usr/bin/git commit -v "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git checkout master  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "checkout" ] && [ "$2" == "master" ]; then
     shift
     /usr/bin/git checkout "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git fetch origin  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "fetch" ] && [ "$2" == "origin" ]; then
     shift
     /usr/bin/git fetch "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git rebase origin/master  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "rebase" ] && [ "$2" == "origin/master" ]; then
     shift
     /usr/bin/git rebase "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git checkout MY-BRANCH-NAME  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "checkout" ]; then
     shift
     /usr/bin/git checkout "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git rebase master   \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "rebase" ] && [ "$2" == "master" ]; then
     shift
     /usr/bin/git rebase master
     echo -e "\n****NEXT COMMAND***\n\n      You are ready to keep working!   \n\n*********"
  else
     /usr/bin/git "$@"
  fi
}
```
For diana's specific machine

```bash
git()
{
  if [ $# -gt 0 ] && [ "$1" == "status" ] ; then
     shift
     /usr/bin/git status  "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git add -p -u .  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "add" ] ; then
     shift
     /usr/bin/git add "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git commit -v  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "commit" ] && [ "$2" == "-v" ]; then
     shift
     /usr/bin/git commit -v "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git checkout master  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "checkout" ] && [ "$2" == "master" ]; then
     shift
     /usr/bin/git checkout "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git pull origin master   \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "pull" ] && [ "$2" == "origin" ]; then
     shift
     /usr/bin/git pull "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git checkout MY-BRANCH-NAME  \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "checkout" ]; then
     shift
     /usr/bin/git checkout "$@"
     echo -e "\n****NEXT COMMAND***\n\n      git merge master   \n\n*********"
  elif [ $# -gt 0 ] && [ "$1" == "merge" ] && [ "$2" == "master" ]; then
     shift
     /usr/bin/git merge master
     echo -e "\n****NEXT COMMAND***\n\n      You are ready to keep working!   \n\n*********"
  else
     /usr/bin/git "$@"
  fi
}
```

## Getting Started

### Creating a repo on your machine

    $ git init

### Creating a .gitignore

By default git will try to track every file that exists in the working copy. Sometimes you'll have files that you don't want git to track, e.g. log files, OS files, etc. By creating a .gitignore file you can tell git that it should happily ignore these types of files. For more info: https://help.github.com/articles/ignoring-files

### Creating a README

A README file helps communicate the intent of the project to people who later discover the project and want a higher level view of what it's about.

## A Typical Development Workflow

One of the best features of git is that it allows you to forget that you are using source control while you are focused on development. Once you have some work to be put into source control it provides powerful tools to help you create a nice, curated set of commits that reflect the work you've done. The following is a typical workflow for using git:

    git status
    git diff
    git add -u -p .
    git diff --cached
    git commit -v

Let's walk through this step by step.

1. `git status` allows you to see which files you've modified.
2. `git diff` allows you to view a list of the modifications made to each file. Review the diff to make sure you haven't made any unintended changes.
3. `git add -u -p .` allows you to pick which modifications you would like to add to the commit. You can omit the `-p` if you want to commit all the files that were modified in the `git status` command. Similarly, you can omit the `-u` if you have only made additive changes (ie. you didn't delete a file from the working directory).
4. `git diff --cached` allows you to see the modifications that are currently waiting to be committed (ie. the contents of the git staging area).
5. `git commit -v` allows you to specify a commit message and review the modifications that will be part of the commit.

## Branches

One of the other powerful features of git is it's branching mechanism. A branch in git is used to develop code independent from master, which is also a branch. The simplicity and ease of switching between branches in git is what makes it so incredibly powerful. As a result most developers choose to write most of their work outside of the master branch. This enables them to quickly switch tasks and work on different features in the same respository without having to juggle which commits make it into the master branch.

### Creating a new branch

    git checkout -b my-feature

This will create a new branch, named `my-feature`, starting from the current branch. It will also change your current branch to the new branch. You usually want to start branches from the master branch.

### Changing to an existing branch

    git checkout my-other-feature

This will change your working copy to reflect the contents of the `my-other-feature` branch. You should always change branches when your working copy is clean, ie. there are no modifications to files in the repository. You can verify this by running `git status`, which should report no outstanding changes.

## Remotes

We said earlier that git is a *distributed* version control system. At the heart of this is the concept of remote repositories. A remote repository is a git repository that exists on another machine. When we're working on teams we are able to share code among our various development repositories by syncing with a shared remote repository. Github is a popular service that offers hosting for git repositories, and also adds a number of really nice features for working on software as a group. Here's how to get started with using Github as a remote for your existing local repository:

### Github repository set up

Create a new repository on Github (https://help.github.com/articles/create-a-repo). Github will give you a url, so that you can access the the repository on Github from other repositories. Then do the following in your local repository:

    git remote add origin https://url-from-github
    git push -u origin master

1. `$ git remote add origin https://url-from-github` this tells your local git repository that there is a remote repository that we'll call `origin` and lives at `https://url-from-github`.
2. `$ git push -u origin master` this command will push a copy of our `master` branch to the remote named `origin` (ie. Github in our case), and the `-u` tells git that our master branch should be setup to track the master branch on origin. You can omit the `-u` on future pushes because our master branch will still be tracking origin/master.

### Set up a local repository from an existing Github repository

    git clone https://url-from-github project-name

This will download a copy of the repository that lives at `https://url-from-github` and put it into a directory called `project-name` in your current directory. You can omit the `project-name` parameter if you want to use the same name as the remote repository in your local repository.

### Push a branch to a remote

    git push origin -u <local-branch-name>:<remote-branch-name>

This is the full push command. It pushes the local-branch-name to origin, renaming it to remote-branch-name. It also sets up our local branch to track the remote branch. A shorter form is:

    git push origin <local-branch-name>

Without specifying a remote branch name, git assumes that it should name the remote branch the same name as your local branch. If you've previously set up tracking on this branch, git will push to the remote branch that local branch is tracking.

## Collaboration

In the course of collaborating with other developers, you'll likely want to get the changes that they've made into your own local repository. This is where most of the headaches of working with git (and other developers) come from.

So, let's say that a teammate has pushed some changes that she made into the `master` branch of our remote repository. We'd like to get the changes into our local repository and then use them in the branch we're working in (let's call it `my-feature`).

Note: we switched to a pull/merge workflow instead of a fetch/rebase workflow due to the fact tht rebase kept deleting our authentication key file for the nutritionx api.  We are sacrificing our clean git history for the ability to not have to copy the darned apikeys file from a seperate file into our project every time we rebase. 

    $ git checkout master
    $ git pull origin master
    $ git checkout mybranch
    $ git merge master
    


1. `$ git checkout master` switch into the local master branch
2. `$ git pull origin master` will grab all of the changes that have been made to the remote repository and merge them into the master branch of your local repository.  
3. `$ git checkout my-feature` now switch back to our feature branch
4. `$ git merge master` and merge any changes in the master branch into our feature branch.
 

Issue a pull request (https://help.github.com/articles/creating-a-pull-request) and
solicit feedback from your team. Once approved, merge the pull request
(https://help.github.com/articles/merging-a-pull-request). This will merge your
feature with master on the origin, which puts your master out of date.
Update your copy of master
$ git fetch origin$ git rebase origin/master

## Keeping git clean - Removing dead branches

In the process of working in branches and merging pull requests, your local and remote repositories will build up branches that have already been merged, and are no longer needed. A dirty remote or local repository will slow you and your team down, as your repository is at the heart of communication about the state of the code (ie. what is in progress).

Removing branches locally:

    $ git branch -d my-feature

Sometimes you'll need to use `-D` instead of `-d`. `-D` is just a more dangerous form of the same method.

Removing branches from remote repositories:

    $ git push origin :my_feature

You'll notice that this looks a lot like the normal push command:

    git push origin local-branch-name:remote-branch-name:w

That's because it _is_ the same command. In this case we just specify an "empty" branch for the local branch. This has the effect of pushing an empty branch to the repote repository, thus overwriting remote branch contents with an empty branch.

Removing dead references from your local repository:

    $ git remote prune origin

When you fetch/pull from a remote, your local repository will download references to all the branches the remote knows about. When a branch is removed from the remote, your local repository will still be holding onto a reference, even though the branch is now dead and gone. It's a good idea to periodically prune your local references using this command. This will remove all references that no longer exist on the given remote.
