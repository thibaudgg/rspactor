module RSpactor
  module Inspector
    class << self
      attr_reader :spec_paths
      
      def determine_spec_paths(files)
        @spec_paths, @spec_files = [], nil
        files.each { |file| translate(file) }
        compact_spec_paths!
      end
      
      def spec_paths?
        @spec_paths.size > 0
      end
      
    private
      
      def translate(file)
        if spec_file?(file)
          @spec_paths << file
        else
          spec_file = append_spec_file_extension(file)
          case file
          when %r:^lib/:
            @spec_paths << @spec_files.delete(spec_file.gsub(/^lib/, 'spec'))
            @spec_paths << @spec_files.delete(spec_file.gsub(/^lib/, 'spec/lib'))
          when %r:^app/:
            @spec_paths << @spec_files.delete(spec_file.gsub(/^app/, 'spec'))
          end
        end
      end
      
      def compact_spec_paths!
        @spec_paths.uniq!
        @spec_paths.compact!
      end
      
      def spec_file?(file)
        spec_files.include?(file)
      end
      
      def spec_files
        @spec_files ||= Dir.glob("spec/**/*_spec.rb")
      end
      
      def append_spec_file_extension(file)
        file.sub(/(\..*)$/, "_spec.rb")
      end
      
    end
  end
end