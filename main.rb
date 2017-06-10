# coding: utf-8
require 'octokit'
require 'dotenv'
require 'yaml'

Dotenv.load

exit if ARGV.empty?

yml = YAML.load_file(ARGV[0])

client = Octokit::Client.new(
  login:    ENV['GITHUB_USER'],
  password: ENV['GITHUB_TOKEN']
)

repository = ENV['TEST_REPO']  || yml['repository']
eventname  = ENV['EVENT_NAME'] || yml['event']
yml['tasks'].each do |t|
  p client.create_issue(
    repository,
    "#{eventname} - #{t['title']}",
    t['body']
  )
end
