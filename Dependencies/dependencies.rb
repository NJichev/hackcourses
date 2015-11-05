require "fileutils"
require "json"

@lib = []
@pack = JSON.parse(File.read("./all_packages.json"))
@depen = JSON.parse(File.read("./dependencies.json"))

def installMod(name)
	Dir.mkdir("installed_modules") unless File.exists?("installed_modules")
	if (isInstalled?(name.to_s))
		puts name + " is already installed."
	else
		puts "Installing " + name
		FileUtils::mkdir_p "installed_modules/" + name + "/" 
	end
end

def installDep(dep)
	if dep.any?
		dep.each do |item|
			printDep(item)
			installMod(item)
		end
	end
end

def isInstalled?(name)
	File.exists?("installed_modules/" + name + "/")
end

def printDep(lib) 
	str = "In order to use " + lib + ", we need "
	@pack.each do |name, value|
		if name == lib
			value.each do |x|
				str += x.to_s + " "
			end
		end
	end
	puts str
end

def install()
	@pack.each do |lib|
		@lib.push(lib)
	end
	
	installNext()
end

def installNext()
	@lib.each do |element|
		installMod(element[0])
		installDep(element[1])
	end
	puts "All done."
end

install()
