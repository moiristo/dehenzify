module Dehenzify
  class Extractor < Parser::TreeRewriter
    def on_module(node)
      @modules << node.children.first.loc.expression.source
      super
      @modules.pop

      extract_source(node) if !namespace_module?(node) && (@source_type.nil? || @source_type == :module)
    end

    def on_class(node)
      extract_source(node) if @source_type.nil? || @source_type == :class
      # Don't descend into classes
    end

    def extract(file_path, code: nil, source_type: nil)
      @root_dir = Pathname.new(File.dirname(file_path)).join('../')
      @source_type = source_type
      @modules = []
      @extracted_sources = []

      code ||= File.read(file_path)
      ast = Parser::CurrentRuby.parse(code)

      buffer = Parser::Source::Buffer.new('')
      buffer.source = code
      new_source = rewrite(buffer, ast)

      @extracted_sources << Dehenzify::ExtractedSource.new(file_path.to_s, new_source)
      @extracted_sources
    end

    private

    def namespace_module?(node)
      last_child = node.children.last
      children =
        if last_child&.type == :begin
          last_child.children
        else
          node.children[1..-1]
        end

      (children.compact.map(&:type) - [:class, :module]).none?
    end

    def extract_source(node)
      source_models = @modules.dup

      target_dir = @root_dir.join(source_models.map(&:underscore).join('/'))
      file_name = node.children.first.loc.expression.source.underscore + '.rb'

      extracted_source = Dehenzify::ExtractedSource.new(target_dir.join(file_name).to_s, node.loc.expression.source, source_models)
      extracted_source.node = node
      @extracted_sources << extracted_source

      remove(node.loc.expression)
    end
  end
end
