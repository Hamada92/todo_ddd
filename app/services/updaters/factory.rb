module Updaters
  class Factory
    KLASSES = [
      Updaters::Task,
      #Article (in future)
    ]

    def self.build(object, params, full_tag_replacement: false)
      updater = KLASSES.detect { |klass| klass.class_type_matches?(object) }
      updater.new(object.id, params, full_tag_replacement: full_tag_replacement)
    end
  end
end
