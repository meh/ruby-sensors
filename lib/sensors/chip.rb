#--
# Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
# 
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
# 
#    1. Redistributions of source code must retain the above copyright notice, this list of
#       conditions and the following disclaimer.
# 
#    2. Redistributions in binary form must reproduce the above copyright notice, this list
#       of conditions and the following disclaimer in the documentation and/or other materials
#       provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY meh ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL meh OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied.
#++

require 'sensors/feature'
require 'sensors/subfeature'

module Sensors

class Chip
	attr_reader :name

	def initialize (name=nil)
		if name.is_a?(C::ChipName) || name.is_a?(FFI::Pointer)
			@chip_name = name.is_a?(C::ChipName) ? name : C::ChipName.new(name)
			name       = nil
		else
			@chip_name = C::ChipName.new
			C::sensors_parse_chip_name(name, @chip_name)

			ObjectSpace.define_finalizer self, Chip.finalizer(@chip_name.pointer)
		end

		FFI::MemoryPointer.new(512).tap {|pointer|
			@name = if C::sensors_snprintf_chip_name(pointer, 512, to_ffi) < 0
				name
			else
				pointer.typecast(:string)
			end
		}
	end

	def self.finalizer (pointer)
		proc {
			C::sensors_free_chip_name(pointer)
		}
	end

	def features
		Enumerator.new do |e|
			number = FFI::MemoryPointer.new :int

			until (feature = C::sensors_get_features(to_ffi, number)).null?
				e << Feature.new(self, feature)
			end
		end
	end

	alias to_s name

	def inspect
		"#<Chip: #{name || 'unknown'}>"
	end

	def to_ffi
		@chip_name
	end
end

end
