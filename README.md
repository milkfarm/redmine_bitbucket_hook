# Redmine BitBucket Hook

This plugin allows you to update your local Git repository in Redmine when changes have been pushed to BitBucket.

## Description

[Redmine](http://redmine.org) has supported Git repositories for a long time, allowing you to browse your code and view your changesets directly in Redmine. For this purpose, Redmine relies on a local clone of a given Git repository.

If your shared repository is on a remote machine--for example on BitBucket--this unfortunately means a bit of legwork to keep the local, Redmine-accessible repository up-to-date. The common approach is to set up a cron job that pulls changes at regular intervals then similarly updates Redmine.

That approach works fine, but is a bit heavy-handed and cumbersome. The Redmine BitBucket Hook plugin allows BitBucket to notify your Redmine installation when changes have been pushed to a repository, triggering an update of your local repository and Redmine data only when necessary.

## Getting started

### 1. Install the plugin

1. Add the gem to the `Gemfile.local` file within your Redmine installation (`[/PATH/TO/REDMINE]`):
   `gem 'redmine_bitbucket_hook', git: 'git://github.com/milkfarm/redmine_bitbucket_hook.git'`
2. Install the gem:
   `bundle`
3. Restart your Redmine application:
   `touch tmp/restart.txt`

### 2. Clone the repository on the Redmine server

Before adding a repository to a project, you should `clone` the repository on the Redmine server.

1. `cd [/PATH/TO/REDMINE]`
2. `mkdir [REPOSITORIES_DIR]`
3. `cd [REPOSITORIES_DIR]`
4. `git clone --mirror git@bitbucket.org:[BITBUCKET_USER]/[REPOSITORY_IDENTIFIER].git`

### 3. Add the repository to a Redmine project

Associating a Git repository to a project is explained in detail on the Redmine site under the heading: [Keeping Your Git Repository in Sync](http://www.redmine.org/wiki/redmine/HowTo_keep_in_sync_your_git_repository_for_redmine). Note: Redmine BitBucket Hook obviates the need to setup a cron job.

1. Click "New repository" in the Project Repositories interface of Redmine (Project > Settings > Repositories > New repository)
2. Populate the form with the following information, then click "Create".
  * SCM = `Git`
  * Identifier = `[REPOSITORY_IDENTIFIER]`
  * Path to repository = `[/PATH/TO/REDMINE/REPOSITORIES_DIR/REPOSITORY_IDENTIFIER.git]`

### 4. Create a webhook to connect BitBucket to Redmine

1. Go to the Settings interface on BitBucket for the given repository.
2. Click "Add webhook" in the "Webhooks" section of the Settings interface.
3. Populate the form with the following information, then click "Save".
  * Title = `Redmine` (or as you wish)
  * URL = `[REDMINE_URL]/bitbucket_hook?project_id=[REDMINE_PROJECT_IDENTIFIER]&repository_id=[REDMINE_REPOSITORY_IDENTIFIER]` (eg, `http://redmine.example.com/bitbucket_hook?project_id=foo&repository_id=bar`)
  * Status = `Active`
  * Triggers = `Repository push`

BitBucket will now send an HTTP POST to the Redmine BitBucket Hook plugin whenever changes are pushed to BitBucket. The plugin then pulls the changes to the local repository and updates the Redmine database.

## Assumptions

* Redmine 3.3.x running on a *nix-like system.
* Git 1.8 or higher available on the command line.

## Troubleshooting

### Check your logfile

If you run into issues, your Redmine logfile (eg, `log/production.log`) might have some valuable information. Two things to check for:

1. Do POST requests to `/bitbucket_hook` show up in the logfile at all? If so, what's the resulting status code?
2. If the git command used to pull in changes fails for whatever reason, there should also be some details about the failure in the logfile.

Your webserver logs may contain some additional clues.

### Permissions problems

As for permissions, whatever user Redmine is running as needs permissions to do the following things:

* Read from the remote repository on BitBucket
* Read and write to the local repository on the Redmine server

What user you are running Redmine as depends on your system and how you've setup your Redmine installation.

#### BitBucket

This means you need to add its SSH keys on BitBucket. If the user doesn't already have an SSH key, generate one and add the public SSH key as a Deployment Key for the repository on BitBucket (or as one of your own keys, if you prefer that).

#### Local repository

The user running Redmine needs permissions to read and write to the local repository on the server.

## What happens

The interactions between the different parts of the process is outlined in the following sequence diagram:

![sequence](https://cloud.githubusercontent.com/assets/6480/3311503/3a789390-f6c5-11e3-804d-d5ca2562799f.png)

(Diagram made with [js-sequence-diagrams](http://bramp.github.io/js-sequence-diagrams/)).

## License

Copyright (c) 2009-2014 Jakob Skjerning

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
