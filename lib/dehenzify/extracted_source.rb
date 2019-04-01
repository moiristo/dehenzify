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

      raw_namespaced_source
    end

    def write!
      FileUtils.mkdir_p(File.dirname(target_file_path))
      File.write(target_file_path, namespaced_source)
      target_file_path
    end
  end
end
