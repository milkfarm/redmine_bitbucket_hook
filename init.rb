require 'redmine'

Redmine::Plugin.register :redmine_bitbucket_hook do
  name 'Redmine Bitbucket Hook plugin'
  author 'milkfarm productions'
  description 'This plugin allows your Redmine installation to receive Bitbucket post-receive notifications'
  url 'https://github.com/milkfarm/redmine_bitbucket_hook'
  author_url 'http://milkfarmproductions.com'
  version RedmineBitbucketHook::VERSION
end
