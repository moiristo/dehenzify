module Dehenzify
  class ExtractClass < Parser::AST::Processor
    def on_module(node)
      @modules << node.children.first.loc.expression.source
      super
    end

    def on_class(node)
      target_dir = @root_dir.join(@modules.map(&:underscore).join('/'))
      file_name = node.children.first.loc.expression.source.underscore + '.rb'
      file_path = target_dir.join(file_name)
      source = node.loc.expression.source

      @modules.reverse_each do |module_name|
        source = <<-SOURCE
          module #{module_name}
            #{source}
          end
        SOURCE
      end

      unless File.exist?(file_path)
        FileUtils.mkdir_p(target_dir)
        File.write(file_path, source)
        RuboCop::CLI.new.run(['--auto-correct', '--out', '/dev/null', file_path.to_s])
        @dehenzify_performed = true
      end
    end

    def extract(source_dir, ast)
      @root_dir = source_dir.join('../')
      @modules = []
      @dehenzify_performed = false
      process(ast)
      @dehenzify_performed
    end
  end
end
