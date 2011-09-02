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

# :string, :libsensors_version # TODO: look how to get an extern var

BusType = FFI::Enum.new([
	:any, -1,
	:i2c,
	:isa,
	:pci,
	:spi,
	:virtual,
	:acpi,
	:hid
])

module BusNumber
	Any    = -1
	Ignore = -2
end

class BusId < FFI::Struct
  layout \
    :type, :short,
    :nr,   :short
end

class ChipName < FFI::Struct
  layout \
    :prefix, :string,
    :bus,    BusId,
    :addr,   :int,
    :path,   :string
end

FeatureType = FFI::Enum.new([
  :in,          0x00,
	:fan,         0x01,
  :temp,        0x02,
  :power,       0x03,
  :energy,      0x04,
  :curr,        0x05,
  :humidity,    0x06,
  :max_main,
  :vid,         0x10,
  :intrusion,   0x11,
  :max_other,
  :beep_enable, 0x18
#  :unknown,     INT_MAX
])

SubfeatureType = FFI::Enum.new([
	:in_input, FeatureType[:in] << 8,
	:in_min,
	:in_max,
	:in_lcrit,
	:in_crit,
	:in_alarm, (FeatureType[:in] << 8) | 0x80,
	:in_min_alarm,
	:in_max_alarm,
	:in_beep,
	:in_lcrit_alarm,
	:in_crit_alarm,

	:fan_input, FeatureType[:fan] << 8,
	:fan_min,
	:fan_alarm, (FeatureType[:fan] << 8) | 0x80,
	:fan_fault,
	:fan_div,
	:fan_beep,
	:fan_pulses,

	:temp_input, FeatureType[:temp] << 8,
	:temp_max,
	:temp_max_hyst,
	:temp_min,
	:temp_crit,
	:temp_crit_hyst,
	:temp_lcrit,
	:temp_emergency,
	:temp_emergency_hist,
	:temp_alarm, (FeatureType[:temp] << 8) | 0x80,
	:temp_max_alarm,
	:temp_min_alarm,
	:temp_crit_alarm,
	:temp_fault,
	:temp_type,
	:temp_offset,
	:temp_beep,
	:temp_emergency_alarm,
	:temp_lcrit_alarm,

	:power_average, FeatureType[:power] << 8,
	:power_average_highest,
	:power_average_lowest,
	:power_input,
	:power_input_highest,
	:power_input_lowest,
	:power_cap,
	:power_cap_hyst,
	:power_max,
	:power_crit,
	:power_average_interval, (FeatureType[:power] << 8) | 0x80,
	:power_alarm,
	:power_cap_alarm,
	:power_max_alarm,
	:power_crit_alarm,

	:energy_input, FeatureType[:energy] << 8,

	:curr_input, FeatureType[:curr] << 8,
	:curr_min,
	:curr_max,
	:curr_lcrit,
	:curr_crit,
	:curr_alarm, (FeatureType[:curr] << 8) | 0x80,
	:curr_min_alarm,
	:curr_max_alarm,
	:curr_beep,
	:curr_lcrit_alarm,
	:curr_crit_alarm,

	:humidity_input, FeatureType[:humidity] << 8,

	:vid, FeatureType[:vid] << 8,

	:intrusion_alarm, FeatureType[:intrusion] << 8,
	:intrusion_beep

#	:unknown, INT_MAX
])

class Feature < FFI::Struct
	layout \
		:name,    :string,
		:number,  :int,
		:type,    FeatureType,
		:mapping, :int,
		:flags,   :uint
end

class Subfeature < FFI::Struct
	layout \
		:name,    :string,
		:number,  :int,
		:type,    SubfeatureType,
		:mapping, :int,
		:flags,   :uint
end

end; end
