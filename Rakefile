require 'pathname'
require 'shellwords'
require 'bundler/setup'
require 'highline/import'

def itamae_command(hostname, remote_user, dryrun: true)
  %w[itamae ssh].tap do |cmd|
    cmd.push('--dry-run') if dryrun
    cmd.push('-u', remote_user) if remote_user
    cmd.push('-h', hostname)
    cmd.push('itamae/site.rb', "itamae/hosts/#{hostname}/default.rb")
  end
end

Pathname.glob('itamae/hosts/*').select(&:directory?).each do |hostdir|
  hostname = hostdir.basename

  desc "Cook on #{hostname}"
  namespace :apply do
    task hostname => "dryrun:#{hostname}" do
      fail 'Aborted.' unless agree('Are you sure to proceed?')
      Rake::Task["exec:#{hostname}"].invoke
    end
  end

  desc "Cook on #{hostname} with no dry-run"
  namespace :exec do
    task hostname do
      sh itamae_command(hostname, ENV['REMOTE_USER'], dryrun: false).shelljoin
    end
  end

  desc "Dry-run on #{hostname}"
  namespace :dryrun do
    task hostname do
      sh itamae_command(hostname, ENV['REMOTE_USER'], dryrun: true).shelljoin
    end
  end
end
