#TODO: figure out why it installs dependencies in reverse
require "fileutils"
require "json"

@lib = []
@pack = JSON.parse(File.read("./all_packages.json"))
@depen = JSON.parse(File.read("./dependencies.json"))

def installMod(name)
	Dir.mkdir("installed_modules") unless File.exists?("installed_modules")
	if (isInstalled?(name))
		puts name + " is already installed."
	else
		puts "Installing " + name + "."
		FileUtils::mkdir_p "installed_modules/" + name + "/" 
		printDep(name) unless @pack[name].to_s == "[]"
	end
end

def isInstalled?(name)
	File.exists?("installed_modules/" + name + "/")
end

def addDep(name, index)
	@pack[name].each do |item|
		@lib.insert(index+1, item)
		index+=1
	end
end

def printDep(lib) 
	str = "In order to use " + lib + ", we need "
	@pack.each do |name, value|
		if name == lib
			value.each do |x|
				str += x.to_s + ", "
			end
		end
	end
	str = str.chomp(", ") + "." #Change , with .
	puts str
end

def initializeDependencies(dependencies)
	@depen[dependencies].each do |name|
		@lib.push(name) unless @lib.include?(name)
	end
	if @lib.all?{|x| isInstalled?(x)}
		@lib.each do |item|
			installMod(item)
		end
		puts "All done."
	else
		install()
	end
end

def install()
	@lib.each do |item|
		installMod(item)
		addDep(item, @lib.find_index(item))
	end
	puts "All done."
end

initializeDependencies("dependencies")
