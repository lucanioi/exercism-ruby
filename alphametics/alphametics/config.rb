module Alphametics
  Config = Struct.new(:iterations, :pool_size, :selection_size,
                      :survivor_count, :random_count, keyword_init: true) do
    def to_s
      "<Config>\n" \
      "iterations:     #{iterations}\n" \
      "pool size:      #{pool_size}\n" \
      "selection size: #{selection_size}\n" \
      "survivor count: #{survivor_count}\n" \
      "random count:   #{random_count}"
    end
  end
end
