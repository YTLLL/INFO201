# session.sh
# Use this file to track the commands that you execute in your terminal
# You don't need to *run* this file, just list out the appropriate command after each prompt

# Print your working directory

V_YTLEI-MB0:a1-YTLLL leiryan$ pwd
/Users/leiryan/Documents/INFO201/a1-YTLLL

# Change your directory to a folder in which you do work for this class
# You may use "~" shortcut (mac), or specify the full path

V_YTLEI-MB0:a1-YTLLL leiryan$ cd ~
V_YTLEI-MB0:~ leiryan$ cd Documents/INFO201/
V_YTLEI-MB0:INFO201 leiryan$ 

# Clone your (private) assignment repository from GitHub to your machine

V_YTLEI-MB0:INFO201 leiryan$ git clone https://github.com/info201b-w19/a1-YTLLL.git
Cloning into 'a1-YTLLL'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 13 (delta 3), reused 13 (delta 3), pack-reused 0
Unpacking objects: 100% (13/13), done.

# Change your directory to inside of your "a1-news-USERNAME" folder

//When I accepted the assignment, it said "@mkfreeman has invited you to collaborate on the info201b-w19/a1-YTLLL repository"; which the 'news' is missing on the name

V_YTLEI-MB0:a1-YTLLL leiryan$ cd ~
V_YTLEI-MB0:~ leiryan$ cd Documents/INFO201/a1-YTLLL/
V_YTLEI-MB0:a1-YTLLL leiryan$

# Make a new folder called "imgs" - you'll download an image into this folder

V_YTLEI-MB0:a1-YTLLL leiryan$ mkdir imgs
V_YTLEI-MB0:a1-YTLLL leiryan$ ls
LICENSE		README.md	imgs		session.sh

# At appropriate checkpoints, you'll need to do the following version control steps
# (feel free to only list these steps once)

# Add all of your changes that you've made to git

V_YTLEI-MB0:a1-YTLLL leiryan$ git add .
V_YTLEI-MB0:a1-YTLLL leiryan$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   README.md
	new file:   imgs/protest.jpg
	modified:   session.sh


# Make a commit, including a *descriptive message*

V_YTLEI-MB0:a1-YTLLL leiryan$ git commit -m "created simple markdown page for a current event; record command lines; created new folder with image"
[master 1d477a0] created simple markdown page for a current event; record command lines; created new folder with image
 3 files changed, 37 insertions(+), 5 deletions(-)
 rewrite README.md (99%)
 create mode 100644 imgs/protest.jpg

# Push your change up to GitHub

V_YTLEI-MB0:a1-YTLLL leiryan$ git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 32.41 KiB | 10.80 MiB/s, done.
Total 6 (delta 0), reused 0 (delta 0)
To https://github.com/info201b-w19/a1-YTLLL.git
   d75b79d..1d477a0  master -> master
