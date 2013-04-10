module Functional

  module PreludeMeta

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods

      def create_proc_method(c, f, i=:f)
        if Proc === f
          define_method("#{c}_#{i}_proc", f)
          return "#{c}_#{i}_proc"
        else
          return f
        end
      end

      def define_v1(c, definition)
        key, value = definition[:as].first
        self.send(key, c, *value)
      end

      def define_v2(definition, name)
        key, value = definition
        self.send(key, name, *value)
      end

      def define(*params)
        if Symbol === params[0]
          define_v1(*params)
        else
          name = params[0].delete(:as)
          define_v2(*params[0], name)
        end
      end

      def compose(c, f, g)
        m = create_proc_method(c, f, :f)
        n = create_proc_method(c, g, :g)
        code = %Q{
        def #{c}(x)
          #{m}(#{n}(x))
        end
      }
        module_eval(code)
      end

      alias :def_compose :compose

      def after(c, f, g)
        compose(c, g, f)
      end

      alias :def_after :after

      def parallel(c, f, g)
        m = create_proc_method(c, f, :f)
        n = create_proc_method(c, g, :g)
        code = %Q{
        def #{c}(x)
          [#{m}(x),#{n}(x)]
        end
      }
        module_eval(code)
      end

      alias :def_parallel :parallel

      def foldl(c, f, i)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.inject(#{i}) { |r, x| #{m}(r,x) }
        end
      }
        module_eval(code)
      end

      alias :def_foldl :foldl

      def reduce_left(c, f)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.inject { |r, x| #{m}(r,x) }
        end
      }
        module_eval(code)
      end

      alias :def_reduce_left :reduce_left

      def foldr(c, f, i)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.reverse.inject(#{i}) { |r, x| #{m}(r,x) }
        end
      }
        module_eval(code)
      end

      alias :def_foldr :foldr

      def reduce_right(c, f)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.reverse.inject { |r, x| #{m}(r,x) }
        end
      }
        module_eval(code)
      end

      alias :def_reduce_right :reduce_right

      def map(c, f)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.map { |x| #{m}(x) }
        end
      }
        module_eval(code)
      end

      alias :def_map :map

      def filter(c, f)
        m = create_proc_method(c, f)
        code = %Q{
        def #{c}(arr)
          arr.select { |x| #{m}(x) }
        end
      }
        module_eval(code)
      end

      alias :def_filter :filter

      def method(m)
        code = %Q{
        def #{m}(o)
          o.#{m}
        end
      }
        module_eval(code)
      end

      alias :def_method :method

    end

    def m(method)
      lambda(&method(method))
    end

    def f(f)
      Symbol === f ? f = m(f) : f
    end

    def id(x)
      x
    end

    def const(c, x)
      c
    end

    def split_in(xs, n)
      xs.each_slice((xs.length+1)/n).to_a
    end

    def split_in_half(xs)
      split_in(xs, 2)
    end

    def merge(xs, ys, &by)

      return xs if ys.empty?
      return ys if xs.empty?

      x, *xt = xs
      y, *yt = ys

      return merge(xt, ys, &by) >> x if block_given? ? by.(x) <= by.(y) : x <= y
      return merge(xs, yt, &by) >> y

    end

    def merge_sort(xs, &by)
      return xs if xs.length <= 1 # stopcondition
      left, right = split_in_half(xs)
      merge(merge_sort(left, &by), merge_sort(right, &by), &by)
    end

    def quick_sort(list)
      return [] if list.size == 0
      pivot, *xs = *list
      less, more = xs.partition { |y| y < pivot }
      quick_sort(less) + [pivot] + quick_sort(more)
    end

    def compose(f, g, x)
      f = f(f)
      g = f(g)
      f.(g.(x))
    end

    def after(f, g, x)
      f = f(f)
      g = f(g)
      return g.(par(*f, x)) if Array === f && Proc === g
      return par(*g, f.(x)) if Proc === f && Array === g
      return par(*g, par(*f, x)) if Array === f && Array === g
      return g.(f.(x)) # else
    end

    extend ClassMethods

    def_method :flatten

    #def flatten(a)
    #  a.flatten
    #end

    def_method :length

    #def length(a)
    #  a.length
    #end

    def_method :reverse

    #def reverse(a)
    #  a.reverse
    #end

    def foldl(f, i, a)
      a.inject(i) { |r, x| f(f).(r, x) }
    end

    def foldr(f, i, a)
      foldl(f(f), i, a.reverse)
    end

    def zip(a, b)
      a.zip(b)
    end

    def map(a, f)
      a.map { |x| f(f).(x) }
    end

    def filter(a, f)
      a.select { |x| f(f).(x) }
    end

    def sum(a)
      a.inject(0, :+)
    end

    def parallel(f, g, x)
      [f(f).(x), f(g).(x)]
    end

    def par(*fs, x)
      fs.map { |f| f(f).(x) }
    end

    # TODO write with operator :& ?
    # def_reduce_left :intersect, ->(a,b) { a&b } # short
    # reduce_left :intersect, ->(a,b) { a&b } # longer
    define :intersect, as: {reduce_left: ->(a, b) { a&b }} # longest

    def_method :min

    def_method :max

    def from_to(from, to)
      Range.new(from, to)
    end

    def from_one_to(to)
      Range.new(1, to)
    end

  end

end


