module Dehenzify
  class ExtractedSource < Struct.new(:target_file_path, :source, :namespace_modules)

    attr_accessor :node

    def namespaced_source
      raw_namespaced_source = source

      namespace_modules.reverse_each.with_index(1) do |module_name, index|
        space_offset = '  ' * (namespace_modules.size - index)

        modulized_source = ''
        modulized_source << "module #{module_name}" << "\n"
        modulized_source << space_offset << '  '
        modulized_source << raw_namespaced_source << "\n"
        modulized_source << space_offset << 'end'
        raw_namespaced_source = modulized_source
      end if namespace_modules

      raw_namespaced_source << "\n" unless raw_namespaced_source.end_with?("\n")
      raw_namespaced_source
    end

    def empty?
      source.blank? || Dehenzify::Extractor.empty_node?(Parser::CurrentRuby.parse(source))
    end

    def exists?
      File.exists?(target_file_path)
    end

    def write!
      FileUtils.mkdir_p(File.dirname(target_file_path))
      File.write(target_file_path, namespaced_source)
      target_file_path
    end

    def delete!
      File.delete(target_file_path) if exists?
    end
  end
end
