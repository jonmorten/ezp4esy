class Color
	@@colors = {
		:default => "\e[0m",
		:cyan => "\e[1;36;40m",
		:darkcyan => "\e[0;36;40m",
		:darkgreen => "\e[0;32;40m",
		:darkred => "\e[0;31;40m",
		:darkyellow => "\e[0;33;40m",
		:green => "\e[1;32;40m",
		:red => "\e[1;31;40m",
		:yellow => "\e[1;33;40m",
	}

	def self.set(key)
		raise ArgumentError, ":#{color} is not set" unless @@colors.key?(key)
		return @@colors[key]
	end
end

class String
	def color(key)
		return Color.set(key) + self + Color.set(:default)
	end
end

class Cli
	def self.input(message)
		print (message + "\n> ").color(:darkyellow)
		return gets.chomp
	end

	def self.input_boolean(message)
		while true
			case self.input message + ' [y/n]'
			when /y.*/
				value = true
				break
			when /n.*/
				value = false
				break
			end
		end
		return value
	end

	def self.input_pattern(message, pattern)
		while true
			value = self.input message
			unless (value =~ pattern).nil?
				break
			end
		end
		return value
	end

	def self.input_until(message, pattern, return_empty = false)
		values = []
		while true
			value = self.input message
			unless (value =~ pattern).nil?
				if values.length > 0 || return_empty
					break
				end
			else
				values << value
			end
			values.uniq!
			puts values.inspect.color(:darkyellow)
		end
		return values
	end
end
