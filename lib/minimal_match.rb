module MinimalMatch
  module ProxyOperators
    # it's easier to just set this directly on these objects
    # rather than to construct the heuristic for determining
    # the classification and having to update it when
    # we want to add new operators
    def is_proxy? obj
      obj.instance_variable_get :@is_proxy
    end

    def is_match_op? obj
      obj.instance_variable_get :@is_match_op
    end
    #because i keep typing it wrong
    alias :is_match_obj? :is_match_op?

    def is_group? obj
      obj.instance_variable_get :@is_group
    end
  end
  extend ProxyOperators

  def m(*args,&block)
    raise ArgumentError, "Wrong number of arguments 0 for ..." if args.empty?
    if block_given?
      raise ArgumentError, "Block supplied - didn't expect arguments" unless args.empty?
      MinimalMatch::MatchProxy.new(&block)
    else
      if args.length == 1 || args.nil?
        val = args.nil? ? nil : args[0]
        MinimalMatch::MatchProxy.new(val)
      else
        MinimalMatch::MatchProxyGroup.new(*args)
      end
    end
  end
  module_function :m
    
end

require 'minimal_match/minimal_match'
require 'minimal_match/minimal_search'

#remove this!
require 'minimal_match/kernel'

