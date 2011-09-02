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

module Sensors; module C

attach_function :sensors_init, [:buffer_out], :int
attach_function :sensors_cleanup, [], :void

attach_function :sensors_parse_chip_name, [:string, :pointer], :int
attach_function :sensors_free_chip_name, [:pointer], :void
attach_function :sensors_snprintf_chip_name, [:pointer, :size_t, :pointer], :int

attach_function :sensors_get_adapter_name, [:pointer], :string

attach_function :sensors_get_label, [:pointer, :pointer], :string

attach_function :sensors_get_value, [:pointer, :int, :pointer], :int
attach_function :sensors_set_value, [:pointer, :int, :double], :int

attach_function :sensors_do_chip_sets, [:pointer], :int
attach_function :sensors_get_detected_chips, [:pointer, :pointer], :pointer

attach_function :sensors_get_features, [:pointer, :pointer], :pointer

attach_function :sensors_get_all_subfeatures, [:pointer, :pointer, :pointer], :pointer
attach_function :sensors_get_subfeature, [:pointer, :pointer, SubfeatureType], :pointer

end; end
