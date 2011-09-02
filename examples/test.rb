require 'sensors'
require 'ap'

ap Hash[Sensors.chips.map {|chip|
  [chip.name, Hash[chip.features.map {|feature|
    [feature.label, Hash[feature.subfeatures.map {|subfeature|
      [subfeature.name, subfeature.value]
    }]]
  }]]
}]
