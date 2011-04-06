module MinimalMatch
  # provides introspect capabilities for matchobject heirarcy
  class MinimalMatchObject < BasicObject
    def class
      class << self
        self.superclass
      end
    end
    
    def initialize
      @class_name = self.class.to_s.split('::')[-1].upcase
      @ancestry = []
      superclass = self.class
      while superclass do
        @ancestry << superclass if superclass
        superclass = superclass.superclass
      end
      @ancestry.uniq!
    end
    
    def kind_of? klass
      @ancestry.include? klass
    end

    def respond_to? meth
      #singleton class calls this for some reason.
      self.class.instance_methods.include? meth
    end

    def is_a? klass 
      self.class == klass
    end
    
    def inspect
      "<#{@class_name}>"
    end
    alias :to_s :inspect
  end
  # since you can't look up the module from that scope
  MinimalMatchObject.send :include, Kernel # so you can raise, etc
end 
#  vim: set ts=2 sw=2 tw=0 :
