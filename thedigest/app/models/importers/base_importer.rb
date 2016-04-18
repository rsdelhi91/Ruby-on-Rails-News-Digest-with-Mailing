module Importers
  # This class is the parent class of all importers and it checks whether
  # its child classes has scrape method
  class BaseImporter
    def init
      @articles = []
      validate_subclasses
    end

    private

    # Method to valid subclass implements the required methods
    def validate_subclasses
      # Validate instance methods
      unless self.respond_to?(:scrape)
        throw Exception.new('subclass fails to implement the required scrape \
         method')
      end

      # Validate class methods
      unless self.class.respond_to?(:source_name)
        throw Exception.new('subclass fails to provide source_name')
      end
    end
  end
end
