module Cell
  autoload :Caching, 'cell/caching'
  
  extend ActiveSupport::Concern
  
  DEFAULT_VIEW_PATHS = [File.join('app', 'cells')]
  
  module ClassMethods
    # Called in Railtie at initialization time.
    def setup_view_paths!
      self.view_paths = self::DEFAULT_VIEW_PATHS
    end
    
    # Main entry point for #render_cell.
    def render_cell_for(controller, name, state, *args)
      cell = create_cell_for(controller, name, *args)
      yield cell if block_given?
      
      cell.render_state(state, *args)
    end
  end
end
