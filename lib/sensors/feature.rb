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

module Sensors

class Feature
	attr_reader :chip, :label

	def initialize (chip, pointer)
		@chip  = chip
		@value = pointer.is_a?(C::Feature) ? pointer : C::Feature.new(pointer)

		@label = C::sensors_get_label(chip.to_ffi, to_ffi)
	end

	C::Feature.layout.members.each {|name|
    define_method name do
      @value[name]
    end
  }

	def subfeature (type)
		Subfeature.new(self, C::sensors_get_subfeature(chip.to_ffi, to_ffi, C::SubfeatureType["#{feature.type}_#{type.downcase}".to_sym]))
	end

	def subfeatures
		Enumerator.new do |e|
			number = FFI::MemoryPointer.new :int

			until (subfeature = C::sensors_get_all_subfeatures(chip.to_ffi, to_ffi, number)).null?
				e << Subfeature.new(self, subfeature)
			end
		end
	end

	alias to_s name

	def to_ffi
		@value
	end
end

end
