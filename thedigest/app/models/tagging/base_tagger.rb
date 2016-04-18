module Tagging
  # This class is the parent class of all Tagging methods and it checks whether
  # its child classes has scrape method
  class BaseTagger
    def init
      validate_subclasses
    end

    private

    # Method to valid subclass implements the required methods
    def validate_subclasses
      # Validate instance methods
      unless self.respond_to?(:create_tags)
        throw Exception.new('subclass fails to implement the required \
         create_tags method')
      end
    end
  end
end
