# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "nucleon"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Webb"]
  s.date = "2014-07-08"
  s.description = "\nA framework that provides a simple foundation for building Ruby applications that are:\n\n* Highly configurable (with both distributed and persistent configurations)\n* Extremely pluggable and extendable\n* Easily parallel\n\nNote: This framework is still very early in development!\n"
  s.email = "adrian.webb@coralnexus.com"
  s.executables = ["nucleon"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitmodules",
    "ARCHITECTURE.rdoc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "TODO.rdoc",
    "VERSION",
    "bin/nucleon",
    "lib/core/codes.rb",
    "lib/core/config.rb",
    "lib/core/config/collection.rb",
    "lib/core/config/options.rb",
    "lib/core/core.rb",
    "lib/core/environment.rb",
    "lib/core/errors.rb",
    "lib/core/facade.rb",
    "lib/core/gems.rb",
    "lib/core/manager.rb",
    "lib/core/mixin/action/commit.rb",
    "lib/core/mixin/action/project.rb",
    "lib/core/mixin/action/push.rb",
    "lib/core/mixin/action/registration.rb",
    "lib/core/mixin/colors.rb",
    "lib/core/mixin/config/collection.rb",
    "lib/core/mixin/config/options.rb",
    "lib/core/mixin/macro/object_interface.rb",
    "lib/core/mixin/macro/plugin_interface.rb",
    "lib/core/mixin/settings.rb",
    "lib/core/mixin/sub_config.rb",
    "lib/core/mod/hash.rb",
    "lib/core/plugin/action.rb",
    "lib/core/plugin/base.rb",
    "lib/core/plugin/command.rb",
    "lib/core/plugin/event.rb",
    "lib/core/plugin/extension.rb",
    "lib/core/plugin/project.rb",
    "lib/core/plugin/template.rb",
    "lib/core/plugin/translator.rb",
    "lib/core/util/cache.rb",
    "lib/core/util/cli.rb",
    "lib/core/util/console.rb",
    "lib/core/util/data.rb",
    "lib/core/util/disk.rb",
    "lib/core/util/git.rb",
    "lib/core/util/liquid.rb",
    "lib/core/util/logger.rb",
    "lib/core/util/package.rb",
    "lib/core/util/shell.rb",
    "lib/core/util/ssh.rb",
    "lib/nucleon.rb",
    "lib/nucleon/action/extract.rb",
    "lib/nucleon/action/project/add.rb",
    "lib/nucleon/action/project/create.rb",
    "lib/nucleon/action/project/remove.rb",
    "lib/nucleon/action/project/save.rb",
    "lib/nucleon/action/project/update.rb",
    "lib/nucleon/command/bash.rb",
    "lib/nucleon/event/regex.rb",
    "lib/nucleon/project/git.rb",
    "lib/nucleon/project/github.rb",
    "lib/nucleon/template/JSON.rb",
    "lib/nucleon/template/YAML.rb",
    "lib/nucleon/template/wrapper.rb",
    "lib/nucleon/translator/JSON.rb",
    "lib/nucleon/translator/YAML.rb",
    "lib/nucleon_base.rb",
    "locales/en.yml",
    "nucleon.gemspec",
    "rdoc/site/0.1.19/ARCHITECTURE_rdoc.html",
    "rdoc/site/0.1.19/Hash.html",
    "rdoc/site/0.1.19/Kernel.html",
    "rdoc/site/0.1.19/Nucleon.html",
    "rdoc/site/0.1.19/Nucleon/Action.html",
    "rdoc/site/0.1.19/Nucleon/Action/Add.html",
    "rdoc/site/0.1.19/Nucleon/Action/Create.html",
    "rdoc/site/0.1.19/Nucleon/Action/Extract.html",
    "rdoc/site/0.1.19/Nucleon/Action/Remove.html",
    "rdoc/site/0.1.19/Nucleon/Action/Save.html",
    "rdoc/site/0.1.19/Nucleon/Action/Update.html",
    "rdoc/site/0.1.19/Nucleon/Codes.html",
    "rdoc/site/0.1.19/Nucleon/Command.html",
    "rdoc/site/0.1.19/Nucleon/Command/Bash.html",
    "rdoc/site/0.1.19/Nucleon/Config.html",
    "rdoc/site/0.1.19/Nucleon/Config/Collection.html",
    "rdoc/site/0.1.19/Nucleon/Config/Options.html",
    "rdoc/site/0.1.19/Nucleon/Core.html",
    "rdoc/site/0.1.19/Nucleon/Errors.html",
    "rdoc/site/0.1.19/Nucleon/Errors/BatchError.html",
    "rdoc/site/0.1.19/Nucleon/Errors/NucleonError.html",
    "rdoc/site/0.1.19/Nucleon/Errors/SSHUnavailable.html",
    "rdoc/site/0.1.19/Nucleon/Event.html",
    "rdoc/site/0.1.19/Nucleon/Event/Regex.html",
    "rdoc/site/0.1.19/Nucleon/Facade.html",
    "rdoc/site/0.1.19/Nucleon/Gems.html",
    "rdoc/site/0.1.19/Nucleon/Manager.html",
    "rdoc/site/0.1.19/Nucleon/Mixin.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Action.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Action/Commit.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Action/Project.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Action/Push.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Colors.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/ConfigCollection.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/ConfigOptions.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Macro.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Macro/ObjectInterface.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Macro/PluginInterface.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/Settings.html",
    "rdoc/site/0.1.19/Nucleon/Mixin/SubConfig.html",
    "rdoc/site/0.1.19/Nucleon/Parallel.html",
    "rdoc/site/0.1.19/Nucleon/Parallel/ClassMethods.html",
    "rdoc/site/0.1.19/Nucleon/Parallel/InstanceMethods.html",
    "rdoc/site/0.1.19/Nucleon/Plugin.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Action.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Action/Option.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Base.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Command.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Event.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Extension.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Project.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Template.html",
    "rdoc/site/0.1.19/Nucleon/Plugin/Translator.html",
    "rdoc/site/0.1.19/Nucleon/Project.html",
    "rdoc/site/0.1.19/Nucleon/Project/Git.html",
    "rdoc/site/0.1.19/Nucleon/Project/Github.html",
    "rdoc/site/0.1.19/Nucleon/Template.html",
    "rdoc/site/0.1.19/Nucleon/Template/Json.html",
    "rdoc/site/0.1.19/Nucleon/Template/Wrapper.html",
    "rdoc/site/0.1.19/Nucleon/Template/Yaml.html",
    "rdoc/site/0.1.19/Nucleon/Translator.html",
    "rdoc/site/0.1.19/Nucleon/Translator/Json.html",
    "rdoc/site/0.1.19/Nucleon/Translator/Yaml.html",
    "rdoc/site/0.1.19/Nucleon/Util.html",
    "rdoc/site/0.1.19/Nucleon/Util/CLI.html",
    "rdoc/site/0.1.19/Nucleon/Util/CLI/Parser.html",
    "rdoc/site/0.1.19/Nucleon/Util/Cache.html",
    "rdoc/site/0.1.19/Nucleon/Util/Console.html",
    "rdoc/site/0.1.19/Nucleon/Util/Data.html",
    "rdoc/site/0.1.19/Nucleon/Util/Disk.html",
    "rdoc/site/0.1.19/Nucleon/Util/Git.html",
    "rdoc/site/0.1.19/Nucleon/Util/Liquid.html",
    "rdoc/site/0.1.19/Nucleon/Util/Logger.html",
    "rdoc/site/0.1.19/Nucleon/Util/Package.html",
    "rdoc/site/0.1.19/Nucleon/Util/SSH.html",
    "rdoc/site/0.1.19/Nucleon/Util/SSH/Keypair.html",
    "rdoc/site/0.1.19/Nucleon/Util/Shell.html",
    "rdoc/site/0.1.19/Nucleon/Util/Shell/Result.html",
    "rdoc/site/0.1.19/README_rdoc.html",
    "rdoc/site/0.1.19/TODO_rdoc.html",
    "rdoc/site/0.1.19/created.rid",
    "rdoc/site/0.1.19/images/add.png",
    "rdoc/site/0.1.19/images/brick.png",
    "rdoc/site/0.1.19/images/brick_link.png",
    "rdoc/site/0.1.19/images/bug.png",
    "rdoc/site/0.1.19/images/bullet_black.png",
    "rdoc/site/0.1.19/images/bullet_toggle_minus.png",
    "rdoc/site/0.1.19/images/bullet_toggle_plus.png",
    "rdoc/site/0.1.19/images/date.png",
    "rdoc/site/0.1.19/images/delete.png",
    "rdoc/site/0.1.19/images/find.png",
    "rdoc/site/0.1.19/images/loadingAnimation.gif",
    "rdoc/site/0.1.19/images/macFFBgHack.png",
    "rdoc/site/0.1.19/images/package.png",
    "rdoc/site/0.1.19/images/page_green.png",
    "rdoc/site/0.1.19/images/page_white_text.png",
    "rdoc/site/0.1.19/images/page_white_width.png",
    "rdoc/site/0.1.19/images/plugin.png",
    "rdoc/site/0.1.19/images/ruby.png",
    "rdoc/site/0.1.19/images/tag_blue.png",
    "rdoc/site/0.1.19/images/tag_green.png",
    "rdoc/site/0.1.19/images/transparent.png",
    "rdoc/site/0.1.19/images/wrench.png",
    "rdoc/site/0.1.19/images/wrench_orange.png",
    "rdoc/site/0.1.19/images/zoom.png",
    "rdoc/site/0.1.19/index.html",
    "rdoc/site/0.1.19/js/darkfish.js",
    "rdoc/site/0.1.19/js/jquery.js",
    "rdoc/site/0.1.19/js/navigation.js",
    "rdoc/site/0.1.19/js/search.js",
    "rdoc/site/0.1.19/js/search_index.js",
    "rdoc/site/0.1.19/js/searcher.js",
    "rdoc/site/0.1.19/rdoc.css",
    "rdoc/site/0.1.19/table_of_contents.html",
    "rdoc/site/0.2.0/ARCHITECTURE_rdoc.html",
    "rdoc/site/0.2.0/Hash.html",
    "rdoc/site/0.2.0/Kernel.html",
    "rdoc/site/0.2.0/Nucleon.html",
    "rdoc/site/0.2.0/Nucleon/Action.html",
    "rdoc/site/0.2.0/Nucleon/Action/Extract.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project/Add.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project/Create.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project/Remove.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project/Save.html",
    "rdoc/site/0.2.0/Nucleon/Action/Project/Update.html",
    "rdoc/site/0.2.0/Nucleon/Codes.html",
    "rdoc/site/0.2.0/Nucleon/Command.html",
    "rdoc/site/0.2.0/Nucleon/Command/Bash.html",
    "rdoc/site/0.2.0/Nucleon/Config.html",
    "rdoc/site/0.2.0/Nucleon/Config/Collection.html",
    "rdoc/site/0.2.0/Nucleon/Config/Options.html",
    "rdoc/site/0.2.0/Nucleon/Core.html",
    "rdoc/site/0.2.0/Nucleon/Environment.html",
    "rdoc/site/0.2.0/Nucleon/Errors.html",
    "rdoc/site/0.2.0/Nucleon/Errors/BatchError.html",
    "rdoc/site/0.2.0/Nucleon/Errors/NucleonError.html",
    "rdoc/site/0.2.0/Nucleon/Errors/SSHUnavailable.html",
    "rdoc/site/0.2.0/Nucleon/Event.html",
    "rdoc/site/0.2.0/Nucleon/Event/Regex.html",
    "rdoc/site/0.2.0/Nucleon/Facade.html",
    "rdoc/site/0.2.0/Nucleon/Gems.html",
    "rdoc/site/0.2.0/Nucleon/Manager.html",
    "rdoc/site/0.2.0/Nucleon/Mixin.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Action.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Action/Commit.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Action/Project.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Action/Push.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Colors.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/ConfigCollection.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/ConfigOptions.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Macro.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Macro/ObjectInterface.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Macro/PluginInterface.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/Settings.html",
    "rdoc/site/0.2.0/Nucleon/Mixin/SubConfig.html",
    "rdoc/site/0.2.0/Nucleon/Parallel.html",
    "rdoc/site/0.2.0/Nucleon/Parallel/ClassMethods.html",
    "rdoc/site/0.2.0/Nucleon/Parallel/InstanceMethods.html",
    "rdoc/site/0.2.0/Nucleon/Plugin.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Action.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Action/Option.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Base.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Command.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Event.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Extension.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Project.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Template.html",
    "rdoc/site/0.2.0/Nucleon/Plugin/Translator.html",
    "rdoc/site/0.2.0/Nucleon/Project.html",
    "rdoc/site/0.2.0/Nucleon/Project/Git.html",
    "rdoc/site/0.2.0/Nucleon/Project/Github.html",
    "rdoc/site/0.2.0/Nucleon/Template.html",
    "rdoc/site/0.2.0/Nucleon/Template/JSON.html",
    "rdoc/site/0.2.0/Nucleon/Template/Wrapper.html",
    "rdoc/site/0.2.0/Nucleon/Template/YAML.html",
    "rdoc/site/0.2.0/Nucleon/Translator.html",
    "rdoc/site/0.2.0/Nucleon/Translator/JSON.html",
    "rdoc/site/0.2.0/Nucleon/Translator/YAML.html",
    "rdoc/site/0.2.0/Nucleon/Util.html",
    "rdoc/site/0.2.0/Nucleon/Util/CLI.html",
    "rdoc/site/0.2.0/Nucleon/Util/CLI/Parser.html",
    "rdoc/site/0.2.0/Nucleon/Util/Cache.html",
    "rdoc/site/0.2.0/Nucleon/Util/Console.html",
    "rdoc/site/0.2.0/Nucleon/Util/Data.html",
    "rdoc/site/0.2.0/Nucleon/Util/Disk.html",
    "rdoc/site/0.2.0/Nucleon/Util/Git.html",
    "rdoc/site/0.2.0/Nucleon/Util/Liquid.html",
    "rdoc/site/0.2.0/Nucleon/Util/Logger.html",
    "rdoc/site/0.2.0/Nucleon/Util/Package.html",
    "rdoc/site/0.2.0/Nucleon/Util/SSH.html",
    "rdoc/site/0.2.0/Nucleon/Util/SSH/Keypair.html",
    "rdoc/site/0.2.0/Nucleon/Util/Shell.html",
    "rdoc/site/0.2.0/Nucleon/Util/Shell/Result.html",
    "rdoc/site/0.2.0/README_rdoc.html",
    "rdoc/site/0.2.0/TODO_rdoc.html",
    "rdoc/site/0.2.0/created.rid",
    "rdoc/site/0.2.0/images/add.png",
    "rdoc/site/0.2.0/images/brick.png",
    "rdoc/site/0.2.0/images/brick_link.png",
    "rdoc/site/0.2.0/images/bug.png",
    "rdoc/site/0.2.0/images/bullet_black.png",
    "rdoc/site/0.2.0/images/bullet_toggle_minus.png",
    "rdoc/site/0.2.0/images/bullet_toggle_plus.png",
    "rdoc/site/0.2.0/images/date.png",
    "rdoc/site/0.2.0/images/delete.png",
    "rdoc/site/0.2.0/images/find.png",
    "rdoc/site/0.2.0/images/loadingAnimation.gif",
    "rdoc/site/0.2.0/images/macFFBgHack.png",
    "rdoc/site/0.2.0/images/package.png",
    "rdoc/site/0.2.0/images/page_green.png",
    "rdoc/site/0.2.0/images/page_white_text.png",
    "rdoc/site/0.2.0/images/page_white_width.png",
    "rdoc/site/0.2.0/images/plugin.png",
    "rdoc/site/0.2.0/images/ruby.png",
    "rdoc/site/0.2.0/images/tag_blue.png",
    "rdoc/site/0.2.0/images/tag_green.png",
    "rdoc/site/0.2.0/images/transparent.png",
    "rdoc/site/0.2.0/images/wrench.png",
    "rdoc/site/0.2.0/images/wrench_orange.png",
    "rdoc/site/0.2.0/images/zoom.png",
    "rdoc/site/0.2.0/index.html",
    "rdoc/site/0.2.0/js/darkfish.js",
    "rdoc/site/0.2.0/js/jquery.js",
    "rdoc/site/0.2.0/js/navigation.js",
    "rdoc/site/0.2.0/js/search.js",
    "rdoc/site/0.2.0/js/search_index.js",
    "rdoc/site/0.2.0/js/searcher.js",
    "rdoc/site/0.2.0/rdoc.css",
    "rdoc/site/0.2.0/table_of_contents.html",
    "spec/coral_mock_input.rb",
    "spec/coral_test_kernel.rb",
    "spec/core/util/console_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/coralnexus/nucleon"
  s.licenses = ["Apache License, Version 2.0"]
  s.rdoc_options = ["--title", "Nucleon", "--main", "README.rdoc", "--line-numbers"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.1")
  s.rubyforge_project = "nucleon"
  s.rubygems_version = "2.0.14"
  s.summary = "Framework that provides a simple foundation for building distributively configured, extremely pluggable and extendable, and easily parallel Ruby applications"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<log4r>, ["~> 1.1"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.6"])
      s.add_runtime_dependency(%q<netrc>, ["~> 0.7"])
      s.add_runtime_dependency(%q<highline>, ["~> 1.6"])
      s.add_runtime_dependency(%q<deep_merge>, ["~> 1.0"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.7"])
      s.add_runtime_dependency(%q<sshkey>, ["~> 1.6"])
      s.add_runtime_dependency(%q<childprocess>, ["~> 0.5"])
      s.add_runtime_dependency(%q<celluloid>, ["~> 0.15"])
      s.add_runtime_dependency(%q<rugged>, ["~> 0.19"])
      s.add_runtime_dependency(%q<octokit>, ["~> 2.7"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<pry>, ["~> 0.9"])
      s.add_development_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
      s.add_development_dependency(%q<pry-debugger>, ["~> 0.2"])
    else
      s.add_dependency(%q<log4r>, ["~> 1.1"])
      s.add_dependency(%q<i18n>, ["~> 0.6"])
      s.add_dependency(%q<netrc>, ["~> 0.7"])
      s.add_dependency(%q<highline>, ["~> 1.6"])
      s.add_dependency(%q<deep_merge>, ["~> 1.0"])
      s.add_dependency(%q<multi_json>, ["~> 1.7"])
      s.add_dependency(%q<sshkey>, ["~> 1.6"])
      s.add_dependency(%q<childprocess>, ["~> 0.5"])
      s.add_dependency(%q<celluloid>, ["~> 0.15"])
      s.add_dependency(%q<rugged>, ["~> 0.19"])
      s.add_dependency(%q<octokit>, ["~> 2.7"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<pry>, ["~> 0.9"])
      s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
      s.add_dependency(%q<pry-debugger>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<log4r>, ["~> 1.1"])
    s.add_dependency(%q<i18n>, ["~> 0.6"])
    s.add_dependency(%q<netrc>, ["~> 0.7"])
    s.add_dependency(%q<highline>, ["~> 1.6"])
    s.add_dependency(%q<deep_merge>, ["~> 1.0"])
    s.add_dependency(%q<multi_json>, ["~> 1.7"])
    s.add_dependency(%q<sshkey>, ["~> 1.6"])
    s.add_dependency(%q<childprocess>, ["~> 0.5"])
    s.add_dependency(%q<celluloid>, ["~> 0.15"])
    s.add_dependency(%q<rugged>, ["~> 0.19"])
    s.add_dependency(%q<octokit>, ["~> 2.7"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<pry>, ["~> 0.9"])
    s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4"])
    s.add_dependency(%q<pry-debugger>, ["~> 0.2"])
  end
end

