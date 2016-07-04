require 'itamae/secrets'
require 'pathname'
require 'pry'

def node.dig(*keys)
  keys.inject(self) do |h, k|
    h[k] or return nil
  end
end

node[:env] = (ENV['ITAMAE_ENV'] || :production).to_sym
node[:secrets] = Itamae::Secrets(File.join(__dir__, 'secrets'))

module RecipeHelper
  def include_role(name)
    Pathname.new(File.dirname(@recipe.path)).ascend do |dir|
      recipe_file = dir.join("roles", name, "default.rb")
      if recipe_file.exist?
        include_recipe(recipe_file.to_s)
        return
      end
    end

    raise "Role #{name} is not found."
  end

  def include_cookbook(name)
    names = name.split("::")
    names << "default" if names.length == 1
    names[-1] += ".rb"

    Pathname.new(File.dirname(@recipe.path)).ascend do |dir|
      recipe_file = dir.join("cookbooks", *names)
      if recipe_file.exist?
        include_recipe(recipe_file.to_s)
        return
      end
    end

    raise "Cookbook #{name} is not found."
  end
end

Itamae::Recipe::EvalContext.send(:include, RecipeHelper)

# execute "dpkg --remove-architecture i386" do
#   only_if 'dpkg --print-foreign-architectures|grep -q i386'
# end
#
# execute "dpkg --add-architecture i386" do
#   not_if 'dpkg --print-foreign-architectures|grep -q i386'
# end


execute "apt-get update" do
  action :nothing
end

define :apt_key, keyname: nil do
  name = params[:keyname] || params[:name]
  execute "apt-key #{name}" do
    command "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys #{name}"
    not_if "apt-key list | grep -q '/#{name} '"
  end
end
